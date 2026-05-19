import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/dealer_message.dart';

abstract class DealerChatService {
  static const String testEmail = 'test@carstore.dev';
  static const String testPassword = 'carstore123';

  bool get supportsEmailPasswordAuth => false;

  Future<String?> signIn(String emailOrName, String password);

  Future<String?> signUp(String emailOrName, String password);

  Future<void> signOut();

  Stream<List<DealerMessage>> watchMessages();

  Future<void> sendMessage(String text);

  void dispose() {}
}

class LocalDealerChatService extends DealerChatService {
  LocalDealerChatService({required SharedPreferences preferences})
    : _preferences = preferences {
    _restoreFromPreferences();
  }

  static const _prefMessagesKey = 'advisorChatMessages';
  static const _prefDriverNameKey = 'advisorChatDriverName';
  static const _prefDriverIdKey = 'advisorChatDriverId';

  final SharedPreferences _preferences;
  final _controller = StreamController<List<DealerMessage>>.broadcast();
  final List<DealerMessage> _messages = <DealerMessage>[];

  String _driverName = 'Driver';
  String _driverId = 'local-driver';

  @override
  Future<String?> signIn(String emailOrName, String password) async {
    _driverName = emailOrName.trim().isEmpty ? 'Driver' : emailOrName.trim();
    _driverId = _driverIdFromName(_driverName);
    await _preferences.setString(_prefDriverNameKey, _driverName);
    await _preferences.setString(_prefDriverIdKey, _driverId);
    return null;
  }

  @override
  Future<String?> signUp(String emailOrName, String password) {
    return signIn(emailOrName, password);
  }

  @override
  Future<void> signOut() async {}

  @override
  Stream<List<DealerMessage>> watchMessages() async* {
    yield List.unmodifiable(_messages);
    yield* _controller.stream;
  }

  @override
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    _messages.insert(
      0,
      DealerMessage(
        date: DateTime.now(),
        senderId: _driverId,
        senderName: _driverName,
        text: trimmed,
      ),
    );
    _messages.insert(
      0,
      DealerMessage(
        date: DateTime.now(),
        senderId: 'advisor',
        senderName: 'CarStore Advisor',
        text: 'Got it. I can help with availability, financing, or delivery.',
      ),
    );
    await _persistMessages();
    _controller.add(List.unmodifiable(_messages));
  }

  @override
  void dispose() {
    _controller.close();
  }

  void _restoreFromPreferences() {
    final savedDriverName = _preferences.getString(_prefDriverNameKey);
    if (savedDriverName != null && savedDriverName.trim().isNotEmpty) {
      _driverName = savedDriverName.trim();
    }

    final savedDriverId = _preferences.getString(_prefDriverIdKey);
    if (savedDriverId != null && savedDriverId.trim().isNotEmpty) {
      _driverId = savedDriverId.trim();
    } else {
      _driverId = _driverIdFromName(_driverName);
    }

    final savedMessages = _preferences.getString(_prefMessagesKey);
    if (savedMessages != null && savedMessages.isNotEmpty) {
      final restored = _decodeMessages(savedMessages);
      if (restored.isNotEmpty) {
        _messages
          ..clear()
          ..addAll(restored);
      }
    }

    if (_messages.isEmpty) {
      _messages.add(_welcomeMessage());
      unawaited(_persistMessages());
    }
  }

  DealerMessage _welcomeMessage() {
    return DealerMessage(
      date: DateTime.now().subtract(const Duration(minutes: 8)),
      senderId: 'advisor',
      senderName: 'CarStore Advisor',
      text: 'Welcome back. Ask me about inventory, delivery, or financing.',
    );
  }

  Future<void> _persistMessages() async {
    final payload = jsonEncode(
      _messages.map((message) => message.toLocalJson()).toList(),
    );
    await _preferences.setString(_prefMessagesKey, payload);
  }

  List<DealerMessage> _decodeMessages(String encoded) {
    try {
      final decoded = jsonDecode(encoded);
      if (decoded is List) {
        final messages = <DealerMessage>[];
        for (final entry in decoded) {
          final map = _jsonMap(entry);
          if (map != null) {
            messages.add(DealerMessage.fromLocalJson(map));
          }
        }
        return messages;
      }
    } catch (_) {}

    return const <DealerMessage>[];
  }

  Map<String, dynamic>? _jsonMap(Object? value) {
    if (value is! Map) {
      return null;
    }

    return value.map((key, mapValue) => MapEntry('$key', mapValue));
  }

  String _driverIdFromName(String name) {
    final trimmed = name.trim();
    final normalized = trimmed.isEmpty ? 'driver' : trimmed.toLowerCase();
    final slug = normalized.replaceAll(RegExp(r'\s+'), '-');
    return 'local-$slug';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/dealer_message.dart';
import 'dealer_chat_service.dart';

class FirebaseDealerChatService extends DealerChatService {
  FirebaseDealerChatService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  String _displayName = 'Driver';

  CollectionReference get _collection =>
      _firestore.collection('dealerMessages');

  @override
  bool get supportsEmailPasswordAuth => true;

  @override
  Future<String?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _displayName = _displayNameFromEmail(credential.user?.email ?? email);
      return null;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found' && _isTestAccount(email, password)) {
        return _createTestAccount(email, password);
      }
      return _messageForAuthError(error);
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Future<String?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _displayName = _displayNameFromEmail(credential.user?.email ?? email);
      return null;
    } on FirebaseAuthException catch (error) {
      return _messageForAuthError(error);
    } catch (error) {
      return error.toString();
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Stream<List<DealerMessage>> watchMessages() {
    return _collection.orderBy('date', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map(DealerMessage.fromSnapshot)
          .toList(growable: false);
    });
  }

  @override
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    final user = _auth.currentUser;
    if (trimmed.isEmpty || user == null) {
      return;
    }

    await _collection.add(
      DealerMessage(
        date: DateTime.now(),
        senderId: user.uid,
        senderName: _displayName,
        text: trimmed,
      ).toJson(),
    );
  }

  bool _isTestAccount(String email, String password) {
    return email.trim().toLowerCase() ==
            DealerChatService.testEmail.toLowerCase() &&
        password == DealerChatService.testPassword;
  }

  Future<String?> _createTestAccount(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _displayName = _displayNameFromEmail(credential.user?.email ?? email);
      return null;
    } on FirebaseAuthException catch (error) {
      return _messageForAuthError(error);
    } catch (error) {
      return error.toString();
    }
  }

  String _displayNameFromEmail(String email) {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      return 'Driver';
    }
    return trimmed.split('@').first;
  }

  String _messageForAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled in Firebase.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'weak-password':
        return 'The password provided is too weak.';
      default:
        return error.message ?? 'Unable to authenticate.';
    }
  }
}

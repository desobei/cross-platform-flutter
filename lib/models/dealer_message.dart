import 'package:cloud_firestore/cloud_firestore.dart';

class DealerMessage {
  DealerMessage({
    required this.date,
    required this.senderId,
    required this.senderName,
    required this.text,
    this.reference,
  });

  final DateTime date;
  final String senderId;
  final String senderName;
  final String text;
  DocumentReference? reference;

  factory DealerMessage.fromJson(Map<String, dynamic> json) {
    return DealerMessage(
      date: (json['date'] as Timestamp).toDate(),
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      text: json['text'] as String,
    );
  }

  factory DealerMessage.fromLocalJson(Map<String, dynamic> json) {
    final rawDate = json['date'];
    DateTime parsedDate;

    if (rawDate is int) {
      parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate);
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return DealerMessage(
      date: parsedDate,
      senderId: (json['senderId'] as String?) ?? 'unknown',
      senderName: (json['senderName'] as String?) ?? 'Driver',
      text: (json['text'] as String?) ?? '',
    );
  }

  factory DealerMessage.fromSnapshot(DocumentSnapshot snapshot) {
    final message = DealerMessage.fromJson(
      snapshot.data() as Map<String, dynamic>,
    );
    message.reference = snapshot.reference;
    return message;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
    };
  }

  Map<String, Object?> toLocalJson() {
    return {
      'date': date.millisecondsSinceEpoch,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
    };
  }
}

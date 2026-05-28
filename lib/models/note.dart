import 'dart:convert';

class Note {
  final int? id;
  final String uuid;
  final String? firebaseId;
  final String title;
  final Map<String, dynamic>? document;
  final String preview;
  final bool pendingSync;
  final DateTime? pinnedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    required this.uuid,
    this.firebaseId,
    required this.title,
    required this.document,
    required this.preview,
    required this.pendingSync,
    required this.pinnedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPinned => pinnedAt != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'firebase_id': firebaseId,
      'title': title,
      'document': document != null ? jsonEncode(document) : null,
      'preview': preview,
      'pending_sync': pendingSync ? 1 : 0,
      'pinned_at': pinnedAt?.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      uuid: map['uuid'],
      firebaseId: map['firebase_id'],
      title: map['title'] ?? '',
      document: map['document'] != null ? jsonDecode(map['document']) : null,
      preview: map['preview'] ?? '',
      pendingSync: map['pending_sync'] == 1,
      pinnedAt: map['pinned_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['pinned_at'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Note copyWith({
    int? id,
    String? uuid,
    String? firebaseId,
    String? title,
    Map<String, dynamic>? document,
    String? preview,
    bool? pendingSync,
    DateTime? pinnedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      firebaseId: firebaseId ?? this.firebaseId,
      title: title ?? this.title,
      document: document ?? this.document,
      preview: preview ?? this.preview,
      pendingSync: pendingSync ?? this.pendingSync,
      pinnedAt: pinnedAt ?? this.pinnedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

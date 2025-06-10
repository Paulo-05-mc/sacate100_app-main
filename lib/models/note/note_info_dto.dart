class NoteInfoDto {
  final int id;
  final String title;
  final String content;
  final DateTime uploadedAt;
  final String uploadedbyEmail;

  NoteInfoDto({
    required this.id,
    required this.title,
    required this.content,
    required this.uploadedAt,
    required this.uploadedbyEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'uploadedAt': uploadedAt.toIso8601String(),
      'uploadedbyEmail': uploadedbyEmail,
    };
  }

  factory NoteInfoDto.fromJson(Map<String, dynamic> json) {
    return NoteInfoDto(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      uploadedbyEmail: json['uploadedbyEmail'] as String,
    );
  }

}
class NoteCreateDto {
  final String title;
  final String content;

  NoteCreateDto({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory NoteCreateDto.fromJson(Map<String, dynamic> json) {
    return NoteCreateDto(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
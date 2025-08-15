class PostDTO {
  final int userId;
  final int id;
  final String? title;
  final String? body;

  PostDTO({required this.userId, required this.id, this.title, this.body});

  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  static List<PostDTO> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PostDTO.fromJson(json)).toList();
  }
}

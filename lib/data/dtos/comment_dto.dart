class CommentDTO {
  final int postId;
  final int id;
  final String? name;
  final String? email;
  final String? body;

  CommentDTO({
    required this.postId,
    required this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentDTO.fromJson(dynamic json) => CommentDTO(
    postId: json['postId'],
    id: json['id'],
    name: json['name'],
    email: json['email'],
    body: json['body'],
  );

  static List<CommentDTO> fromJsonList(List<dynamic> comments) =>
      comments.map((comment) => CommentDTO.fromJson(comment)).toList();
}

class Note {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isFavorite: json['is_favorite'] == true,
      createdAt: DateTime.parse(json['created_at'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'is_favorite': isFavorite,
    };
  }
}

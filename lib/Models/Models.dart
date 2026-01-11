// Models
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
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
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
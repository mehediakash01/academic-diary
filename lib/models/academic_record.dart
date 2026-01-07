class AcademicRecord {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime createdAt;

  AcademicRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.createdAt,
  });

  factory AcademicRecord.fromMap(Map<String, dynamic> map) {
    return AcademicRecord(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      type: map['type'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
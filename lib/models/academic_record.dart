class AcademicRecord {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime createdAt;
  final DateTime? deadline; // New field

  AcademicRecord({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.createdAt,
    this.deadline,
  });

  factory AcademicRecord.fromMap(Map<String, dynamic> map) {
    return AcademicRecord(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      type: map['type'],
      createdAt: DateTime.parse(map['created_at']),
      deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
    );
  }

  // Helper method to check if overdue
  bool get isOverdue {
    if (deadline == null) return false;
    return deadline!.isBefore(DateTime.now());
  }

  // Helper method to get days until deadline
  int? get daysUntilDeadline {
    if (deadline == null) return null;
    return deadline!.difference(DateTime.now()).inDays;
  }
}
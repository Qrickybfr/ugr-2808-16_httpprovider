class StudentGrade {
  final int id; 
  final String subject;
  final bool isPassed;

  StudentGrade({
    required this.id,
    required this.subject,
    required this.isPassed,
  });

  factory StudentGrade.fromJson(Map<String, dynamic> json) {
    return StudentGrade(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? 'No Subject',
      isPassed: json['isPassed'] ?? false,
    );
  }

  factory StudentGrade.fromTodoJson(Map<String, dynamic> json) {
    return StudentGrade(
      id: json['id'] ?? 0,
      subject: json['todo'] ?? 'No Subject',
      isPassed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'isPassed': isPassed,
    };
  }
}
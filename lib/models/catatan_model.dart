class CatatanHarian {
  final int? id;
  final String? title;
  final String? description;
  final String? date;

  CatatanHarian({this.id, this.title, this.description, this.date});

  factory CatatanHarian.fromJson(Map<String, dynamic> json) {
    return CatatanHarian(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }
}

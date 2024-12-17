class Gesture {
  final String id;
  final String name;
  final String description;

  Gesture({required this.id, required this.name, required this.description});

  factory Gesture.fromJson(Map<String, dynamic> json) {
    return Gesture(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

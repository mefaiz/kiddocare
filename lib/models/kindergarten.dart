// kindergarten model
class Kindergarten {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String city;
  final String state;
  final String contactPerson;
  final String contactNo;

  Kindergarten({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.city,
    required this.state,
    required this.contactPerson,
    required this.contactNo,
  });

  factory Kindergarten.fromJson(Map<String, dynamic> json) {
    return Kindergarten(
      id: int.parse(json['id']), // Convert string ID to int
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      contactPerson: json['contact_person'] as String,
      contactNo: json['contact_no'] as String,
    );
  }
} 
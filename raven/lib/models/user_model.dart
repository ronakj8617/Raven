class User {
  int id;
  String name;
  String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Map toJson(User user) => {
        'sender': {'name': user.name, 'id': user.id, 'imageUrl': user.imageUrl}
      };

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['imageUrl'];
}

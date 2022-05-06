class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  Map toJson(User user) => {
        'sender': {'name': user.name, 'id': user.id, 'imageUrl': user.imageUrl}
      };
}

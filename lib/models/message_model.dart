import './user_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  late bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });

  Map toJson(Message message) => {
        'sender': {
          'name': sender.name,
          'id': sender.id,
          'imageUrl': sender.imageUrl
        },
        'time': message.time,
        'text': message.text,
        'isLiked': message.isLiked,
        'unread': message.unread,
      };

  factory Message.fromJson(Map<Object?, Object?> data) {
    // note the explicit cast to String
    // this is required if robust lint rules are enabled
    final sender = data['sender'] as User;
    final time = data['time'] as String;
    final text = data['text'] as String;
    final isLiked = data['isLiked'] as bool;
    final unread = data['unread'] as bool;
    return Message(isLiked: isLiked,sender: sender,text: text,time: time,unread: unread);
  }
}

// YOU - current user

final User currentUser = User(
  id: 0,
  name: 'Sam',
  imageUrl: 'assets/sam.jpg',
);

final User jacob = User(
  id: 1,
  name: 'Jacob',
  imageUrl: 'assets/Jacob.jpg',
);
final User patrick = User(
  id: 2,
  name: 'Patrick',
  imageUrl: 'assets/Patrick.jpg',
);
final User sam = User(
  id: 3,
  name: 'Ronak',
  imageUrl: 'assets/sam.jpg',
);
final User phoebe = User(
  id: 4,
  name: 'Phoebe',
  imageUrl: 'assets/Phoebe.jpg',
);
final User rosalie = User(
  id: 5,
  name: 'Rosalie',
  imageUrl: 'assets/Rosalie.jpeg',
);
final User joey = User(
  id: 6,
  name: 'Joey',
  imageUrl: 'assets/Joey.jpg',
);

// FAVORITE CONTACTS
List<User> favorites = [jacob, patrick, sam, phoebe, rosalie, joey];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: jacob,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: phoebe,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: patrick,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: rosalie,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sam,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: joey,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: jacob,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: jacob,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: jacob,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: jacob,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];

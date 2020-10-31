import 'package:mun_care_app/models/user.dart';
class Message {
  final User sender;
  final String
  time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

// YOU - current user
final User currentUser =
User(id: 0, name: 'Current User', imageUrl: 'assets/images/gg.png');

// USERS
final User nadee = User(id: 1, name: 'nadee', imageUrl: 'assets/images/gg.png');
final User rasi =
User(id: 2, name: 'rasi', imageUrl: 'assets/images/gg.png');
final User dusha = User(id: 3, name: 'dusha', imageUrl: 'assets/images/gg.png');
final User rami =
User(id: 4, name: 'rami', imageUrl: 'assets/images/gg.png');
final User mahi = User(id: 5, name: 'mahi', imageUrl: 'assets/images/gg.png');
final User mali =
User(id: 6, name: 'mali', imageUrl: 'assets/images/gg.png');
final User sithi =
User(id: 7, name: 'sithi', imageUrl: 'assets/images/gg.png');

// FAVORITE CONTACTS
List<User> favorites = [mahi, sithi, rami, rasi, nadee];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: mahi,
    time: '5:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: rami,
    time: '4:30 PM',
    text: ' What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sithi,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: mali,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: sithi,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: rasi,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: nadee,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: rasi,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? ?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'I am good, nice to meet you!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: rasi,
    time: '3:45 PM',
    text: 'Nice to meet u too',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: rasi,
    time: '3:15 PM',
    text: 'How is about your campus life',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! very nice->>->',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: rasi,
    time: '2:00 PM',
    text: 'heee.......',
    isLiked: false,
    unread: true,
  ),
];


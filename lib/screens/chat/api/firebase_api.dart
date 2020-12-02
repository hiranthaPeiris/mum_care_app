import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mun_care_app/screens/chat/data.dart';
import 'package:mun_care_app/screens/chat/model/message.dart';
import 'package:mun_care_app/screens/chat/model/user.dart';
import 'package:mun_care_app/models/UserM.dart';

import '../utils.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('chatuser')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser, String message) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/$idUser/messages');
   // var user = UserM.get();
    final newMessage = Message(
      idUser: myId,
    //  idUser: user.uid,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('chatuser');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('chatuser');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
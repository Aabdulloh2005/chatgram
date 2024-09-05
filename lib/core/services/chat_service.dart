import 'package:chatgram/core/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final chatFirebase = FirebaseFirestore.instance.collection("chat_rooms");

  Future<void> sendMessage(
      String toUserId, String message, String userName) async {
    final currentUserId =  FirebaseAuth.instance.currentUser!.uid;
    final sentTime = Timestamp.now();
    List<String> usersId = [toUserId, currentUserId];
    final chatRoomId = usersId.join("_");
    Message newMessage = Message(
      message: message,
      senderId: currentUserId,
      receiverId: toUserId,
      senderName: userName,
      timestamp: sentTime,
    );
    await chatFirebase
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }
}

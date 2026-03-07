import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chatapp/const/constants.dart';
import 'package:chatapp/data/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    Kmessage,
  );
  void sendMessage({required String message, required String email}) {
    try {
      DateTime now = DateTime.now();
      var hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
      String minute = now.minute.toString().padLeft(2, '0');
      String formattedTime = "$hour:$minute";
      messages.add({
        'message': message,
        'createdAt': formattedTime,
        'id': email,
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }

  void getMessage() {
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(
          MessageModel.fromMap(doc.data() as Map<String, dynamic>),
        );
      }

      emit(ChatSuccess(messages: messagesList));
    });
  }
}

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
  Future<void> sendMessages({
    required String message,
    required String email,
  }) async {
    try {
      MessageModel messageModel = MessageModel(
        email: email,
        message: message,
        createdAt: DateTime.now().toString(),
      );
      await messages.add(messageModel.toMap());
    } on FirebaseException catch (e) {
      emit(ChatFailure(errMessage: e.toString()));
    }
  }

  void getMessages() {
    try {
      messages.orderBy('createdAt', descending: true).snapshots().listen((
        events,
      ) {
        List<MessageModel> messagesList = [];
        for (var event in events.docs) {
          messagesList.add(
            MessageModel.fromMap(event.data() as Map<String, dynamic>),
          );
        }
        emit(ChatSuccess(messages: messagesList));
      });
    } on FirebaseException catch (e) {
      emit(ChatFailure(errMessage: e.toString()));
    }
  }
}

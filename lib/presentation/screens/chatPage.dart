import 'package:chatapp/business_logic/cubit/chat/chat_cubit.dart';
import 'package:chatapp/presentation/widgets/chatBubel.dart';
import 'package:chatapp/presentation/widgets/customSnakPar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chatPage extends StatelessWidget {
  chatPage({super.key});
  static String id = 'chatPage';

  TextEditingController messageController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatCubit>().getMessage();
    var messageList = [];
    String email = ModalRoute.of(context)!.settings.arguments.toString();
    scrollToBottom();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          title: Padding(
            padding: const EdgeInsets.only(right: 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/scholar.png', height: 40),
                const SizedBox(width: 10),
                const Text('Chat', style: TextStyle(fontFamily: 'pacifico')),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    messageList = state.messages;
                  }
                  if (state is ChatFailure) {
                    showSnakBar(
                      context,
                      'something went wrong',
                      Colors.red,
                      Icons.error,
                    );
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? chatBuble(message: messageList[index]!)
                          : chatBubleForSender(
                              message: messageList[index].message!,
                            );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 4),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.add, size: 18, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (data) {
                      if (data.trim().isEmpty) return;
                      context.read<ChatCubit>().sendMessage(
                        message: data,
                        email: email.toString(),
                      );
                      messageController.clear();
                      scrollToBottom();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.blueAccent),
                        onPressed: () {
                          String message = messageController.text.trim();
                          if (message.isEmpty) return;
                          context.read<ChatCubit>().sendMessage(
                            message: message,
                            email: email,
                          );
                          messageController.clear();
                          scrollToBottom();
                        },
                      ),
                      hintText: 'Message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chatapp/business_logic/cubit/chat/chat_cubit.dart';
import 'package:chatapp/data/models/Message.dart';
import 'package:chatapp/presentation/widgets/chatBubel.dart';
import 'package:chatapp/presentation/widgets/customSnakPar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chatView extends StatefulWidget {
  chatView({super.key, required this.email});
  String? email;
  @override
  State<chatView> createState() => _chatViewState();
}

class _chatViewState extends State<chatView> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (state is ChatFailure) {
                    showSnakBar(
                      context,
                      'something went wrong',
                      Colors.red,
                      Icons.error,
                    );
                  } else if (state is ChatSuccess) {
                    scrollToBottom();
                  }
                },
                builder: (context, state) {
                  List<MessageModel> messageList = [];
                  if (state is ChatSuccess) {
                    messageList = state.messages;
                  }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].email == widget.email
                          ? chatBuble(messageModel: messageList[index])
                          : chatBubleForSender(
                              messageModel: messageList[index],
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
                      context.read<ChatCubit>().sendMessages(
                        message: data,
                        email: widget.email.toString(),
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
                          context.read<ChatCubit>().sendMessages(
                            message: message,
                            email: widget.email!,
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

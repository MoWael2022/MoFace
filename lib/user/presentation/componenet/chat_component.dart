import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moface/user/presentation/controller/chat_cubit/chat_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../core/functions/functions.dart';
import '../controller/chat_cubit/chat_state.dart';
import '../controller/loading_cubit/data_cubit.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({super.key});

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final dataCubit = BlocProvider.of<DataCubit>(context);
    context.read<ChatCubit>().connect(dataCubit.userData!.id);
  }

  @override
  void reassemble() {
    super.reassemble();
    context.read<ChatCubit>().close();
  }

  @override
  void dispose() {
    context.read<ChatCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);

    return Container(
      width: 30.w,
      height: 40.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header for the chat dialog
          Row(
            children: [
              CircleAvatar(
                backgroundImage: Functions.getUserImage(
                    chatCubit.friendReceivedData!.profileImg),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Chat with ${chatCubit.friendReceivedData!.username}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context)
                      .hideDialogsState(); // Hide the chat dialog
                },
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Chat messages
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                // final receivedMessages = chatCubit.chatMessageReceived;
                // final sentMessages = chatCubit.chatMessageSend;
                // final allMessages = <Map<String, dynamic>>[];
                //
                // // Combine received and sent messages in order
                // for (var i = 0;
                //     i < receivedMessages.length || i < sentMessages.length;
                //     i++) {
                //   if (i < receivedMessages.length) {
                //     allMessages.add({
                //       'message': receivedMessages[i],
                //       'isReceived': true,
                //     });
                //   }
                //   if (i < sentMessages.length) {
                //     allMessages.add({
                //       'message': sentMessages[i],
                //       'isReceived': false,
                //     });
                //   }
                // }
                // print(allMessages);
                return ListView.builder(
                  itemCount: chatCubit.allMessages.length,
                  itemBuilder: (context, index) {
                    final messageData = chatCubit.allMessages[index];
                    final isReceived = messageData['isReceived'];
                    final message = messageData['message'];

                    return Align(
                      alignment: isReceived
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              isReceived ? Colors.grey[300] : Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(message), // Display the message content
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Chat input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                color: Colors.blue,
                onPressed: () {
                  final message = _messageController.text.trim();
                  if (message.isNotEmpty) {
                    // Send the chat message
                    chatCubit.sendChatMessage(
                      chatCubit.friendReceivedData!.id,
                      message,
                    );
                    // Clear the input field
                    _messageController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

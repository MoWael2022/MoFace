// presentation/pages/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/chat_cubit/chat_cubit.dart';
import '../controller/chat_cubit/chat_state.dart';
import '../controller/loading_cubit/data_cubit.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final dataCubit = BlocProvider.of<DataCubit>(context);
    context.read<ChatCubit>().connect(dataCubit.userData!.id);
  }

  @override
  void dispose() {
    context.read<ChatCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Chat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return CircularProgressIndicator();
                } else if (state is ChatConnected) {
                  return Text('Connection established!');
                } else if (state is ChatMessageReceived) {
                  return Text(
                      'Received Message: ${state.message.arguments[2]}');
                } else if (state is ChatMessageSent) {
                  return Text('Message Sent');
                } else {
                  return Text('Waiting for connection...');
                }
              },
            ),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            TextField(
              controller: _receiverController,
              decoration: InputDecoration(labelText: 'Receiver Id'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ChatCubit>().sendChatMessage(
                      _receiverController.text,
                      _messageController.text,
                    );
              },
              child: Text('Send to User'),
            ),
          ],
        ),
      ),
    );
  }
}

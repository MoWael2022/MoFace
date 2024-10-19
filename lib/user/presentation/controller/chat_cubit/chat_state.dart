import 'package:equatable/equatable.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned.dart';
import 'package:moface/user/domin/entites/chat/data_chat_returned_web_socket.dart';

// Base class for all chat states
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

// Initial state when no action has been performed yet
class ChatInitial extends ChatState {}

// State to show a loading indicator (for example, while connecting)
class ChatLoading extends ChatState {}

// State when the connection is established
class ChatConnected extends ChatState {}

class ShowDialogState extends ChatState {}

class HideDialogsState extends ChatState {}

// State when a new message is received
class ChatMessageReceived extends ChatState {
  final DataChatReturnedWebSocket message;

  const ChatMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

// State when a message has been successfully sent
class ChatMessageSent extends ChatState {
  final String message;

  const ChatMessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatLoaded extends ChatState {
  final List<DataChatReturned> data;

  const ChatLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ChatLoadedError extends ChatState {
  final String messageError;

  const ChatLoadedError(this.messageError);

  @override
  List<Object?> get props => [messageError];
}

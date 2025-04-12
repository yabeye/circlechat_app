import 'package:circlechat_app/core/enums/chat_enums.dart';
import 'package:circlechat_app/data/models/chat_model.dart';
import 'package:circlechat_app/presentation/cubit/messages/message_input_cubit.dart';
import 'package:circlechat_app/presentation/cubit/messages/messages_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    required this.senderId,
    this.chatId,
    super.key,
  });

  final String? chatId;
  final String senderId;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  late final TextEditingController _textController;
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController()
      ..addListener(() {
        _isTextEmpty = _textController.text.isEmpty;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInputCubit, MessageInputState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        prefixIconConstraints: const BoxConstraints(),
                        hintText: 'Message',
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        border: InputBorder.none,
                        prefixIcon: Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.sticky_note_2_outlined),
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isTextEmpty)
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () {},
                              ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  shape: WidgetStateProperty.all(
                    const CircleBorder(),
                  ),
                ),
                icon: Icon(
                  _isTextEmpty ? Icons.mic : Icons.send,
                ),
                onPressed: _isTextEmpty ? () {} : _sendMessage,
              ),
            ],
          ),
        );
      },
    );
  }

  _sendMessage() {
    try {
      context.read<MessageInputCubit>().sendMessage(
            chatId: widget.chatId,
            message: MessageModel(
              id: Uuid().v4(), // temporary id
              text: _textController.text,
              senderId: widget.senderId,
              timestamp: Timestamp.now(),
              type: MessageType.text,
              status: MessageStatus.sending,
            ),
          );
      _textController.clear();
    } catch (e) {
      print('ERROR is ${e.toString()}');
    }
  }
}

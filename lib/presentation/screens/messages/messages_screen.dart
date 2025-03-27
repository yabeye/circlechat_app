import 'package:circlechat_app/presentation/screens/messages/message_card.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_listtile.dart';
import 'package:circlechat_app/presentation/widgets/app_widgets/app_scaffold.dart';
import 'package:circlechat_app/presentation/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circlechat_app/presentation/cubit/messages/messages_cubit.dart';
import 'package:circlechat_app/data/models/chat_model.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key, required this.chat});
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit()..loadMessages(chat),
      child: AppScaffold(
        appBar: AppBar(
          title: AppListTile(
            leading: ProfileAvatar(
              profileId: chat.participantUsers.first.uid,
            ),
            title: chat.participantUsers.first.name,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  if (state is MessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MessagesLoaded) {
                    // Reverse the list of messages
                    final reversedMessages = state.messages.reversed.toList();
                    return ListView.builder(
                      itemCount: reversedMessages.length,
                      itemBuilder: (context, index) {
                        final message = reversedMessages[index];
                        return MessageCard(message: message);
                      },
                    );
                  } else if (state is MessagesError) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final _textController = TextEditingController();

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
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
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
            icon: const Icon(Icons.send),
            onPressed: () {
              // Implement send message logic here
            },
          ),
        ],
      ),
    );
  }
}

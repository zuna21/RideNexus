import 'package:flutter/material.dart';
import 'package:mobile/app_config.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:mobile/models/message_model.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/user_service.dart';
import 'package:mobile/widgets/dialogs/create_ride_dialog.dart';
import 'package:mobile/widgets/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.driverId, this.chatId});

  final int? driverId;
  final int? chatId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatService = ChatService();
  final _messageController = TextEditingController();
  final _userService = UserService();
  final _scrollController = ScrollController();
  ChatModel? _chat;
  bool asDriver = false;
  int _pageIndex = 0;
  bool _haveMore = true;

  @override
  void initState() {
    super.initState();
    _doesDriverOpenPage();
    getChat();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          getChat();
        }
      }
    });
  }

  void getChat() async {
    if (widget.driverId != null) {
      getClientChatByIds();
    } else if (widget.chatId != null) {
      getChatByid();
    }
  }

  void _doesDriverOpenPage() async {
    final role = await _userService.getRole();
    setState(() {
      asDriver = role == "driver";
    });
  }

  // Ova funkcija je ako se proslijedi driverId (tj. ako user otvori chat kroz vozaca)
  void getClientChatByIds() async {
    if (!_haveMore) return;
    ChatModel? chat;
    try {
      chat =
          await _chatService.getClientChatByIds(widget.driverId!, _pageIndex);
      _pageIndex++;
      if (chat.messages!.length < AppConfig.pageSize) _haveMore = false;
    } catch (e) {
      print(e.toString());
    }

    if (chat != null) {
      setState(() {
        if (_pageIndex == 1) {
          _chat = chat;
        } else {
          _chat!.messages = [..._chat!.messages!, ...chat!.messages!];
        }
      });
    }
  }

  Future<void> getChatByid() async {
    if (!_haveMore) return;
    ChatModel? chat;
    try {
      chat = await _chatService.getChatById(widget.chatId!, _pageIndex);
      _pageIndex++;
      if (chat.messages!.length < AppConfig.pageSize) _haveMore = false;
    } catch (e) {
      print(e);
    }

    if (chat == null) return;
    setState(() {
      if (_pageIndex == 1) {
        _chat = chat;
      } else {
        _chat!.messages = [..._chat!.messages!, ...chat!.messages!];
      }
    });
  }

  Future<void> sendMessage() async {
    if (_chat == null ||
        _messageController.text.isEmpty ||
        _messageController.text.trim() == "") return;

    final createMessageModel = CreateMessageModel();
    createMessageModel.content = _messageController.text;

    MessageModel? createdMessage;

    try {
      createdMessage =
          await _chatService.sendMessage(_chat!.id!, createMessageModel);
    } catch (e) {
      print(e);
    }

    if (createdMessage != null) {
      _messageController.clear();
      setState(() {
        _chat!.messages = [createdMessage!, ..._chat!.messages!];
      });
    }
  }

  void scheduleARide() async {
    if (widget.driverId == null) {
      return;
    }
    final isRideCreated = await showDialog(
      context: context,
      builder: (_) => CreateRideDialog(
        driverId: widget.driverId!,
      ),
    );

    if (mounted) {
      if (isRideCreated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
                "Obavijestit ćemo vas ubrzo da li je vaša vožnja prihvaćena."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nažalost vožnja nije kreirana."),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Poruke"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _chat != null
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: _chat!.messages!.length,
                    itemBuilder: (itemBuilder, index) => Message(
                      message: _chat!.messages![index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Napiši poruku',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: sendMessage,
                            icon: const Icon(Icons.send_outlined),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (!asDriver)
                        ElevatedButton(
                          onPressed: scheduleARide,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          child: const Text("Zakaži Vožnju"),
                        ),
                    ],
                  ),
                )
              ],
            )
          : const Center(
              child: Text("Failed to get chat"),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile/helpers/fetch_status.dart';
import 'package:mobile/models/chat_model.dart';
import 'package:mobile/pages/error_page.dart';
import 'package:mobile/services/chat_service.dart';
import 'package:mobile/widgets/cards/chat_card.dart';
import 'package:mobile/widgets/loading.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _chatService = ChatService();
  List<ChatCardModel> _chats = [];
  FetchStatus _fetchStatus = FetchStatus.loading;
  final _scrollController = ScrollController();
  int _pageIndex = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getDriverChats();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          _getDriverChats();
        }
      }
    });
  }

  void _getDriverChats() async {
    if (!_hasMore) return;
    List<ChatCardModel> chats = [];
    try {
      chats = await _chatService.getDriverChats(
        pageIndex: _pageIndex,
        pageSize: 50,
      );
      _pageIndex++;
      if (chats.length < 50) _hasMore = false;
      setState(() {
        _chats = [...chats];
        _fetchStatus = FetchStatus.data;
      });
    } catch (e) {
      setState(() {
        _fetchStatus = FetchStatus.error;
      });
    }
  }

  @override
  void dispose() {
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
        body: _build());
  }

  Widget _build() {
    switch (_fetchStatus) {
      case FetchStatus.loading:
        return const Loading();
      case FetchStatus.error:
        return const ErrorPage();
      default:
        return ListView.builder(
          controller: _scrollController,
          itemCount: _chats.length,
          itemBuilder: (itemBuilder, index) => ChatCard(
            chat: _chats[index],
          ),
        );
    }
  }
}

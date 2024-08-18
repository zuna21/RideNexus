import 'package:mobile/models/message_model.dart';

class ChatModel {
  int? id;
  List<MessageModel>? messages;

  ChatModel({this.id, this.messages});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class ChatCardModel {
  int? id;
  String? senderUsername;
  bool? isSeen;
  MessageModel? lastMessage;

  ChatCardModel({this.id, this.senderUsername, this.isSeen, this.lastMessage});

  ChatCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderUsername = json['senderUsername'];
    isSeen = json['isSeen'];
    lastMessage = json['lastMessage'] != null
        ? MessageModel.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderUsername'] = senderUsername;
    data['isSeen'] = isSeen;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    return data;
  }
}


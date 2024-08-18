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


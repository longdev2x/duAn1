

import 'package:du_an_1/data/model/response/post_entity.dart';
import 'package:du_an_1/data/model/response/user.dart';

class CommentEntity {
  final String? id;
  final String? content;
  final DateTime? date;
  final User? user;
  final PostEntity? objPost;

  CommentEntity({
    this.content,
    this.date,
    this.id,
    this.user,
    this.objPost,
  });

  factory CommentEntity.fromJson(Map<String, dynamic>? json) {
    return CommentEntity(
      content: json?['content'],
      date: json?['date'] != null ? DateTime.fromMillisecondsSinceEpoch(json?['date']).toLocal() : null,
      id: json?['id'],
      user: User.fromJson(json?['user']),
      objPost: PostEntity.fromJson(json?['post']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'date': date?.toIso8601String(),
      'id': id,
      'user': user?.toJson(),
      //Lặp vô tận
      "post": null,
    };
  }
}



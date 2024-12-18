

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
      date: (json?['date'] == null || json?['date'] is int)
          ? null
          : DateTime.tryParse(json?['date']),
      id: json?['id'],
      user: User.fromJson(json?['user']),
      objPost: json?['post'] is String ? null : PostEntity.fromJson(json?['post']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'date': date?.toIso8601String(),
      'id': id,
      'user': user?.id,
    };
  }
}



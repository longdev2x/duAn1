import 'package:du_an_1/data/model/response/post_entity.dart';
import 'package:du_an_1/data/model/response/user.dart';


class LikeEntity {
  final DateTime? date;
  final String? id;
  final int? type;
  final User? user;
  final PostEntity? objPost;

  LikeEntity({
    this.date,
    this.id,
    this.type,
    this.user,
    this.objPost,
  });

  factory LikeEntity.fromJson(Map<String, dynamic>? json) {
    return LikeEntity(
      id: json?['id'],
      date: (json?['date'] == null || json?['date'] is int)
          ? null
          : DateTime.tryParse(json?['date']),
      type: json?['type'],
      user: User.fromJson(json?['user']), //id
      objPost: json?['post'] is String ? null : PostEntity.fromJson(json?['post']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date?.toIso8601String(),
      'id': id,
      'type': type,
      'user': user?.id, //sever nhận id
      "post": null,
    };
  }
}

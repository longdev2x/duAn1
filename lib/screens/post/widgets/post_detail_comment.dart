import 'package:du_an_1/data/model/response/comment_entity.dart';
import 'package:du_an_1/screens/post/widgets/comment_item.dart';
import 'package:flutter/material.dart';


class PostDetailComment extends StatelessWidget {
  final List<CommentEntity> comments;
  const PostDetailComment({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (ctx, index) => CommentItem(objComment: comments[index],),);
  }
}
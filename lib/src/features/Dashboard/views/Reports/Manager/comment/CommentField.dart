import 'package:flutter/material.dart';

import '../../../../../../common_widgets/CustomText.dart';
import 'BottomActionComment.dart';

class CommentField extends StatelessWidget {
  final String userName;
  final String message;
  final String time;
  final String commentId;
  final VoidCallback? onCommentUpdate;
  final TextEditingController commentController;
  final TextEditingController commentIdController;
  const CommentField(this.commentId, this.userName, this.message, this.time,
      this.onCommentUpdate, this.commentController, this.commentIdController,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4,
              children: [
                Icon(
                  Icons.comment_bank,
                  size: 19,
                  color: Colors.black54,
                ),
                Row(
                  spacing: 4,
                  children: [
                    CustomText(userName, 15, FontWeight.bold, Colors.black87),
                    CustomText(time, 13, FontWeight.normal, Colors.black87),
                  ],
                )
              ],
            ),
            BottomActionComment(
                commentId, onCommentUpdate, commentController, message,commentIdController)
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomText("Comment : ${message.trim()}", 14,
                  FontWeight.w500, Colors.black87),
            ),
            //
          ],
        )
      ],
    );
  }
}

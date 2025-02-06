import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/SnackBar.dart';
import 'package:site_assessment/src/constants/firebase.dart';

import '../../../../../../common_widgets/CustomText.dart';
import '../../../../../../constants/constants.dart';

class BottomActionComment extends StatelessWidget {
  final String commentId;
  final String message;
  final VoidCallback? onCommentUpdate;
  final TextEditingController commentController;
  final TextEditingController commentIdController;
  const BottomActionComment(this.commentId, this.onCommentUpdate,this.commentController,this.message,this.commentIdController,{super.key});

  @override
  Widget build(BuildContext context) {

    //Edit comment
    Future<void> editComment() async {
      commentController.text= message;
      commentIdController.text = commentId;
      commentController.selection = TextSelection.fromPosition(
      TextPosition(offset: commentController.text.length));
      FocusScope.of(context).requestFocus(FocusNode());
    }

    //delete comment
    Future<void> deleteComment() async {
      try {
        await FireBaseApi.deleteDocument(
            FireBaseConstant.commentCollection, commentId);
        onCommentUpdate!();
        ActionSnackBar.show(context, " Deleted");
      } catch (err) {
        print(err);
      }
    }

    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.black.withAlpha((255.0 * 0.1).round()))
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomText("Comment  Actions ", 18,
                          FontWeight.bold, Colors.black87),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: AppColors.mainColor,
                      ),
                      title: CustomText(
                          "Edit", 16, FontWeight.w500, Colors.black87),
                      onTap: () {
                        Navigator.pop(context);
                        editComment();
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: AppColors.mainColor,
                      ),
                      title: CustomText(
                          "Delete", 16, FontWeight.w500, Colors.black87),
                      onTap: () {
                        Navigator.pop(context);
                        deleteComment();

                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.remove_red_eye,
                        color: AppColors.mainColor,
                      ),
                      title: CustomText(
                          "Hide", 16, FontWeight.w500, Colors.black87),
                      onTap: () {},
                    ),
                  ],
                ),
              );
            });
      },
      icon: Icon(
        Icons.more_vert,
        size: 16,
      ),
    );
  }
}

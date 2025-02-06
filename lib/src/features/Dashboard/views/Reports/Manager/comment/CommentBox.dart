//CommentBox
import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/utils/user.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'CommentField.dart';
import 'commentDto.dart';

class CommentBox extends StatefulWidget {
  final String reportId;
  const CommentBox(this.reportId, {super.key});
  @override
  State<StatefulWidget> createState() => CommentBoxState();
}

//comment Box State
class CommentBoxState extends State<CommentBox> {
  final TextEditingController commentController = TextEditingController();
  final TextEditingController commentIdController = TextEditingController();
  String userName = '';
  String managerId = '';

  List<CommentDto> comments = [];

  //Add Comment
  Future<void> addComments() async {
    if (commentController.text == '') {
      return;
    }

    final commentData = <String, dynamic>{
      "managerId": managerId,
      "managerName": userName,
      "reportId": widget.reportId,
      'dateTime': DateTime.now(),
      'description': commentController.text
    };
    try {
      print("edit or Add ${commentIdController.text}");
      if (commentIdController.text != '') {
        await FireBaseApi.updateByField(FireBaseConstant.commentCollection,
            {"description": commentController.text}, commentIdController.text);
      } else {
        await FireBaseApi.insert(
            FireBaseConstant.commentCollection, commentData);
      }
      getReportComment();
      setState(() {
        commentController.text = "";
        commentIdController.text = "";
      });
    } catch (err) {
      print("error Not comment Save");
    }
  }

  @override
  void initState() {
    super.initState();
    getReportComment();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            CustomText(
                "All Comments", 18, FontWeight.bold, AppColors.mainColor),
            Icon(
              Icons.comment,
              color: AppColors.mainColor,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          maxLines: null,
                          onChanged: (value) {
                            setState(() {
                              commentController.text = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Transform.rotate(
                            angle: -0.48,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 9),
                              child: IconButton(
                                  onPressed: () {
                                    print(commentController.text.trim() != '');
                                    if (commentController.text.trim() != '') {
                                      addComments();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: commentController.text.trim() != ''
                                        ? AppColors.mainColor
                                        : Colors.grey,
                                    size: 28,
                                  )),
                            )),
                      )
                    ],
                  )),
              SizedBox(width: 10),
              comments.isEmpty
                  ? const CustomText(
                      "No comments yet", 14, FontWeight.w400, Colors.grey)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return Column(
                          children: [
                            CommentField(
                                comment.commentId,
                                userName,
                                comment.message,
                                timeago.format(comment.time),
                                getReportComment,
                                commentController,
                                commentIdController),
                            const Divider(),
                          ],
                        );
                      },
                    ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> getReportComment() async {
    var data = await CurrentUser.get();
    var allComments = await FireBaseApi.getByField(
        FireBaseConstant.commentCollection, 'reportId', widget.reportId);
    var tempComment = <CommentDto>[];
    for (var comment in allComments) {
      tempComment.add(CommentDto(
          commentId: comment.id,
          time: DateTime.now(),
          message: comment['description']));
    }
    setState(() {
      userName = data['fullName'];
      managerId = data['userId'];
      comments = tempComment;
    });
  }
}

//

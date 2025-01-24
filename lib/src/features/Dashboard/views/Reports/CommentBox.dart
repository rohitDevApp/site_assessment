//CommentBox
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
class CommentBox extends StatefulWidget {
  const CommentBox({super.key});

  @override
  State<StatefulWidget> createState() => CommentBoxState();
}

//comment Box State
class CommentBoxState extends State<CommentBox> {
  final TextEditingController commentController = TextEditingController();
  List<Map<String,String>> comments = [
    {
      'time': ' 08:00 AM 2024-01-22',
      'message': 'Done',
    }
  ];

  //Add Comment
  void addComments(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);
    setState(() {
      comments.add({'time':'$formattedTime $formattedDate','message':commentController.text});
      commentController.text= "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: CustomText("Comments", 16, FontWeight.normal, Colors.black),
      trailing: Icon(
        Icons.arrow_drop_down,
      ),
      children: <Widget>[
        Divider(height: 1, color: Colors.grey),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              for(var comment in comments) CommentField(" ${comment['message']} ${comment['time']}. "),
              ClipRect(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16)
                            ),
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                  hintText: 'Write a comment...',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16)),
                            ),
                          )),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: addComments,
                        child: Icon(
                          Icons.send,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
      // onExpansionChanged: (bool expanded) {
      //   setState(() => customIcon = expanded);
      // },
    );
  }
}
//Comments field
class CommentField extends StatelessWidget {
  final String value;
  const CommentField(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(vertical: 3,horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 4 ,horizontal: 8),
          child:CustomText(value, 14, FontWeight.normal, Colors.black),
        )
      ],
    );
  }
}
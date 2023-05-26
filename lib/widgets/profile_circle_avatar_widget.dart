import 'package:flutter/material.dart';

class ProfileCircleAvatarsWidget extends StatefulWidget {
  List? details;
  ProfileCircleAvatarsWidget({this.details, super.key});

  @override
  State<ProfileCircleAvatarsWidget> createState() =>
      _ProfileCircleAvatarsWidgetState();
}

class _ProfileCircleAvatarsWidgetState
    extends State<ProfileCircleAvatarsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: Stack(
        children: [
          Positioned(
            left: 30,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(widget.details![0]['avatar']),
            ),
          ),
          widget.details!.length == 2
              ? Positioned(
                  left: 15,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blueAccent,
                    backgroundImage: NetworkImage(widget.details![1]['avatar']),
                  ),
                )
              : Container(),
          widget.details!.length >= 3
              ? Positioned(
                  left: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(widget.details![2]['avatar']),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpandText extends StatefulWidget {
  ExpandText({
    labeHeader,
    desc,
    shortDesc,
    String labelHeader,
  });

  String labeHeader;
  String desc;
  String shortDesc;

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labeHeader,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

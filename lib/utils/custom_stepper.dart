import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
//  CustomStepper({Key key}) : super(key: key);

  CustomStepper({
    @required this.lowerLimit,
    @required this.upperLimit,
    @required this.stepValue,
    @required this.iconSize,
    @required this.value,
    @required this.onChange,
  });

  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChange;

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.lowerLimit
                      ? widget.lowerLimit
                      : widget.value -= widget.stepValue;

                  widget.onChange(widget.value);
                });
              },
              icon: const Icon(Icons.remove)),
          SizedBox(
            width: widget.iconSize,
            child: Text(
              '${widget.value}',
              style: TextStyle(
                fontSize: widget.iconSize * 0.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value += widget.stepValue;
                  widget.onChange(widget.value);
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}

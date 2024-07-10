import 'package:flutter/material.dart';

class LocaleDraggableDivider extends StatefulWidget {
  final String leftImage;
  final String rightImage;
  final int imgWidth;
  final int imgHeight;

  const LocaleDraggableDivider(
      {super.key,
      required this.leftImage,
      required this.rightImage,
      required this.imgWidth,
      required this.imgHeight});

  @override
  _LocaleDraggableDividerState createState() => _LocaleDraggableDividerState();
}

class _LocaleDraggableDividerState extends State<LocaleDraggableDivider> {
  double _dividerPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        return Container(
            height: screenWidth / widget.imgWidth * widget.imgHeight > 500
                ? 500
                : screenWidth / widget.imgWidth * widget.imgHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (details) {
                setState(() {
                  // 计算手势位置所占比例，并限制在 0~1 范围内
                  _dividerPosition += details.delta.dx / screenWidth;
                  _dividerPosition = _dividerPosition.clamp(0.0, 1.0);
                });
              },
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: width,
                    height: widget.imgHeight.toDouble(),
                    child: Image.asset(
                      widget.leftImage, // 图片 URL
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: width * _dividerPosition,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: width * (1 - _dividerPosition),
                      child: Image.asset(
                        widget.rightImage, // 图片 URL
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

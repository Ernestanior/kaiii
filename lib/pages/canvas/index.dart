import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageEraseApp extends StatefulWidget {
  @override
  _ImageEraseAppState createState() => _ImageEraseAppState();
}

class _ImageEraseAppState extends State<ImageEraseApp> {
  List<Offset?> points = [];
  double brushRadius = 10.0;
  ui.Image? backgroundImage;
  Offset? lastPoint;

  @override
  void initState() {
    super.initState();
    loadImage('assets/home/1.jpg'); // 加载你的图片
  }

  Future<void> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final ui.Codec codec =
        await ui.instantiateImageCodec(Uint8List.fromList(bytes));
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    setState(() {
      backgroundImage = frameInfo.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Erase")),
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                points.add(details.localPosition);
                lastPoint = details.localPosition;
              });
            },
            onPanEnd: (details) {
              points.add(null); // 用于分隔路径
              lastPoint = null;
            },
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size.infinite,
                painter:
                    ImageErasePainter(points, brushRadius, backgroundImage),
              ),
            ),
          ),
          if (lastPoint != null)
            Positioned(
              top: 10,
              left: 10,
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(100, 100),
                  painter: MagnifierPainter(
                      lastPoint!, backgroundImage, 2.0), // 放大倍率3倍
                ),
              ),
            ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Slider(
              value: brushRadius,
              min: 5.0,
              max: 30.0,
              onChanged: (value) {
                setState(() {
                  brushRadius = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ImageErasePainter extends CustomPainter {
  final List<Offset?> points;
  final double brushRadius;
  final ui.Image? backgroundImage;

  ImageErasePainter(this.points, this.brushRadius, this.backgroundImage);

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      canvas.drawImage(backgroundImage!, Offset.zero, Paint());
    }

    Paint erasePaint = Paint()
      ..color = Colors.white.withOpacity(0.5) // 半透明白色
      ..blendMode = BlendMode.srcOver // 使用 srcOver 使颜色不重叠
      ..strokeCap = StrokeCap.round
      ..strokeWidth = brushRadius;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, erasePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MagnifierPainter extends CustomPainter {
  final Offset point;
  final ui.Image? backgroundImage;
  final double scale;

  MagnifierPainter(this.point, this.backgroundImage, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      Paint paint = Paint();
      double magnifierSize = size.width / scale;
      Rect srcRect = Rect.fromLTWH(
        point.dx - magnifierSize / 2,
        point.dy - magnifierSize / 2,
        magnifierSize,
        magnifierSize,
      );

      Rect dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
      canvas.drawImageRect(backgroundImage!, srcRect, dstRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(home: ImageEraseApp()));
}

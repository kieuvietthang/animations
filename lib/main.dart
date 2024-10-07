import 'package:flutter/material.dart';
import 'dart:math' as math;

class MovingCircleFromCenterWidget extends StatefulWidget {
  @override
  _MovingCircleFromCenterWidgetState createState() =>
      _MovingCircleFromCenterWidgetState();
}

class _MovingCircleFromCenterWidgetState
    extends State<MovingCircleFromCenterWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  List<Offset> _trianglePoints = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // Thời gian để hoàn thành một chu kỳ
    )..repeat(); // Lặp lại chuyển động
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước của màn hình
    final screenSize = MediaQuery.of(context).size;

    // Xác định vị trí bắt đầu và 3 đỉnh của tam giác
    Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
    Offset topLeft = Offset(screenSize.width / 4, screenSize.height / 4);
    Offset topRight = Offset(3 * screenSize.width / 4, screenSize.height / 4);
    Offset bottom = Offset(screenSize.width / 2, 3 * screenSize.height / 4);

    // Sử dụng Tween để chuyển động qua các điểm
    _animation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween(begin: center, end: topLeft)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: topLeft, end: topRight)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: topRight, end: bottom)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(begin: bottom, end: center)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_controller);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Hình ảnh ở dưới (có thể thay thế bằng ảnh thực tế của bạn)
            Image.asset(
              'assets/image/background_image.png',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
            // Nền trắng và lỗ tròn di chuyển theo tam giác
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircularHolePainter(_animation.value, 50),
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      color: Colors.transparent, // Nền trong suốt
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter để vẽ lỗ tròn di chuyển theo tam giác
class CircularHolePainter extends CustomPainter {
  final Offset holePosition;
  final double holeRadius;

  CircularHolePainter(this.holePosition, this.holeRadius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Vẽ nền trắng
    Path path = Path()..addRect(rect);
    // Tạo lỗ tròn tại vị trí hiện tại của hình tròn
    path.addOval(Rect.fromCircle(center: holePosition, radius: holeRadius));
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircularHolePainter oldDelegate) {
    return oldDelegate.holePosition != holePosition ||
        oldDelegate.holeRadius != holeRadius;
  }
}

void main() {
  runApp(MaterialApp(home: MovingCircleFromCenterWidget()));
}

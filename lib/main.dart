import 'package:flutter/material.dart';

class MovingCircleWidget extends StatefulWidget {
  @override
  _MovingCircleWidgetState createState() => _MovingCircleWidgetState();
}

class _MovingCircleWidgetState extends State<MovingCircleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // Thời gian cho một chu kỳ chuyển động
    )..repeat(); // Lặp lại chuyển động

    // Xác định kích thước màn hình sau khi layout được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      // Xác định các điểm di chuyển trên màn hình
      Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
      double moveDistanceX = 100; // Khoảng cách di chuyển theo trục X
      double moveDistanceY = 100; // Khoảng cách di chuyển theo trục Y

      // Các đỉnh của hình tam giác
      Offset pointA = Offset(center.dx - moveDistanceX, center.dy); // Di chuyển sang trái
      Offset pointB = Offset(center.dx - moveDistanceX, center.dy - moveDistanceY); // Di chuyển chéo lên
      Offset pointC = Offset(center.dx, center.dy - moveDistanceY); // Di chuyển thẳng xuống
      Offset pointD = Offset(center.dx, center.dy); // Về vị trí giữa

      // Tạo TweenSequence để hình tròn di chuyển qua các điểm
      _animation = TweenSequence<Offset>([
        TweenSequenceItem(
          tween: Tween(begin: center, end: pointA).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointA, end: pointB).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointB, end: pointC).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointC, end: pointD).chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
      ]).animate(_controller);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Nền trắng với hình ảnh
            Image.asset(
              'assets/image/img_bgr_map.jpeg', // Thay bằng URL hình ảnh của bạn
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
            // Vẽ lỗ tròn di chuyển
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: CircularHolePainter(_animation.value, 50),
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      color: Colors.transparent,
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

// CustomPainter để vẽ lỗ tròn di chuyển theo các điểm
class CircularHolePainter extends CustomPainter {
  final Offset holePosition;
  final double holeRadius;

  CircularHolePainter(this.holePosition, this.holeRadius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Vẽ nền trắng và tạo lỗ tròn tại vị trí hiện tại của hình tròn
    Path path = Path()..addRect(rect);
    path.addOval(Rect.fromCircle(center: holePosition, radius: holeRadius));
    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CircularHolePainter oldDelegate) {
    return oldDelegate.holePosition != holePosition || oldDelegate.holeRadius != holeRadius;
  }
}

void main() {
  runApp(MaterialApp(home: MovingCircleWidget()));
}

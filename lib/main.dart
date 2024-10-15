import 'package:flutter/material.dart';
import 'package:untitled6/home_page.dart';

class MovingCircleWidget extends StatefulWidget {
  @override
  _MovingCircleWidgetState createState() => _MovingCircleWidgetState();
}

class _MovingCircleWidgetState extends State<MovingCircleWidget>
    with SingleTickerProviderStateMixin {
   late AnimationController _controller;
   late Animation<Offset> _animation;

  bool check = false;

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;

      // Xác định điểm giữa trên màn hình
      Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
      double moveDistanceX = 100; // Khoảng cách di chuyển theo trục X
      double moveDistanceY = 100; // Chiều cao của tam giác theo trục Y

      // Các đỉnh của tam giác đều
      Offset pointA = Offset(center.dx - moveDistanceX,
          center.dy); // Di chuyển sang trái theo trục X
      Offset pointB = Offset(
          center.dx, center.dy - moveDistanceY); // Chéo lên theo trục Y và X
      Offset pointC = Offset(center.dx + moveDistanceX,
          center.dy); // Chéo xuống theo trục Y và trục X

      // Tạo TweenSequence để hình tròn di chuyển qua các điểm theo hình tam giác
      _animation = TweenSequence<Offset>([
        TweenSequenceItem(
          tween: Tween(begin: center, end: pointA)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointA, end: pointB)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointB, end: pointC)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pointC, end: center)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 1,
        ),
      ]).animate(_controller);
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        check = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      });
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
            Positioned(
              bottom: screenSize.height / 2.8,
              left: screenSize.width / 2 - 70,
              child: const Text(
                "Findmykids",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            check
                ? Positioned(
                    bottom: screenSize.height / 3.5,
                    left: screenSize.width / 2 - 50,
                    child: const Text(
                      "Khi trẻ em không\n trả lời cuộc gọi",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
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

    // Vẽ nền trắng và tạo lỗ vuông bo góc 5px
    Path path = Path()..addRect(rect);
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCircle(center: holePosition, radius: holeRadius),
      Radius.circular(5),
    ));
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
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovingCircleWidget(),
    ),
  );
}

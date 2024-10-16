import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled6/custom_sound.dart';

class DashedLinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final double progress;
  final Offset secondStartPoint;
  final Offset secondEndPoint;
  final double secondProgress;

  DashedLinePainter({
    required this.startPoint,
    required this.endPoint,
    required this.progress,
    required this.secondStartPoint,
    required this.secondEndPoint,
    required this.secondProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Vẽ đoạn nét đứt từ A đến B
    _drawDashedLine(canvas, paint, startPoint, endPoint, progress);

    // Nếu đã nhấn nút và đoạn từ A đến B đã vẽ xong, tiếp tục vẽ đoạn từ B đến C
    if (progress >= 1.0 && secondProgress > 0.0) {
      _drawDashedLine(
          canvas, paint, secondStartPoint, secondEndPoint, secondProgress);
    }
  }

  void _drawDashedLine(
      Canvas canvas, Paint paint, Offset start, Offset end, double progress) {
    final path = Path();

    double dashLength = 10.0; // Độ dài của mỗi đoạn nét đứt
    double gapLength = 5.0; // Khoảng cách giữa các đoạn nét đứt
    double totalDistance = (end - start).distance;

    // Tính tổng số đoạn nét đứt dựa trên tiến độ
    double totalDashes = (totalDistance / (dashLength + gapLength)) * progress;

    double currentDistance = 0.0;
    Offset currentPoint = start;

    for (int i = 0; i < totalDashes; i++) {
      final dashEndPoint =
          _getPointAlongLine(start, end, currentDistance + dashLength);

      path.moveTo(currentPoint.dx, currentPoint.dy);
      path.lineTo(dashEndPoint.dx, dashEndPoint.dy);

      currentDistance += dashLength + gapLength;
      currentPoint = _getPointAlongLine(start, end, currentDistance);
    }

    canvas.drawPath(path, paint);
  }

  Offset _getPointAlongLine(Offset start, Offset end, double distance) {
    final totalDistance = (end - start).distance;
    final direction = (end - start) / totalDistance;
    return start + direction * distance;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeartIcon extends StatelessWidget {
  final Offset startPoint;
  final Offset endPoint;
  final double progress;
  final Offset secondStartPoint;
  final Offset secondEndPoint;
  final double secondProgress;
  final List<double> amplitudes;
  final bool sound;

  HeartIcon({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    required this.progress,
    required this.secondStartPoint,
    required this.secondEndPoint,
    required this.secondProgress,
    required this.amplitudes,
    required this.sound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _getHeartPosition().dx - 45,
      top: _getHeartPosition().dy - 120,
      child: Column(
        children: [
          sound
              ? Container(
                  width: 100,
                  height: 30,
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(25)),
                  child: CustomPaint(
                    painter: SoundWavePainter(amplitudes: amplitudes),
                  ),
                )
              : const SizedBox(
                  width: 100,
                  height: 30,
                ),
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/image/img_location.png',
              scale: 1,
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tính toán vị trí trái tim dựa trên progress và secondProgress
  Offset _getHeartPosition() {
    if (progress < 1.0) {
      // Tính toán vị trí trên đoạn A -> B dựa trên progress
      return _getPointAlongLine(startPoint, endPoint, progress);
    } else {
      // Tính toán vị trí trên đoạn B -> C dựa trên secondProgress
      return _getPointAlongLine(
          secondStartPoint, secondEndPoint, secondProgress);
    }
  }

  Offset _getPointAlongLine(Offset start, Offset end, double progress) {
    final totalDistance = (end - start).distance;
    final direction = (end - start) / totalDistance;
    return start + direction * (totalDistance * progress);
  }
}

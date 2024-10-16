import 'package:flutter/material.dart';

class SoundWavePainter extends CustomPainter {
  final List<double> amplitudes; // Độ cao của sóng âm

  SoundWavePainter({required this.amplitudes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final barWidth = size.width / amplitudes.length; // Độ rộng của mỗi thanh
    for (int i = 0; i < amplitudes.length; i++) {
      final x = i * barWidth;
      final barHeight = amplitudes[i] * size.height; // Chiều cao thanh
      final rect = Rect.fromLTWH(x, (size.height - barHeight) / 2, barWidth - 2, barHeight);
      canvas.drawRect(rect, paint); // Vẽ thanh sóng âm
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
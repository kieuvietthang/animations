import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final double progress;

  DashedLinePainter({
    required this.startPoint,
    required this.endPoint,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Parameters for the dashed line
    double dashLength = 10.0; // Length of each dash
    double gapLength = 5.0; // Length of each gap

    // Calculate total distance
    double totalDistance = (endPoint - startPoint).distance;

    // Calculate the number of dashes to draw based on progress
    double totalDashes = (totalDistance / (dashLength + gapLength)) * progress;

    double currentX = startPoint.dx;
    double currentY = startPoint.dy;

    for (int i = 0; i < totalDashes; i++) {
      // Draw dashes
      path.moveTo(currentX, currentY);
      currentX += dashLength;
      if (currentX > endPoint.dx) {
        currentX = endPoint.dx; // Limit to end point
      }
      currentY += (endPoint.dy - startPoint.dy) / totalDistance * dashLength;
      path.lineTo(currentX, currentY);

      // Move to the next gap
      currentX += gapLength;
      if (currentX > endPoint.dx) {
        currentX = endPoint.dx; // Limit to end point
      }
      currentY += (endPoint.dy - startPoint.dy) / totalDistance * gapLength;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
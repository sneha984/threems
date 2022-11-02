import 'package:flutter/cupertino.dart';

class RPCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.009174323, 0);
    path_0.lineTo(size.width * 1.000005, 0);
    path_0.lineTo(size.width * 1.000005, size.height);
    path_0.lineTo(size.width * 0.009174323, size.height);
    path_0.lineTo(size.width * 0.1290323, size.height * 0.5000000);
    path_0.lineTo(size.width * 0.009174323, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFBED5D).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
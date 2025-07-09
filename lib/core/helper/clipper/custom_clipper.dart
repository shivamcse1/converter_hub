import 'package:converter_hub/core/app_imports.dart';

class TraingleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;
    final width = size.width;

    path.lineTo(0, height);
    path.lineTo(width / 1.5, height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;
    final width = size.width;

    path.lineTo(0, height - 50);

    ///first target curve
    final targetP1 = Offset(100, height);
    final endP1 = Offset(width * .5, height - 50);
    path.quadraticBezierTo(targetP1.dx, targetP1.dy, endP1.dx, endP1.dy);

    ///Second target curve
    final targetP2 = Offset(width * .75, height - 100);
    path.quadraticBezierTo(targetP2.dx, targetP2.dy, width, height - 50);

    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SqaureClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;

    path.lineTo(0, height / 1.5);
    path.lineTo(height / 1.5, height / 1.5);
    path.lineTo(height / 1.5, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;
    final width = size.width;

    path.lineTo(0, height);
    path.lineTo(width / 1.5, height);

    //it control tha curve
    final controlPoint = Offset(width / 1.1, 10);
    //it create arc shape
    // isme control point pahle diya jata hai(x1,y1)
    //phir wo quardinate diya jata hai jo last jaha tak drawa karna hai (x2,y2)

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, 0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurveEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height;
    final width = size.width;

    final targetHeight = height - 70;
    final targetWidth = 25.0;
    final targetWidthDiff = 70.0;
    path.lineTo(0, height);
    // path.lineTo(width, height);
    // path.lineTo(width, 0);

    ///1st arc
    final targetP1 = Offset(targetWidth, targetHeight);
    final endP1 = Offset(targetWidthDiff, height);
    path.quadraticBezierTo(targetP1.dx, targetP1.dy, endP1.dx, endP1.dy);

    //2nd arc
    final targetP2 = Offset(endP1.dx + targetWidth, targetHeight);
    final endP2 = Offset(endP1.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP2.dx, targetP2.dy, endP2.dx, endP2.dy);

    //3rd arc
    final targetP3 = Offset(endP2.dx + targetWidth, targetHeight);
    final endP3 = Offset(endP2.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP3.dx, targetP3.dy, endP3.dx, endP3.dy);

    //4th arc
    final targetP4 = Offset(endP3.dx + targetWidth, targetHeight);
    final endP4 = Offset(endP3.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP4.dx, targetP4.dy, endP4.dx, endP4.dy);

    //5th arc
    final targetP5 = Offset(endP4.dx + targetWidth, targetHeight);
    final endP5 = Offset(endP4.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP5.dx, targetP5.dy, endP5.dx, endP5.dy);

    //6th arc
    final targetP6 = Offset(endP5.dx + targetWidth, targetHeight);
    final endP6 = Offset(endP5.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP6.dx, targetP6.dy, endP6.dx, endP6.dy);

    //7th arc
    final targetP7 = Offset(endP6.dx + targetWidth, targetHeight);
    final endP7 = Offset(endP6.dx + targetWidthDiff, height);
    path.quadraticBezierTo(targetP7.dx, targetP7.dy, endP7.dx, endP7.dy);

    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

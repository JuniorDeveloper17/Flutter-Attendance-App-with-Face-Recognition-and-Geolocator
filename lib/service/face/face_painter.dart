import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'face_model.dart';

class FacePainter extends CustomPainter {
  FacePainter(
    this.absoluteImageSize,
    this.faces,
    this.camDire2,
  );

  final Size absoluteImageSize;
  final List<FaceDetectionModel> faces;
  CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    // Paint untuk kotak wajah
    final Paint boxPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigoAccent;

    // Paint untuk landmark (mata, mulut)
    final Paint landmarkPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.yellow;

    for (FaceDetectionModel face in faces) {
      // Menggambar kotak wajah
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.faceRect!.right) * scaleX
              : face.faceRect!.left * scaleX,
          face.faceRect!.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.faceRect!.left) * scaleX
              : face.faceRect!.right * scaleX,
          face.faceRect!.bottom * scaleY,
        ),
        boxPaint,
      );

      // Menggambar titik untuk contours mata kiri
      if (face.leftEye != null) {
        for (var point in face.leftEye!) {
          canvas.drawCircle(
            Offset(
              camDire2 == CameraLensDirection.front
                  ? (absoluteImageSize.width - point.x) * scaleX
                  : point.x * scaleX,
              point.y * scaleY,
            ),
            2.0, // Ukuran titik
            landmarkPaint,
          );
        }
      }

      // Menggambar titik untuk contours mata kanan
      if (face.rightEye != null) {
        for (var point in face.rightEye!) {
          canvas.drawCircle(
            Offset(
              camDire2 == CameraLensDirection.front
                  ? (absoluteImageSize.width - point.x) * scaleX
                  : point.x * scaleX,
              point.y * scaleY,
            ),
            2.0,
            landmarkPaint,
          );
        }
      }

      // Menggambar titik untuk contours mulut
      if (face.mouth != null) {
        for (var point in face.mouth!) {
          canvas.drawCircle(
            Offset(
              camDire2 == CameraLensDirection.front
                  ? (absoluteImageSize.width - point.x) * scaleX
                  : point.x * scaleX,
              point.y * scaleY,
            ),
            2.0,
            landmarkPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return true;
  }
}

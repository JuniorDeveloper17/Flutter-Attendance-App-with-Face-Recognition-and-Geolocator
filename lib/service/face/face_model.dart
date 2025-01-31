import 'dart:math';
import 'dart:ui';
import 'package:image/image.dart' as img;

class FaceModel {
  Rect? faceRect;
  List<double>? embed;

  FaceModel({this.faceRect, this.embed});
}

class FaceDetectionModel {
  img.Image? cropFace;
  Rect? faceRect;
  List<Point<int>>? leftEye;
  List<Point<int>>? rightEye;
  List<Point<int>>? mouth;

  FaceDetectionModel({
    this.cropFace,
    this.faceRect,
    this.leftEye,
    this.rightEye,
    this.mouth,
  });
}

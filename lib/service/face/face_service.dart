import 'dart:math';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as img;

import 'face_model.dart';

class FaceService {
  late FaceDetector faceDetector;
  late tfl.Interpreter interpreter;
  late tfl.InterpreterOptions interpreterOptions;

  static const int width = 112;
  static const int height = 112;

  img.Image? image;
  img.Image? cropFace;

  List<FaceModel> listFaceModel = [];
  List<FaceDetectionModel> listFaceDetectionModel = [];
  final model = 'assets/model/mobile_face_net.tflite';

  FaceService({int? numTreads}) {
    interpreterOptions = tfl.InterpreterOptions();
    if (numTreads != null) {
      interpreterOptions.threads = numTreads;
    }
    loadModel();
    faceDetector = FaceDetector(
        options: FaceDetectorOptions(
            enableContours: true,
            enableClassification: true,
            performanceMode: FaceDetectorMode.fast));
  }

  void loadModel() async {
    try {
      final gpuDelegateV2 = tfl.GpuDelegateV2(
          options: tfl.GpuDelegateOptionsV2(
              maxDelegatePartitions: 2, isPrecisionLossAllowed: false));
      interpreterOptions = tfl.InterpreterOptions()..addDelegate(gpuDelegateV2);
      interpreter =
          await tfl.Interpreter.fromAsset(model, options: interpreterOptions);
    } catch (e) {
      printInfo(info: '$e');
    }
  }

  Future<InputImage?> ambilGambarMasukanIsolate(
      Map<String, dynamic> args) async {
    final CameraImage frame = args['frame'];
    final CameraDescription cameraDescription = args['cameraDescription'];
    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in frame.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();
      final imageSize = Size(frame.width.toDouble(), frame.height.toDouble());
      final imageRotation = InputImageRotationValue.fromRawValue(
        cameraDescription.sensorOrientation,
      );
      final inputImageFormat =
          InputImageFormatValue.fromRawValue(frame.format.raw);
      final bytesPerRow =
          frame.planes.isNotEmpty ? frame.planes.first.bytesPerRow : 0;
      final inputImageMetaData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation!,
        format: inputImageFormat!,
        bytesPerRow: bytesPerRow,
      );
      return InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);
    } catch (e) {
      return null;
    }
  }

  Future<FaceDetectionModel?> deteksiWajahIsolate(
      Map<String, dynamic> args) async {
    CameraImage cameraImage = args['cameraImage'];
    List<Face> faces = args['faces'];
    CameraLensDirection camDir = args['camDir'];
    try {
      image = convertYUV420ToImage(cameraImage);
      if (image == null) return FaceDetectionModel();
      int rotationAngle = camDir == CameraLensDirection.front ? 270 : 90;
      image = img.copyRotate(image!, angle: rotationAngle);
      Face? mainFace;
      if (faces.isNotEmpty) {
        mainFace = faces.reduce((current, next) {
          return current.boundingBox.width * current.boundingBox.height >
                  next.boundingBox.width * next.boundingBox.height
              ? current
              : next;
        });
      }

      if (mainFace != null &&
          mainFace.boundingBox.width > 40 &&
          mainFace.boundingBox.height > 40) {
        listFaceDetectionModel.clear();
        List<Point<int>>? leftEye =
            mainFace.contours[FaceContourType.leftEye]?.points;
        List<Point<int>>? rightEye =
            mainFace.contours[FaceContourType.rightEye]?.points;
        List<Point<int>>? mouth =
            mainFace.contours[FaceContourType.upperLipBottom]?.points;
        Rect faceRect = mainFace.boundingBox;

        listFaceDetectionModel.add(FaceDetectionModel(
          cropFace: cropFace,
          faceRect: faceRect,
          leftEye: leftEye,
          rightEye: rightEye,
          mouth: mouth,
        ));
      }
      return listFaceDetectionModel.last;
    } catch (e) {
      return FaceDetectionModel();
    }
  }

  InputImage? ambilGambarMasukan(
      CameraImage frame, CameraController cameraController) {
    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in frame.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();
      final imageSize = Size(frame.width.toDouble(), frame.height.toDouble());
      final imageRotation = InputImageRotationValue.fromRawValue(
        cameraController.description.sensorOrientation,
      );
      final inputImageFormat =
          InputImageFormatValue.fromRawValue(frame.format.raw);
      final bytesPerRow =
          frame.planes.isNotEmpty ? frame.planes.first.bytesPerRow : 0;
      final inputImageMetaData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation!,
        format: inputImageFormat!,
        bytesPerRow: bytesPerRow,
      );
      return InputImage.fromBytes(bytes: bytes, metadata: inputImageMetaData);
    } catch (e) {
      return null;
    }
  }

  Future<List<Face>> faceDetectors(InputImage inputImage) async {
    return await faceDetector.processImage(inputImage);
  }

  FaceDetectionModel? deteksiWajah(
      CameraImage cameraImage, List<Face> faces, CameraLensDirection camDir) {
    try {
      image = convertYUV420ToImage(cameraImage);
      if (image == null) return FaceDetectionModel();
      int rotationAngle = camDir == CameraLensDirection.front ? 270 : 90;
      image = img.copyRotate(image!, angle: rotationAngle);
      Face? mainFace;
      if (faces.isNotEmpty) {
        mainFace = faces.reduce((current, next) {
          return current.boundingBox.width * current.boundingBox.height >
                  next.boundingBox.width * next.boundingBox.height
              ? current
              : next;
        });
      }
      if (mainFace != null &&
          mainFace.boundingBox.width > 40 &&
          mainFace.boundingBox.height > 40) {
        listFaceDetectionModel.clear();
        List<Point<int>>? leftEye =
            mainFace.contours[FaceContourType.leftEye]?.points;
        List<Point<int>>? rightEye =
            mainFace.contours[FaceContourType.rightEye]?.points;
        List<Point<int>>? mouth =
            mainFace.contours[FaceContourType.upperLipBottom]?.points;
        Rect faceRect = mainFace.boundingBox;
        int imageWidth = image!.width;
        int imageHeight = image!.height;
        double marginVertical = 0;
        double marginHorizontal = 0.1;

        double left = (faceRect.left + faceRect.width * marginHorizontal)
            .clamp(0, imageWidth.toDouble());
        double top = (faceRect.top + faceRect.height * marginVertical)
            .clamp(0, imageHeight.toDouble());
        double right = (faceRect.right - faceRect.width * marginHorizontal)
            .clamp(0, imageWidth.toDouble());
        double bottom = (faceRect.bottom - faceRect.height * marginVertical)
            .clamp(0, imageHeight.toDouble());

        Rect resizedFaceRect = Rect.fromLTRB(left, top, right, bottom);

        // Crop gambar berdasarkan bounding box yang lebih kecil
        cropFace = img.copyCrop(image!,
            x: resizedFaceRect.left.toInt(),
            y: resizedFaceRect.top.toInt(),
            width: resizedFaceRect.width.toInt(),
            height: resizedFaceRect.height.toInt());

        // Menambahkan hasil deteksi wajah ke dalam model
        listFaceDetectionModel.add(FaceDetectionModel(
          cropFace: cropFace,
          faceRect: resizedFaceRect,
          leftEye: leftEye,
          rightEye: rightEye,
          mouth: mouth,
        ));
      }
      return listFaceDetectionModel.last;
    } catch (e) {
      return FaceDetectionModel();
    }
  }

  Future<FaceModel> extrakEmbedding(img.Image image, Rect faceRect) async {
    var sharpenedImage = img.convolution(
      image,
      filter: [0, -1, 0, -1, 5, -1, 0, -1, 0],
      div: 1,
      offset: 0,
    );
    sharpenedImage = img.adjustColor(image, brightness: 1, hue: 0.0);
    var input = imageToArray(sharpenedImage);
    List output = List.filled(1 * 192, 0).reshape([1, 192]);
    interpreter.run(input, output);

    List<double> outputArray = output.last.cast<double>();
    return FaceModel(faceRect: faceRect, embed: outputArray);
  }

  Future<Map<String, dynamic>> validasiFace(
      List<double> emb, List<double> embServer) async {
    try {
      PairEmbedding pair = findNarest(emb, embServer);
      if (pair.distance < 1.0) {
        return {"valid": true, "distance": pair.distance};
      }
      return {"valid": false, "distance": pair.distance};
    } catch (e) {
      printInfo(info: '$e');
      throw Exception(e);
    }
  }

  PairEmbedding findNarest(List<double> emb, List<double> authFaceEmbedding) {
    PairEmbedding pair = PairEmbedding(-5);
    double distance = 0;
    for (int i = 0; i < emb.length; i++) {
      double diff = emb[i] - authFaceEmbedding[i];
      distance += diff * diff;
    }
    distance = sqrt(distance);
    if (pair.distance == -5 || distance < pair.distance) {
      pair.distance = distance;
    }
    return pair;
  }

  img.Image convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;

    final yRowStride = cameraImage.planes[0].bytesPerRow;
    final uvRowStride = cameraImage.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image =
        img.Image(width: width, height: height); // Penyesuaian di sini

    for (var h = 0; h < height; h++) {
      for (var w = 0; w < width; w++) {
        final uvIndex = uvPixelStride * (w ~/ 2) + uvRowStride * (h ~/ 2);
        final yIndex = h * yRowStride + w;

        final y = cameraImage.planes[0].bytes[yIndex];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        final color = yuv2rgb(y, u, v);
        final r = (color >> 16) & 0xFF; // Ekstraksi komponen merah
        final g = (color >> 8) & 0xFF; // Ekstraksi komponen hijau
        final b = color & 0xFF; // Ekstraksi komponen biru
        image.setPixelRgb(w, h, r, g, b); // Menggunakan setPixel di sini
      }
    }

    return image;
  }

  int yuv2rgb(int y, int u, int v) {
    final r = (y + 1.402 * (v - 128)).clamp(0, 255).toInt();
    final g =
        (y - 0.344136 * (u - 128) - 0.714136 * (v - 128)).clamp(0, 255).toInt();
    final b = (y + 1.772 * (u - 128)).clamp(0, 255).toInt();

    return (0xFF << 24) | (r << 16) | (g << 8) | b;
  }

  List<dynamic> imageToArray(img.Image inputImage) {
    img.Image resizedImage =
        img.copyResize(inputImage, width: width, height: height);
    List<double> flattendList = resizedImage.data!
        .expand((element) => [element.r, element.g, element.b])
        .map((e) => e.toDouble())
        .toList();
    Float32List float32Array = Float32List.fromList(flattendList);
    int channels = 3;
    int heights = height;
    int widths = width;

    Float32List reshapedArray = Float32List(1 * heights * widths * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < heights; h++) {
        for (int w = 0; w < widths; w++) {
          int index = c * heights * widths + h * widths + w;
          reshapedArray[index] =
              (float32Array[c * heights * widths + h * widths + w] - 127.5) /
                  127.5;
        }
      }
    }
    return reshapedArray.reshape([1, 112, 112, 3]);
  }
}

class PairEmbedding {
  double distance;
  PairEmbedding(this.distance);
}

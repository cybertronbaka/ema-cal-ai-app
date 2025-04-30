import 'dart:isolate';
import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;

abstract class ImageCompressor {
  static Future<Uint8List> compressXFile(XFile file) async {
    final imageData = await file.readAsBytes();
    final sendPort = await _spawnIsolate();
    final start = clock.now();
    final compressed = await _compress(
      imageData: imageData,
      sendPort: sendPort,
      minHeight: 800,
      minWidth: 800,
    );
    debugPrint(
      'Compressing image took ${clock.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch} ms',
    );
    return compressed;
  }

  static double calcScale({
    required double srcWidth,
    required double srcHeight,
    required double minWidth,
    required double minHeight,
  }) {
    var scaleW = minWidth / srcWidth;
    var scaleH = minHeight / srcHeight;
    var scale = math.max(0.2, math.max(scaleW, scaleH));
    return scale;
  }

  static Future<SendPort> _spawnIsolate() async {
    final ReceivePort receivePort = ReceivePort();
    final initData = (RootIsolateToken.instance!, receivePort.sendPort);
    await Isolate.spawn(_compressInIsolate, initData);
    return (await receivePort.first) as SendPort;
  }

  // Here is modified process method
  static Future<Uint8List> _compress({
    int quality = 95,
    required Uint8List imageData,
    required int minWidth,
    required int minHeight,
    required SendPort sendPort,
  }) async {
    // Create a ReceivePort for this request
    final responsePort = ReceivePort();

    // Send the image data to the isolate
    sendPort.send(<String, dynamic>{
      'imageData': imageData,
      'quality': quality,
      'minWidth': minWidth,
      'minHeight': minHeight,
      'port': responsePort.sendPort,
    });

    final compressed = (await responsePort.first) as Uint8List;
    return compressed;
  }

  static void _compressInIsolate(IsolateInitData params) {
    final ReceivePort receivePort = ReceivePort();
    params.$2.send(receivePort.sendPort);

    BackgroundIsolateBinaryMessenger.ensureInitialized(params.$1);
    receivePort.listen((message) async {
      if (message is Map<String, dynamic>) {
        final Uint8List imageData = message['imageData'] as Uint8List;
        final int quality = (message['quality'] ?? 95) as int;
        final int minWidth = message['minWidth'] as int;
        final int minHeight = message['minHeight'] as int;
        final SendPort responsePort = message['port'] as SendPort;

        try {
          final (width, height) = getImageDimensions(imageData);
          var scale = calcScale(
            srcWidth: width.toDouble(),
            srcHeight: width.toDouble(),
            minWidth: minWidth.toDouble(),
            minHeight: minHeight.toDouble(),
          );

          var result = await FlutterImageCompress.compressWithList(
            imageData,
            minHeight: (width * scale).toInt(),
            minWidth: (height * scale).toInt(),
            quality: quality,
          );

          responsePort.send(result);
          debugPrint('Image Compressed and sent to main isolate');
        } catch (e) {
          debugPrint('Error in isolate: $e');
          responsePort.send(imageData);
        } finally {
          receivePort.close();
        }
      }
    });
  }
}

typedef IsolateInitData = (RootIsolateToken rootToken, SendPort sendPort);

(int width, int height) getImageDimensions(Uint8List bytes) {
  final image = img.decodeImage(bytes);
  if (image == null) throw 'Image could not be decoded';

  return (image.width, image.height);
}

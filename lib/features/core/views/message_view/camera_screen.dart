import 'package:buy_link/features/core/notifiers/message_notifier/camera_screen_notifier.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/colors.dart';
import 'camera_preview_screen.dart';


class CameraScreen extends ConsumerStatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  CameraController? _controller;
  late List cameras;
  late int selectedCameraIdx;
  late String imagePath;

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller?.dispose();
    }

    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    _controller?.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_controller!.value.hasError) {
        print('Camera error ${_controller!.value.errorDescription}');
      }
    });

    try {
      await _controller?.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      }else{
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.grey2,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _cameraPreviewWidget(),
              ),
              Spacing.largeHeight(),
              Row(
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Spacing.mediumWidth(),
                  Container (
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),

                  ),
                  Spacing.largeWidth(),
                  Spacing.largeWidth(),
                  _captureControlRowWidget(context),
                  Spacing.largeWidth(),
                  Spacing.largeWidth(),
                  _cameraTogglesRowWidget(),
                ],
              ),
              Spacing.largeHeight(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: CameraPreview(_controller!),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Container (
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  //color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                child:
                FloatingActionButton(
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      _onCapturePressed(context);
                    }))
          ],
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: _onSwitchCamera,
          icon: Icon(_getCameraLensIcon(lensDirection), color: Colors.white, size: 24),
        ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.flip_camera_ios_outlined;
      case CameraLensDirection.front:
        return Icons.flip_camera_ios_outlined;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
    selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    _initCameraController(selectedCamera);
  }

  void _onCapturePressed(context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Attempt to take a picture and log where it's been saved
      final path = join(
        // In this example, store the picture in the temp directory. Find
        // the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      print(path);
      XFile? picture = await _controller?.takePicture();
      picture?.saveTo(path);

      // If the picture was taken, display it on a new screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewImageScreen(imagePath: path),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep/features/scan_vin_number/screen/check_vin_number.dart';

class CarPlateRecognition extends StatefulWidget {
  static const String routName = 'CarPlateRecognition';

  const CarPlateRecognition({super.key});

  @override
  CarPlateRecognitionState createState() => CarPlateRecognitionState();
}

class CarPlateRecognitionState extends State<CarPlateRecognition> {
  late CameraController cameraController;
  bool isProcessing = false;
  String recognizedText = "The text has not yet been obtained";
  String vinNumber = "VIN not found";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.first;

      cameraController = CameraController(
        camera,
        ResolutionPreset.high,
      );

      await cameraController.initialize();
      setState(() {});
    } catch (e) {
      setState(() {
        recognizedText = "Error initializing camera: $e";
      });
    }
  }

  Future<void> _captureAndRecognize() async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      final image = await cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);

      final textRecognizer = TextRecognizer();
      final RecognizedText recognized =
          await textRecognizer.processImage(inputImage);

      String extractedText = recognized.text;
      setState(() {
        recognizedText =
            extractedText.isNotEmpty ? extractedText : "No text found";
      });

      RegExp vinRegex = RegExp(r'[A-HJ-NPR-Z0-9]{17}');
      Iterable<RegExpMatch> matches = vinRegex.allMatches(extractedText);

      if (matches.isNotEmpty) {
        vinNumber = matches.first.group(0)!;
        if(mounted){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CheckVinNumber(vinNumber: vinNumber), // Pass VIN here
          ),
        );
      } }else {
        vinNumber = "VIN not found";
      }

      setState(() {
        recognizedText = extractedText;
        vinNumber = vinNumber;
      });

      await textRecognizer.close();
    } catch (e) {
      setState(() {
        recognizedText = "Error occurred while extracting text: $e";
        vinNumber = "VIN not found";
      });
    }

    setState(() {
      isProcessing = false;
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cameraController.value.isInitialized
          ? Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: CameraPreview(cameraController),
                ),
                Positioned(
                  top: 10.h,
                  left: 0,
                  right: 0,
                  child: const Text(
                    "Scan the VIN number of your car",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _captureAndRecognize,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: isProcessing
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.camera, size: 50),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        vinNumber,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child:
                  CircularProgressIndicator()),
    );
  }
}

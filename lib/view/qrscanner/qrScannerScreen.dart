import 'package:elecrama/core/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  final String type;

  const QrScannerScreen({super.key, required this.type});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController controller = MobileScannerController();
  bool isFlashOn = false;
  bool isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scan ${widget.type}",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: orange,
        actions: [
          //  Camera Flip
          IconButton(
            icon: Icon(Icons.cameraswitch),
            onPressed: () {
              controller.switchCamera();
            },
          ),
          IconButton(
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              controller.toggleTorch();

              setState(() {
                isFlashOn = !isFlashOn;
              });
            },
          ),
        ],
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          if (capture.barcodes.isNotEmpty && !isDialogOpen) {
            final String? code = capture.barcodes.first.rawValue;

            if (code != null) {
              isDialogOpen = true;

              // stop scanner while dialog open
              controller.stop();

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text("Scanned Result"),
                    content: Text(code),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);

                          controller.start();

                          isDialogOpen = false;
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "Scan any QR Code",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

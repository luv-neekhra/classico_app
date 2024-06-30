import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_app/masking_image.dart';
import 'package:widget_mask/widget_mask.dart';

class CroppedImage extends StatefulWidget {
  final CroppedFile image;
  const CroppedImage({super.key, required this.image});

  @override
  State<CroppedImage> createState() => _CroppedImageState();
}

class _CroppedImageState extends State<CroppedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cropped Image'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InteractiveViewer(
                  child: Image(
                image: FileImage(
                  File(widget.image.path),
                ),
              )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextScreen(
                            imageFile: FileImage(File(widget.image.path)),
                          ),
                        ));
                  }),
                  child: const Text(
                    "Mask Image With Text",
                    style: TextStyle(fontSize: 25),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MaskedShape(
                            imageFiles: FileImage(File(widget.image.path)),
                          ),
                        ));
                  }),
                  child: const Text(
                    "Mask image with shape",
                    style: TextStyle(fontSize: 25),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  final ImageProvider imageFile;

  const NextScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masked Image'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaskedImage(
                image: imageFile,
                child: const Text(
                  'MASK',
                  style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}

class MaskedShape extends StatelessWidget {
  final ImageProvider imageFiles;

  const MaskedShape({super.key, required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masked Image'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
            child: WidgetMask(
                blendMode: BlendMode.srcATop,
                childSaveLayer: true,
                mask: Image(image: imageFiles),
                child: Image.asset(
                    'assets/images/Custom dimensions 500x500 px.png'))),
      ),
    );
  }
}

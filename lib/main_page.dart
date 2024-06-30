import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_app/cropped_image.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void pickImage(bool pickGalleryImage) async {
    XFile? image;
    final picker = ImagePicker();

    if (pickGalleryImage == true) {
      image = await picker.pickImage(source: ImageSource.gallery);
    } else {
      image = await picker.pickImage(source: ImageSource.camera);
    }

    if (image != null) {
      final croppedImage = await cropImages(image);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => CroppedImage(
                image: croppedImage,
              )),
        ),
      );
    }
  }

  Future<CroppedFile> cropImages(XFile image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    return croppedFile!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 0.0),
                stops: [
                  0.0,
                  1.0
                ],
                colors: <Color>[
                  Colors.lightBlueAccent,
                  Color.fromARGB(255, 113, 206, 249)
                ]),
          ),
        ),
        title: const Text(
          'Image Cropper',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Myfont'),
        ),
        centerTitle: true,
        //backgroundColor: Colors.amber,
        //foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.cyanAccent, width: 5),
              ),
              color: Colors.lightBlueAccent,
              textColor: Colors.black,
              minWidth: 20,
              padding: const EdgeInsets.all(20),
              onPressed: () {
                pickImage(true);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pick Gallery Images',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Myfont',
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.photo_album_outlined,
                    size: 30,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.lightBlueAccent, width: 5),
              ),
              color: Colors.white,
              textColor: Colors.black,
              padding: const EdgeInsets.all(20),
              onPressed: () {
                pickImage(false);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Capture Camera Images',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Myfont',
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.camera_alt_outlined)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

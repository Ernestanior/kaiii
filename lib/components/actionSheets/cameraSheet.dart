import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/store/store.dart';

class CameraSheet extends StatefulWidget {
  const CameraSheet({super.key});

  @override
  State<CameraSheet> createState() => _CameraSheetState();
}

class _CameraSheetState extends State<CameraSheet> {
  @override
  void initState() {
    //  You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              // Capture a photo.
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.camera);
              if (photo == null) {
                return;
              }
              final file = File(photo.path);
              List<int> imageBytes = await file.readAsBytes();
              // Convert image to base64
              String base64Image = base64Encode(imageBytes);
              Controller.c.image({'base64': base64Image, 'uri': photo.path});
              Navigator.of(context).pushReplacementNamed('/style');
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CAMERA'.tr,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 74, 74, 74), fontSize: 16),
                  ),
                  const Icon(Icons.camera_alt,
                      color: Color.fromARGB(255, 74, 74, 74))
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 74, 74, 74),
                border: Border(bottom: BorderSide(width: 1))),
          ),
          GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
// Pick an image.
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image == null) {
                  return;
                }
                final file = File(image.path);
                List<int> imageBytes = await file.readAsBytes();
                // Convert image to base64
                String base64Image = base64Encode(imageBytes);
                Controller.c.image({
                  // 'base64': base64Image,
                  'uri': image.path
                });
                var formData = FormData({'file': base64Image});
                dynamic imgUrl = await base64Upload(formData);
                Controller.c.imgUrl(imgUrl);
                Navigator.of(context).pushReplacementNamed('/style');
              },
              child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PHOTO_LIBRARY'.tr,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 74, 74, 74),
                            fontSize: 16),
                      ),
                      const Icon(
                        Icons.photo,
                        color: Color.fromARGB(255, 74, 74, 74),
                      )
                    ],
                  ))),
          Container(
            height: 5,
          )
        ],
      ),
    );
  }
}

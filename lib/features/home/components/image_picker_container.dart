import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osago_bloc_app/features/home/components/upload_photo_container.dart';

import '../emergency/emergancy_data_page.dart';

class ImagePickerContainer extends StatefulWidget {
  const ImagePickerContainer({super.key});

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {

  List<File> selectedPhotos = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Фото автомобиля',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          if (selectedPhotos.isEmpty)
            UploadPhotosContainer(
              selectedImageCallback: (selectedImages) {
                selectedPhotos = selectedImages;
                setState(() {});
              },
            )
          else
            GridView.builder(
              shrinkWrap: true,
              itemCount: selectedPhotos.length + 1,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == selectedPhotos.length) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          List<File> newImages =
                          await ImagePickerUtil.getImages();
                          selectedPhotos.addAll(newImages);
                          setState(() {});
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color:
                                Theme.of(context).colorScheme.primary,
                              )),
                          padding: const EdgeInsets.only(
                            // right: 10,
                            // bottom: 10,
                          ),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.only(
                            right: 10,
                            bottom: 10,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              selectedPhotos[index],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Positioned(
                        right: 2,
                        top: -7,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPhotos.removeAt(index);
                            });
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
        ],
      );
  }
}


class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<File>> getImages() async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: 100);
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      return pickedFiles.map((xFile) => File(xFile.path)).toList();
    }
    return [];
  }
}
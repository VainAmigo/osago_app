import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/components/my_outlined_button.dart';

class UploadPhotosContainer extends StatelessWidget {
  final Function(List<File>) selectedImageCallback;

  const UploadPhotosContainer({
    super.key,
    required this.selectedImageCallback,
  });

  Future<void> _pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage(imageQuality: 100);
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final images = pickedFiles.map((e) => File(e.path)).toList();
      selectedImageCallback(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImages(context),
      child: MyOutlinedButton(text: 'Добавить фото авто', icon: Icons.add_circle_outline,),
    );
  }
}

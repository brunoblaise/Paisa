import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paisa/src/core/enum/box_types.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/settings/settings_service.dart';
import '../../../service_locator.dart';

part 'user_image_state.dart';

class UserNameImageCubit extends Cubit<UserImageState> {
  UserNameImageCubit() : super(UserImageInitial());
  String selectedImage = '';

  void pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        selectedImage = pickedFile.path;
        locator
            .getAsync<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
            .then((value) => value.put(userImageKey, selectedImage));
      }
    });
  }

  void updateUserDetails(String name) {
    locator
        .getAsync<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
        .then((value) => value.put(userNameKey, name));
  }
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webspc/widget/sizer.dart';
import 'package:webspc/widget/touchable_opacity.dart';

class ImagePickerResult {
  final String? imagePath;

  ImagePickerResult({this.imagePath});
}

class CustomImagePicker {
  Future<ImagePickerResult?> pickImage(
      ImageSource imageSource, BuildContext context) async {
    final picker = ImagePicker();
    Navigator.pop(context);
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return ImagePickerResult(imagePath: null);
    } else {
      return ImagePickerResult(imagePath: pickedFile.path);
    }
  }

  openImagePicker(
    BuildContext _context,
    String text,
    Function(ImagePickerResult?) callback,
  ) async {
    final picker = ImagePicker();
    showModalBottomSheet<ImagePickerResult?>(
      context: _context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 260,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.camera),
                      title: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.camera);
                        Navigator.pop(context);
                        callback.call(ImagePickerResult(
                          imagePath: pickedFile?.path,
                        ));
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Color(0xffe5e5e5),
                    ),
                    ListTile(
                      leading: Icon(Icons.picture_in_picture),
                      title: Text(
                        'Thư viện',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        Navigator.pop(context);
                        callback.call(ImagePickerResult(
                          imagePath: pickedFile?.path,
                        ));
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.center,
                      child: TouchableOpacity(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 200.sp,
                            height: 50.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[300],
                            ),
                            child: Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

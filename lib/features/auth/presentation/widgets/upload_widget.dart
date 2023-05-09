import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/keys.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:cloudinary/cloudinary.dart';

class UploadWidget extends StatefulWidget {
  UploadWidget({Key? key, required this.fileName}) : super(key: key);
  String fileName;

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  String? emailAddress;

  getSavedEmail() async {
    SharedPrefHelper prefHelper = SharedPrefHelper();
    await prefHelper.init();
    emailAddress = prefHelper.getValue('emailAddress');
  }

  @override
  void initState() {
    getSavedEmail();
    super.initState();
  }

  final cloudinary = Cloudinary.signedConfig(
    apiKey: apiKey,
    apiSecret: apiSecret,
    cloudName: cloudName,
  );
  bool isFileLoaded = false;
  bool isFileUploading = false;
  int percent = 0;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.lightBlue,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: double.infinity,
          color: AppColors.backgroundLightBlue,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBody(
                  'Upload your file',
                  color: AppColors.lightBlue,
                  fontSize: 13,
                ),
                TextBody(
                  'Max 5mb, PDF, JPG, DOC',
                  color: AppColors.black,
                  fontSize: 8,
                ),
                gapSmall,
                gapTiny,
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc'],
                    );

                    if (result != null) {
                      setState(() {
                        isFileUploading = true;
                      });
                      File file = File(result.files.single.path!);
                      final response = await cloudinary.upload(
                          file: file.path,
                          fileBytes: file.readAsBytesSync(),
                          resourceType: CloudinaryResourceType.image,
                          folder: 'emmerenciaDemo',
                          fileName: '${widget.fileName} of ${emailAddress!}',
                          progressCallback: (count, total) {
                            setState(() {
                              percent = ((count / total) * 100).toInt();
                            });

                            print(
                                'Uploading image from file with progress: $percent/100%');
                          });

                      if (response.isSuccessful) {
                        print('Get your image from with ${response.secureUrl}');
                      }
                      setState(() {
                        isFileLoaded = true;
                        isFileUploading = false;
                        percent = 0;
                      });
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 27, vertical: 8.5),
                        child: Center(
                          child: TextBody(
                            isFileUploading
                                ? "Uploading ${percent}/100%"
                                : isFileLoaded
                                    ? "Change File"
                                    : 'Choose a file',
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                gapSmall,
                gapTiny,
                TextBody(
                  isFileLoaded ? "File Loaded" : 'No file upoaded',
                  color: AppColors.black,
                  fontSize: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

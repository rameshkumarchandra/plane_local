import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/services/dio_service.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../config/enums.dart';

class WorkspaceLogo extends ConsumerStatefulWidget {
  const WorkspaceLogo({super.key});

  @override
  ConsumerState<WorkspaceLogo> createState() => _WorkspaceLogoState();
}

class _WorkspaceLogoState extends ConsumerState<WorkspaceLogo> {
  File? coverImage;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    var fileProvider = ref.watch(ProviderList.fileUploadProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      var file = await ImagePicker.platform
                          .pickImage(source: ImageSource.gallery);
                      if (file != null) {
                        setState(() {
                          coverImage = File(file.path);
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_upload_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            'Upload',
                            type: FontStyle.subheading,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              coverImage != null
                  ? GestureDetector(
                      onTap: () async {
                        var file = await ImagePicker.platform
                            .pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            coverImage = File(file.path);
                          });
                        }
                      },
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.file(coverImage!).image,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                    text: 'UPLOAD',
                    ontap: () async {
                      var url = await fileProvider.uploadFile(
                        coverImage!,
                        coverImage!.path.split('.').last,
                      );
                      if (url != null) {
                        workspaceProvider.changeLogo(logo: url);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          fileProvider.fileUploadState == AuthStateEnum.loading
              ? Container(
                  alignment: Alignment.center,
                  color: themeProvider.isDarkThemeEnabled
                      ? Colors.black.withOpacity(0.7)
                      : Colors.white.withOpacity(0.7),
                  // height: 25,
                  // width: 25,
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [
                            themeProvider.isDarkThemeEnabled
                                ? Colors.white
                                : Colors.black
                          ],
                          strokeWidth: 1.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

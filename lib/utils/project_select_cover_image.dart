import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/button.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

import '../config/enums.dart';

class SelectCoverImage extends ConsumerStatefulWidget {
  const SelectCoverImage({super.key});

  @override
  ConsumerState<SelectCoverImage> createState() => _SelectCoverImageState();
}

class _SelectCoverImageState extends ConsumerState<SelectCoverImage> {
  var selected = 0;
  File? coverImage;
  @override
  void initState() {
    if (ref.read(ProviderList.projectProvider).unsplashImages.isEmpty) {
      // ref.read(ProviderList.projectProvider).getUnsplashImages();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var projectProvider = ref.watch(ProviderList.projectProvider);
    var fileProvider = ref.watch(ProviderList.fileUploadProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                            color: selected == 0 ? primaryColor : null,
                            borderRadius: BorderRadius.circular(5)),
                        child: CustomText(
                          'Unsplash',
                          type: FontStyle.title,
                          color: selected == 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                            color: selected == 1 ? primaryColor : null,
                            borderRadius: BorderRadius.circular(5)),
                        child: CustomText(
                          'Upload',
                          type: FontStyle.title,
                          color: selected == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                selected == 1
                    ? Container()
                    : Row(
                        children: [
                          Container(
                            //   height: 50,
                            width: MediaQuery.of(context).size.width - 130,
                            child: TextFormField(
                                decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Search for images',
                            )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomText(
                                'Search',
                                type: FontStyle.buttonText,
                              ),
                            ),
                          ),
                        ],
                      ),
                // Wrap(
                //   children: projectProvider.unsplashImages.map((e) => GestureDetector(
                //     onTap: (){
                //     },
                //     child:
                //       Container(
                //           height: 100,
                //           width: 120,
                //           decoration: BoxDecoration(
                //               color: Colors.grey[300],
                //               image:  DecorationImage(
                //                       fit: BoxFit.cover,
                //                       image: Image.network(e['urls']['raw']!).image)
                //                  ),

                //         ),
                //   )).toList()

                // )

                selected == 1 && coverImage == null
                    ? Expanded(
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
                      )
                    : Container(),

                selected == 1 && coverImage != null
                    ? GestureDetector(
                      onTap: ()async{
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
                    : Container(),
                selected == 1 && coverImage != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: 'UPLOAD',
                            ontap: () async {
                              await fileProvider.uploadFile(coverImage!,
                                  coverImage!.path.split('.').last);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
            projectProvider.unsplashImageState == AuthStateEnum.loading ||
                    fileProvider.fileUploadState == AuthStateEnum.loading
                ? Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.7),
                    // height: 25,
                    // width: 25,
                    child: Wrap(
                      children: const [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineSpinFadeLoader,
                            colors: [Colors.black],
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
      ),
    );
  }
}
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../config/const.dart';
import 'package:http_parser/http_parser.dart';

class FileUploadProvider extends ChangeNotifier {
  FileUploadProvider(ChangeNotifierProviderRef<FileUploadProvider> this.ref);
  Ref? ref;
  static String? _downloadUrl;
  StateEnum fileUploadState = StateEnum.empty;

  Future<String?> uploadFile(File pickedFile, String fileType) async {
    fileUploadState = StateEnum.loading;
    notifyListeners();
    var type = pickedFile.path.split('.').last;

    var dio = Dio();
    var formData = FormData.fromMap({
      "asset": await MultipartFile.fromFile(pickedFile.path,
          filename: 'fileName.$type', contentType: MediaType(fileType, type)),
      "attributes": jsonEncode("{}")
    });
    var token = Const.appBearerToken;
    var response = await dio
        .post(APIs.fileUpload,
            data: formData,
            onSendProgress: (sent, total) {},
            options: Options(headers: {
              "Content-type": "multipart/form-data",
              "Authorization": "Bearer $token"
            }))
        .catchError((e) {
      fileUploadState = StateEnum.error;
      notifyListeners();
      log(e);
      throw e;
    });
    _downloadUrl = response.data['asset'];

    fileUploadState = StateEnum.success;
    print(_downloadUrl);

    notifyListeners();
    return _downloadUrl;
  }

  String? get downloadUrl => _downloadUrl;
}

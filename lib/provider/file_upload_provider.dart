import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/enums.dart';

import '../config/apis.dart';
import '../config/const.dart';
import 'package:http_parser/http_parser.dart';


class FileUploadProvider extends ChangeNotifier {
  static String? _downloadUrl;
  List downloadUrls = [];
  AuthStateEnum fileUploadState = AuthStateEnum.empty;

    Future uploadFile(File pickedFile, String fileType) async {
    fileUploadState = AuthStateEnum.loading;
    notifyListeners();
    var type = pickedFile.path.split('.').last;

    var dio = Dio();
    var formData = FormData.fromMap({
      "asset": await MultipartFile.fromFile(pickedFile.path,
          filename: 'fileName.$type', contentType: MediaType(fileType, type)),
      "attributes": jsonEncode("{}")
    });
    var token =  Const.appBearerToken;
    var response = await dio.post(APIs.fileUpload, data: formData,
        onSendProgress: (sent, total) {
    },
        options: Options(headers: {
          "Content-type": "multipart/form-data",
          "Authorization": "Bearer $token"
        })).catchError((e) {
      fileUploadState = AuthStateEnum.error;
      notifyListeners();
      log(e);
      throw e;
    });
    _downloadUrl = response.data['asset'];
    fileUploadState = AuthStateEnum.success;
    print(_downloadUrl);
    notifyListeners();
    return response.data;
  }

  String? get downloadUrl => _downloadUrl;

}

  
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plane_startup/config/const.dart';
import 'package:plane_startup/kanban/models/project_detail_model.dart';

import '../config/apis.dart';
import '../config/enums.dart';
import '../services/dio_service.dart';

class ProjectsProvider extends ChangeNotifier {
  var projects = [];
  var starredProjects = [];
  var projectState = AuthStateEnum.empty;
  var unsplashImageState = AuthStateEnum.empty;
  var createProjectState = AuthStateEnum.empty;
  var projectDetailState = AuthStateEnum.empty;
  var unsplashImages = [];
  var currentProject={};
  var coverUrl =
      "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
  ProjectDetailModel? projectDetailModel;

  void changeCoverUrl({required String url}) {
    coverUrl = url;
    notifyListeners();
  }

  Future getUnsplashImages() async {
    unsplashImageState = AuthStateEnum.loading;
    //  notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: false,
        url: APIs.unsplashImages,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      unsplashImages = response.data;
      unsplashImageState = AuthStateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log(e.response!.data.toString());
      unsplashImageState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getProjects({required String slug}) async {
    projectState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.listProjects.replaceAll('\$SLUG', slug),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      projects = response.data;
      projectState = AuthStateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log(e.error.toString());
      projectState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future favouriteProjects(
      {required String slug,
      required HttpMethod method,
      required String projectID,
      required int index}) async {
    projectState = AuthStateEnum.loading;
    notifyListeners();
    try {
      log(APIs.favouriteProjects.replaceAll('\$SLUG', slug) + projectID);
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: method == HttpMethod.delete
            ? APIs.favouriteProjects.replaceAll('\$SLUG', slug) +
                projectID +
                '/'
            : APIs.favouriteProjects.replaceAll('\$SLUG', slug),
        hasBody: method == HttpMethod.post ? true : false,
        data: method == HttpMethod.post
            ? {
                "project": projectID,
              }
            : null,
        httpMethod: method,
      );
      if (method == HttpMethod.post) {
        projects.removeAt(index);
        starredProjects.add(response.data);
      } else if (method == HttpMethod.get) {
        starredProjects = response.data;
      } else {
        projects.add(starredProjects.removeAt(index)['project_detail']);
      }

      projectState = AuthStateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log("ERROR=" + e.response.toString());
      projectState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future createProjects({required String slug, required data}) async {
    createProjectState = AuthStateEnum.loading;
    notifyListeners();
    log(slug);
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.createProjects.replaceAll('\$SLUG', slug),
        hasBody: true,
        data: data,
        httpMethod: HttpMethod.post,
      );
      log(response.data.toString());
      await getProjects(slug: slug);
      createProjectState = AuthStateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      print('---- ERROR ------');
      ScaffoldMessenger.of(Const.globalKey.currentContext!).showSnackBar(const SnackBar(content: Text('Identifier already exists')));
      log(e.error.toString());
      createProjectState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectDetails({required String slug, required String projId}) async {
    // projectDetailState = AuthStateEnum.loading;
    // notifyListeners();
    log("${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId");
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/",
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      projectDetailModel = ProjectDetailModel.fromJson(response.data);
      print('====== SUCCESS =====');
      projectDetailState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
            print('====== FAILED =====');

      log(e.error.toString());
      projectDetailState = AuthStateEnum.error;
      notifyListeners();
    }
  }

}

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
  var projectMembersState = AuthStateEnum.empty;
  var deleteProjectState = AuthStateEnum.empty;
  var deleteProjectMemberState = AuthStateEnum.empty;
  var updateProjecState = AuthStateEnum.empty;
  var unsplashImages = [];
  var currentProject={};
  List projectMembers = [];
  var coverUrl =
      "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
  ProjectDetailModel? projectDetailModel;

    List features = [
      {'title': 'Issues', 'width': 60, 'show' : true},
      {'title': 'Cycles', 'width': 60, 'show' : true},
      {'title': 'Modules', 'width': 75, 'show' : true},
      {'title': 'Views', 'width': 60, 'show' : true},
      {'title': 'Pages', 'width': 50, 'show' : true},
    ];

 void clear(){
    projects = [];
    starredProjects = [];
    projectState = AuthStateEnum.empty;
    unsplashImageState = AuthStateEnum.empty;
    createProjectState = AuthStateEnum.empty;
    projectDetailState = AuthStateEnum.empty;
    deleteProjectState = AuthStateEnum.empty;
    deleteProjectMemberState = AuthStateEnum.empty;
    updateProjecState = AuthStateEnum.empty;
    unsplashImages = [];
    currentProject={};
    coverUrl =
        "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
    projectDetailModel=null;
 }

 void setState() {
  notifyListeners();
 }

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
            ? '${APIs.favouriteProjects.replaceAll('\$SLUG', slug)}$projectID/'
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
        // projects.add(starredProjects.removeAt(index)['project_detail']);
      }
      await getProjects(slug: slug);
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
      features[1]['show'] = projectDetailModel!.cycleView ?? true;
      features[2]['show'] = projectDetailModel!.moduleView ?? true;
      features[3]['show'] = projectDetailModel!.issueViewsView ?? true;
      features[4]['show'] = projectDetailModel!.pageView ?? true;
      print('====== SUCCESS =====');
      getProjectMembers(slug: slug, projId: projId);
      projectDetailState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
            print('====== FAILED =====');

      log(e.error.toString());
      projectDetailState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future updateProject({required String slug, required String projId,required Map data}) async {
    print(data);
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/",
        hasBody: true,
        httpMethod: HttpMethod.patch,
        data: data
      );
      print('====== SUCCESS =====');
      updateProjecState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');
      log(e.error.toString());
      updateProjecState = AuthStateEnum.error;
      notifyListeners();
    }
  }

    Future getProjectMembers({required String slug, required String projId}) async {
    // projectDetailState = AuthStateEnum.loading;
    // notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/members/",
        hasBody: false,
        httpMethod: HttpMethod.get,
      );

      projectMembers = response.data;
      for(int i = 0; i < projectMembers.length; i++) {
        print(projectMembers[i]['member']['id']);
      }
      print('====== SUCCESS =====');
      projectMembersState = AuthStateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
            print('====== FAILED =====');

      log(e.error.toString());
      projectMembersState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future deleteProject({required String slug, required String projId}) async {
    try {
      deleteProjectState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/",
        hasBody: false,
        httpMethod: HttpMethod.delete,
      );
      print('====== SUCCESS =====');
      deleteProjectState = AuthStateEnum.success;
      notifyListeners();
    }
    on DioError catch (e) {
      log(e.error.toString());
      deleteProjectState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future deleteProjectMember({required String slug, required String projId,required String userId}) async {
    try {
      var url = "${APIs.listProjects.replaceFirst('\$SLUG', slug)}$projId/member/$userId/";
      print(url);
      deleteProjectMemberState = AuthStateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.delete,
      );
      print('====== SUCCESS =====');
      deleteProjectMemberState = AuthStateEnum.success;
      notifyListeners();
    }
    on DioError catch (e) {
      log(e.message.toString());
      deleteProjectMemberState = AuthStateEnum.error;
      notifyListeners();
    }
  }

}

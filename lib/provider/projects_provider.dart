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
  var projectState = StateEnum.empty;
  var unsplashImageState = StateEnum.empty;
  var createProjectState = StateEnum.empty;
  var projectDetailState = StateEnum.empty;
  var projectMembersState = StateEnum.empty;
  var deleteProjectState = StateEnum.empty;
  var deleteProjectMemberState = StateEnum.empty;
  var updateProjecState = StateEnum.empty;
  var stateCrudState = StateEnum.empty;
  var projectLabelsState = StateEnum.empty;
  var projectInvitationState = StateEnum.empty;
  var unsplashImages = [];
  var currentProject = {};
  List projectMembers = [];
  var coverUrl =
      "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
  ProjectDetailModel? projectDetailModel;

  List features = [
    {'title': 'Issues', 'width': 60, 'show': true},
    {'title': 'Cycles', 'width': 60, 'show': true},
    {'title': 'Modules', 'width': 75, 'show': true},
    {'title': 'Views', 'width': 60, 'show': true},
    {'title': 'Pages', 'width': 50, 'show': true},
  ];

  void clear() {
    projects = [];
    starredProjects = [];
    projectState = StateEnum.empty;
    unsplashImageState = StateEnum.empty;
    createProjectState = StateEnum.empty;
    projectDetailState = StateEnum.empty;
    deleteProjectState = StateEnum.empty;
    deleteProjectMemberState = StateEnum.empty;
    updateProjecState = StateEnum.empty;
    stateCrudState = StateEnum.empty;
    unsplashImages = [];
    currentProject = {};
    coverUrl =
        "https://app.plane.so/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1575116464504-9e7652fddcb3%3Fcrop%3Dentropy%26cs%3Dtinysrgb%26fit%3Dmax%26fm%3Djpg%26ixid%3DMnwyODUyNTV8MHwxfHNlYXJjaHwxOHx8cGxhbmV8ZW58MHx8fHwxNjgxNDY4NTY5%26ixlib%3Drb-4.0.3%26q%3D80%26w%3D1080&w=1920&q=75";
    projectDetailModel = null;
  }

  void setState() {
    notifyListeners();
  }

  void changeCoverUrl({required String url}) {
    coverUrl = url;
    notifyListeners();
  }

  Future getUnsplashImages() async {
    unsplashImageState = StateEnum.loading;
    //  notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: false,
        url: APIs.unsplashImages,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      unsplashImages = response.data;
      unsplashImageState = StateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log(e.response!.data.toString());
      unsplashImageState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getProjects({required String slug}) async {
    projectState = StateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.listProjects.replaceAll('\$SLUG', slug),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      projects = response.data;
      projectState = StateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log(e.error.toString());
      projectState = StateEnum.error;
      notifyListeners();
    }
  }

  Future favouriteProjects(
      {required String slug,
      required HttpMethod method,
      required String projectID,
      required int index}) async {
    projectState = StateEnum.loading;
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
      projectState = StateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log("ERROR=" + e.response.toString());
      projectState = StateEnum.error;
      notifyListeners();
    }
  }

  Future inviteToProject({
    required String slug,
    required String projId,
    required data,
  }) async {
    projectInvitationState = StateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.inviteToProject.replaceAll('\$SLUG', slug).replaceAll(
              '\$PROJECTID',
              projId,
            ),
        hasBody: true,
        data: data,
        httpMethod: HttpMethod.post,
      );
      log(response.data.toString());
      projectInvitationState = StateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      log('Project Invite Error =  ${e.message}');
      log(e.error.toString());
      projectInvitationState = StateEnum.error;
      notifyListeners();
    }
  }

  Future createProjects({required String slug, required data}) async {
    createProjectState = StateEnum.loading;
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
      createProjectState = StateEnum.success;
      notifyListeners();
      // log(response.data.toString());
    } on DioError catch (e) {
      print('---- ERROR ------');
      ScaffoldMessenger.of(Const.globalKey.currentContext!).showSnackBar(
          const SnackBar(content: Text('Identifier already exists')));
      log(e.error.toString());
      createProjectState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectDetails(
      {required String slug, required String projId}) async {
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
      projectDetailState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');

      log(e.error.toString());
      projectDetailState = StateEnum.error;
      notifyListeners();
    }
  }

  Future updateProject(
      {required String slug, required String projId, required Map data}) async {
    print(data);
    try {
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/",
          hasBody: true,
          httpMethod: HttpMethod.patch,
          data: data);
      print('====== SUCCESS =====');
      updateProjecState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');
      log(e.error.toString());
      updateProjecState = StateEnum.error;
      notifyListeners();
    }
  }

  Future getProjectMembers(
      {required String slug, required String projId}) async {
    // projectDetailState = AuthStateEnum.loading;
    // notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.projectMembers
            .replaceFirst('\$SLUG', slug)
            .replaceFirst('\$PROJECTID', projId),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );

      projectMembers = response.data;
      for (int i = 0; i < projectMembers.length; i++) {
        print(projectMembers[i]['member']['id']);
      }
      print('====== SUCCESS =====');
      projectMembersState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      print('====== FAILED =====');

      log(e.error.toString());
      projectMembersState = StateEnum.error;
      notifyListeners();
    }
  }

  Future deleteProject({required String slug, required String projId}) async {
    try {
      deleteProjectState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: "${APIs.listProjects.replaceAll('\$SLUG', slug)}$projId/",
        hasBody: false,
        httpMethod: HttpMethod.delete,
      );
      print('====== SUCCESS =====');
      deleteProjectState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.error.toString());
      deleteProjectState = StateEnum.error;
      notifyListeners();
    }
  }

  Future deleteProjectMember(
      {required String slug,
      required String projId,
      required String userId}) async {
    try {
      var url =
          '${APIs.projectMembers.replaceFirst('\$SLUG', slug).replaceFirst('\$PROJECTID', projId)}$userId/';
      print(url);
      deleteProjectMemberState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: url,
        hasBody: false,
        httpMethod: HttpMethod.delete,
      );
      print('====== SUCCESS =====');
      deleteProjectMemberState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      deleteProjectMemberState = StateEnum.error;
      notifyListeners();
    }
  }

  Future stateCrud(
      {required String slug,
      required String projId,
      required String stateId,
      required CRUD method,
      required Map data}) async {
    try {
      var url = method == CRUD.update
          ? APIs.states
                  .replaceFirst('\$SLUG', slug)
                  .replaceFirst('\$PROJECTID', projId) +
              stateId +
              '/'
          : APIs.states
              .replaceFirst('\$SLUG', slug)
              .replaceFirst('\$PROJECTID', projId);
      print(url);
      stateCrudState = StateEnum.loading;
      notifyListeners();
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: url,
          hasBody: true,
          httpMethod: method == CRUD.create
              ? HttpMethod.post
              : method == CRUD.update
                  ? HttpMethod.put
                  : HttpMethod.patch,
          data: data);
      print('====== SUCCESS =====');
      stateCrudState = StateEnum.success;
      notifyListeners();
    } on DioError catch (e) {
      log(e.message.toString());
      stateCrudState = StateEnum.error;
      notifyListeners();
    }
  }
}

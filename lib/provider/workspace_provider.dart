import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../config/enums.dart';
import '../services/dio_service.dart';

class WorkspaceProvider extends ChangeNotifier {
  WorkspaceProvider(ChangeNotifierProviderRef<WorkspaceProvider> this.ref);
  Ref? ref;
  var workspaceInvitations = [];
  var workspaces = [];
  var urlNotAvailable = false;
  var currentWorkspace = {};
  AuthStateEnum workspaceInvitationState = AuthStateEnum.loading;
  AuthStateEnum selectWorkspaceState = AuthStateEnum.empty;

  Future getWorkspaceInvitations() async {
    workspaceInvitationState = AuthStateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.baseApi + APIs.listWorkspaceInvitaion,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      workspaceInvitationState = AuthStateEnum.success;
      workspaceInvitations = response.data;
      //log(response.data.toString());
      notifyListeners();
      // return response.data;
    } catch (e) {
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future joinWorkspaces({required data}) async {
    workspaceInvitationState = AuthStateEnum.loading;
    notifyListeners();

    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: (APIs.joinWorkspace),
        hasBody: true,
        data: {"invitations": data},
        httpMethod: HttpMethod.post,
      );
      workspaceInvitationState = AuthStateEnum.success;
      log(response.data.toString());
      notifyListeners();
      // return response.data;
    } catch (e) {
      log("ERROR" + e.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future createWorkspace(
      {required String name,
      required String slug,
      required String size}) async {
    workspaceInvitationState = AuthStateEnum.loading;
    notifyListeners();
    // return;
    try {
      var response = await DioConfig().dioServe(
          hasAuth: true,
          url: APIs.createWorkspace,
          hasBody: true,
          httpMethod: HttpMethod.post,
          data: {"name": name, "slug": slug, "company_size": int.parse(size)});
      await getWorkspaces();
      workspaceInvitationState = AuthStateEnum.success;
      log(response.data.toString());
      notifyListeners();
      // return response.data;
    } catch (e) {
      log(e.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future checkWorspaceSlug({required String slug}) async {
    workspaceInvitationState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.workspaceSlugCheck.replaceAll('SLUG', slug),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      if (response.data['status'] == false) {
        urlNotAvailable = true;
      } else {
        urlNotAvailable = false;
      }
      //  workspaceInvitationState = AuthStateEnum.success;
      log(response.data.toString());
      //  notifyListeners();
      return !urlNotAvailable;
    } catch (e) {
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future inviteToWorkspace({required String slug, required data}) async {
    workspaceInvitationState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.inviteToWorkspace.replaceAll('\$SLUG', slug),
        hasBody: true,
        data: {"emails": data},
        httpMethod: HttpMethod.post,
      );
      workspaceInvitationState = AuthStateEnum.success;
      log(response.data.toString());
      notifyListeners();
      return !urlNotAvailable;
    } catch (e) {
      log(e.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future getWorkspaces() async {
    workspaceInvitationState = AuthStateEnum.loading;
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.listWorkspaces,
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      workspaceInvitationState = AuthStateEnum.success;
      workspaces = response.data;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future selectWorkspace({required String id}) async {
    selectWorkspaceState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.baseApi + APIs.profile,
        hasBody: true,
        data: {"last_workspace_id": id},
        httpMethod: HttpMethod.patch,
      );
      selectWorkspaceState = AuthStateEnum.success;
      ref!.read(ProviderList.profileProvider).userProfile.last_workspace_id =id;
      log(response.data.toString());
      notifyListeners();
      // return response.data;
    } catch (e) {
      log(e.toString());
      selectWorkspaceState = AuthStateEnum.error;
      notifyListeners();
    }
  }
}

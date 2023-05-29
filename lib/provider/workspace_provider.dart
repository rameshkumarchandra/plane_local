import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:plane_startup/provider/provider_list.dart';

import '../config/apis.dart';
import '../config/enums.dart';
import '../models/user_profile_model.dart';
import '../models/workspace_model.dart';
import '../services/dio_service.dart';

class WorkspaceProvider extends ChangeNotifier {
  WorkspaceProvider(ChangeNotifierProviderRef<WorkspaceProvider> this.ref);
  Ref? ref;
  var workspaceInvitations = [];
  var workspaces = [];
  WorkspaceModel? selectedWorkspace;
  var urlNotAvailable = false;
  var currentWorkspace = {};
  var workspaceMembers = [];
  WorkspaceModel? workspace;
  AuthStateEnum workspaceInvitationState = AuthStateEnum.empty;
  AuthStateEnum selectWorkspaceState = AuthStateEnum.empty;
  AuthStateEnum uploadImageState = AuthStateEnum.empty;
  AuthStateEnum getMembersState = AuthStateEnum.empty;

  void changeLogo({required String logo}) {
    selectedWorkspace!.workspaceLogo = logo;
    notifyListeners();
  }

  void removeLogo() {
    selectedWorkspace!.workspaceLogo = '';
    notifyListeners();
  }

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

  Future<int> createWorkspace(
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
      return response.statusCode!;
      // return response.data;
    } on DioError catch (e) {
      log(e.response!.data.toString());
      log(e.message.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
      return e.response!.statusCode!;
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
    } on DioError catch (e) {
      log('ERRORRRR');
      log(e.response!.data.toString());
      log(e.message.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future inviteToWorkspace({required String slug, required email, role}) async {
    workspaceInvitationState = AuthStateEnum.loading;
    notifyListeners();
    try {
      log(APIs.inviteToWorkspace.replaceAll('\$SLUG', slug));
      log(role == null ? "ROLE NULL" : "ROLE NOT NULL");
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.inviteToWorkspace.replaceAll('\$SLUG', slug),
        hasBody: true,
        data: role == null
            ? {"emails": email}
            : {
                "emails": [
                  {"email": email, "role": role}
                ]
              },
        httpMethod: HttpMethod.post,
      );
      workspaceInvitationState = AuthStateEnum.success;
      log(response.data.toString());
      notifyListeners();
      return !urlNotAvailable;
    } on DioError catch (e) {
      log(e.response!.data.toString());
      log(e.message.toString());
      workspaceInvitationState = AuthStateEnum.error;
      notifyListeners();
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

      var isWorkspacePresent = workspaces.where((element) {
        if (element['id'] ==
            ref!
                .read(ProviderList.profileProvider)
                .userProfile
                .last_workspace_id) {
          currentWorkspace = element;
          selectedWorkspace = WorkspaceModel.fromJson(element);
          return true;
        }
        return false;
      });

      if (isWorkspacePresent.isEmpty) {
        currentWorkspace = workspaces[0];
        selectedWorkspace = WorkspaceModel.fromJson(workspaces[0]);
        log('AFTER DELETE WORKSPACE ${selectedWorkspace!.workspaceName}  ${currentWorkspace['id']}');
      }

      log(response.data.toString());
      log('SELECTED WORKSPACE ${selectedWorkspace!.workspaceName}');
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
      ref!.read(ProviderList.profileProvider).userProfile =
          UserProfile.fromMap(response.data);

      ref!.read(ProviderList.profileProvider).userProfile.last_workspace_id =
          id;

      currentWorkspace = workspaces.where((element) {
        if (element['id'] ==
            ref!
                .read(ProviderList.profileProvider)
                .userProfile
                .last_workspace_id) {
          currentWorkspace = element;
          return true;
        }
        return false;
      }).first;

      // ref!.read(ProviderList.projectProvider).getProjects(
      //         slug: currentWorkspace['slug']);
      // ref!.read(ProviderList.projectProvider).favouriteProjects(
      //     index: 0,
      //     slug: currentWorkspace['slug'],
      //     method: HttpMethod.get,
      //     projectID: "");
      log(response.data.toString());
      notifyListeners();
      // return response.data;
    } on DioError catch (e) {
      log(e.toString());
      selectWorkspaceState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future retrieveWorkspace({required String slug}) async {
    selectWorkspaceState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.retrieveWorkspace.replaceAll('\$SLUG', slug),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      selectWorkspaceState = AuthStateEnum.success;
      log(response.data.toString());
      // response = jsonDecode(response.data);
      selectedWorkspace = WorkspaceModel.fromJson(response.data);

      log('SELECTED WORKSPACE ${selectedWorkspace!.workspaceName}');

      notifyListeners();
      // log(response.data.toString());
    } catch (e) {
      log(e.toString());
      selectWorkspaceState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future updateWorkspace({required data}) async {
    selectWorkspaceState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.retrieveWorkspace.replaceAll(
          '\$SLUG',
          selectedWorkspace!.workspaceSlug,
        ),
        hasBody: true,
        data: data,
        httpMethod: HttpMethod.patch,
      );
      selectWorkspaceState = AuthStateEnum.success;
      log(response.data.toString());
      // response = jsonDecode(response.data);
      selectedWorkspace = WorkspaceModel.fromJson(response.data);

      log('SELECTED WORKSPACE');
      log(selectedWorkspace!.toString());

      notifyListeners();
      // log(response.data.toString());
    } catch (e) {
      log(e.toString());
      selectWorkspaceState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  Future<bool> deleteWorkspace() async {
    selectWorkspaceState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.retrieveWorkspace.replaceAll(
          '\$SLUG',
          selectedWorkspace!.workspaceSlug,
        ),
        hasBody: false,
        httpMethod: HttpMethod.delete,
      );
      selectWorkspaceState = AuthStateEnum.success;
      log(response.data.toString());
      await getWorkspaces();

      // response = jsonDecode(response.data);

      notifyListeners();
      return true;
      // log(response.data.toString());
    } catch (e) {
      log(e.toString());
      selectWorkspaceState = AuthStateEnum.error;
      notifyListeners();
      return false;
    }
  }

  Future getWorkspaceMembers() async {
    getMembersState = AuthStateEnum.loading;
    notifyListeners();
    try {
      var response = await DioConfig().dioServe(
        hasAuth: true,
        url: APIs.getWorkspaceMembers.replaceAll(
          '\$SLUG',
          selectedWorkspace!.workspaceSlug,
        ),
        hasBody: false,
        httpMethod: HttpMethod.get,
      );
      getMembersState = AuthStateEnum.success;
      log(response.data.toString());
      workspaceMembers = response.data;
      // response = jsonDecode(response.data);

      notifyListeners();
      // log(response.data.toString());
    } catch (e) {
      log(e.toString());
      getMembersState = AuthStateEnum.error;
      notifyListeners();
    }
  }

  // Future inviteMembers() async {
  //   selectWorkspaceState = AuthStateEnum.loading;
  //   notifyListeners();
  //   try {
  //     var response = await DioConfig().dioServe(
  //       hasAuth: true,
  //       url: APIs.inviteMembers.replaceAll(
  //         '\$SLUG',
  //         selectedWorkspace!.workspaceSlug,
  //       ),
  //       hasBody: true,
  //       data: {"emails": emails},
  //       httpMethod: HttpMethod.post,
  //     );
  //     selectWorkspaceState = AuthStateEnum.success;
  //     log(response.data.toString());
  //     // response = jsonDecode(response.data);

  //     notifyListeners();
  //     // log(response.data.toString());
  //   } catch (e) {
  //     log(e.toString());
  //     selectWorkspaceState = AuthStateEnum.error;
  //     notifyListeners();
  //   }
  // }
}

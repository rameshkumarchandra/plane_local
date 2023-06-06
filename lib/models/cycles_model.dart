class CyclesModel {
	String? id;
	OwnedBy? ownedBy;
	bool? isFavorite;
	int? totalIssues;
	int? cancelledIssues;
	int? completedIssues;
	int? startedIssues;
	int? unstartedIssues;
	int? backlogIssues;
	List<Assignees>? assignees;
	Null? totalEstimates;
	Null? completedEstimates;
	Null? startedEstimates;
	WorkspaceDetail? workspaceDetail;
	ProjectDetail? projectDetail;
	String? createdAt;
	String? updatedAt;
	String? name;
	String? description;
	String? startDate;
	String? endDate;
	// ViewProps? viewProps;
	String? createdBy;
	String? updatedBy;
	String? project;
	String? workspace;

	CyclesModel({this.id, this.ownedBy, this.isFavorite, this.totalIssues, this.cancelledIssues, this.completedIssues, this.startedIssues, this.unstartedIssues, this.backlogIssues, this.assignees, this.totalEstimates, this.completedEstimates, this.startedEstimates, this.workspaceDetail, this.projectDetail, this.createdAt, this.updatedAt, this.name, this.description, this.startDate, this.endDate, this.createdBy, this.updatedBy, this.project, this.workspace});

	CyclesModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		ownedBy = json['owned_by'] != null ? new OwnedBy.fromJson(json['owned_by']) : null;
		isFavorite = json['is_favorite'];
		totalIssues = json['total_issues'];
		cancelledIssues = json['cancelled_issues'];
		completedIssues = json['completed_issues'];
		startedIssues = json['started_issues'];
		unstartedIssues = json['unstarted_issues'];
		backlogIssues = json['backlog_issues'];
		if (json['assignees'] != null) {
			assignees = <Assignees>[];
			json['assignees'].forEach((v) { assignees!.add(new Assignees.fromJson(v)); });
		}
		totalEstimates = json['total_estimates'];
		completedEstimates = json['completed_estimates'];
		startedEstimates = json['started_estimates'];
		workspaceDetail = json['workspace_detail'] != null ? new WorkspaceDetail.fromJson(json['workspace_detail']) : null;
		projectDetail = json['project_detail'] != null ? new ProjectDetail.fromJson(json['project_detail']) : null;
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		name = json['name'];
		description = json['description'];
		startDate = json['start_date'];
		endDate = json['end_date'];
		// viewProps = json['view_props'] != null ? new ViewProps.fromJson(json['view_props']) : null;
		createdBy = json['created_by'];
		updatedBy = json['updated_by'];
		project = json['project'];
		workspace = json['workspace'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		if (this.ownedBy != null) {
      data['owned_by'] = this.ownedBy!.toJson();
    }
		data['is_favorite'] = this.isFavorite;
		data['total_issues'] = this.totalIssues;
		data['cancelled_issues'] = this.cancelledIssues;
		data['completed_issues'] = this.completedIssues;
		data['started_issues'] = this.startedIssues;
		data['unstarted_issues'] = this.unstartedIssues;
		data['backlog_issues'] = this.backlogIssues;
		if (this.assignees != null) {
      data['assignees'] = this.assignees!.map((v) => v.toJson()).toList();
    }
		data['total_estimates'] = this.totalEstimates;
		data['completed_estimates'] = this.completedEstimates;
		data['started_estimates'] = this.startedEstimates;
		if (this.workspaceDetail != null) {
      data['workspace_detail'] = this.workspaceDetail!.toJson();
    }
		if (this.projectDetail != null) {
      data['project_detail'] = this.projectDetail!.toJson();
    }
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		data['name'] = this.name;
		data['description'] = this.description;
		data['start_date'] = this.startDate;
		data['end_date'] = this.endDate;
		// if (this.viewProps != null) {
    //   data['view_props'] = this.viewProps!.toJson();
    // }
		data['created_by'] = this.createdBy;
		data['updated_by'] = this.updatedBy;
		data['project'] = this.project;
		data['workspace'] = this.workspace;
		return data;
	}
}

class OwnedBy {
	String? id;
	String? firstName;
	String? lastName;
	String? email;
	String? avatar;
	bool? isBot;

	OwnedBy({this.id, this.firstName, this.lastName, this.email, this.avatar, this.isBot});

	OwnedBy.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		firstName = json['first_name'];
		lastName = json['last_name'];
		email = json['email'];
		avatar = json['avatar'];
		isBot = json['is_bot'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['first_name'] = this.firstName;
		data['last_name'] = this.lastName;
		data['email'] = this.email;
		data['avatar'] = this.avatar;
		data['is_bot'] = this.isBot;
		return data;
	}
}

class Assignees {
	String? id;
	String? avatar;
	String? firstName;

	Assignees({this.id, this.avatar, this.firstName});

	Assignees.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		avatar = json['avatar'];
		firstName = json['first_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['avatar'] = this.avatar;
		data['first_name'] = this.firstName;
		return data;
	}
}

class WorkspaceDetail {
	String? name;
	String? slug;
	String? id;

	WorkspaceDetail({this.name, this.slug, this.id});

	WorkspaceDetail.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		slug = json['slug'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['slug'] = this.slug;
		data['id'] = this.id;
		return data;
	}
}

class ProjectDetail {
	String? id;
	String? identifier;
	String? name;

	ProjectDetail({this.id, this.identifier, this.name});

	ProjectDetail.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		identifier = json['identifier'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['identifier'] = this.identifier;
		data['name'] = this.name;
		return data;
	}
}

// class ViewProps {


// 	ViewProps({});

// 	ViewProps.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }
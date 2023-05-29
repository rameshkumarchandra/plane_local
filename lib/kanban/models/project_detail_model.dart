class ProjectDetailModel {
  String? id;
  Workspace? workspace;
  Null? defaultAssignee;
  Null? projectLead;
  bool? isFavorite;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? description;
  Null? descriptionText;
  Null? descriptionHtml;
  int? network;
  String? identifier;
  String? emoji;
  Null? iconProp;
  bool? moduleView;
  bool? cycleView;
  bool? issueViewsView;
  bool? pageView;
  bool? inboxView;
  String? coverImage;
  String? createdBy;
  String? updatedBy;
  Null? estimate;

  ProjectDetailModel(
      {this.id,
      this.workspace,
      this.defaultAssignee,
      this.projectLead,
      this.isFavorite,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.description,
      this.descriptionText,
      this.descriptionHtml,
      this.network,
      this.identifier,
      this.emoji,
      this.iconProp,
      this.moduleView,
      this.cycleView,
      this.issueViewsView,
      this.pageView,
      this.inboxView,
      this.coverImage,
      this.createdBy,
      this.updatedBy,
      this.estimate});

  ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workspace = json['workspace'] != null
        ? new Workspace.fromJson(json['workspace'])
        : null;
    defaultAssignee = json['default_assignee'];
    projectLead = json['project_lead'];
    isFavorite = json['is_favorite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    descriptionText = json['description_text'];
    descriptionHtml = json['description_html'];
    network = json['network'];
    identifier = json['identifier'];
    emoji = json['emoji'];
    iconProp = json['icon_prop'];
    moduleView = json['module_view'];
    cycleView = json['cycle_view'];
    issueViewsView = json['issue_views_view'];
    pageView = json['page_view'];
    inboxView = json['inbox_view'];
    coverImage = json['cover_image'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    estimate = json['estimate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.workspace != null) {
      data['workspace'] = this.workspace!.toJson();
    }
    data['default_assignee'] = this.defaultAssignee;
    data['project_lead'] = this.projectLead;
    data['is_favorite'] = this.isFavorite;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['description_text'] = this.descriptionText;
    data['description_html'] = this.descriptionHtml;
    data['network'] = this.network;
    data['identifier'] = this.identifier;
    data['emoji'] = this.emoji;
    data['icon_prop'] = this.iconProp;
    data['module_view'] = this.moduleView;
    data['cycle_view'] = this.cycleView;
    data['issue_views_view'] = this.issueViewsView;
    data['page_view'] = this.pageView;
    data['inbox_view'] = this.inboxView;
    data['cover_image'] = this.coverImage;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['estimate'] = this.estimate;
    return data;
  }
}

class Workspace {
  String? id;
  Owner? owner;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? logo;
  String? slug;
  int? companySize;
  String? createdBy;
  String? updatedBy;

  Workspace(
      {this.id,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.logo,
      this.slug,
      this.companySize,
      this.createdBy,
      this.updatedBy});

  Workspace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    logo = json['logo'];
    slug = json['slug'];
    companySize = json['company_size'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['slug'] = this.slug;
    data['company_size'] = this.companySize;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Owner {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;
  bool? isBot;

  Owner(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      this.isBot});

  Owner.fromJson(Map<String, dynamic> json) {
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
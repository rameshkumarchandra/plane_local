import 'dart:convert';

class UserProfile {
  final String? id;
  final String? last_login;
  final String? username;
  final String? mobile_number;
  final String? email;
  final String? first_name;
  final String? last_name;
  final String? avatar;
  final String? date_joined;
  final String? created_at;
  final String? updated_at;
  final String? last_location;
  final String? created_location;
  final bool? is_superuser;
  final bool? is_managed;
  final bool? is_password_expired;
  final bool? is_active;
  final bool? is_staff;
  final bool? is_email_verified;
  final bool? is_password_autoset;
  final bool? is_onboarded;
  final String? token;
  final String? billing_address_country;
  final String? billing_address;
  final bool? has_billing_address;
  final String? user_timezone;
  final String? last_active;
  final String? last_login_time;
  final String? last_logout_time;
  final String? last_login_ip;
  final String? last_logout_ip;
  final String? last_login_medium;
  final String? last_login_uagent;
  final String? token_updated_at;
  final String? last_workspace_id;
  final String? my_issues_prop;
  final String? role;
  final bool? is_bot;
  final Map? theme;
  final List<dynamic>? groups;
  final List<dynamic>? user_permissions;
  UserProfile({
    required this.id,
    required this.last_login,
    required this.username,
    required this.mobile_number,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
    required this.date_joined,
    required this.created_at,
    required this.updated_at,
    required this.last_location,
    required this.created_location,
    required this.is_superuser,
    required this.is_managed,
    required this.is_password_expired,
    required this.is_active,
    required this.is_staff,
    required this.is_email_verified,
    required this.is_password_autoset,
    required this.is_onboarded,
    required this.token,
    required this.billing_address_country,
    required this.billing_address,
    required this.has_billing_address,
    required this.user_timezone,
    required this.last_active,
    required this.last_login_time,
    required this.last_logout_time,
    required this.last_login_ip,
    required this.last_logout_ip,
    required this.last_login_medium,
    required this.last_login_uagent,
    required this.token_updated_at,
    required this.last_workspace_id,
    required this.my_issues_prop,
    required this.role,
    required this.is_bot,
    required this.theme,
    required this.groups,
    required this.user_permissions,
  });
  static UserProfile initialize() {
    return UserProfile(
      id: '',
      last_login: '',
      username: '',
      mobile_number: '',
      email: '',
      first_name: '',
      last_name: '',
      avatar: '',
      date_joined: '',
      created_at: '',
      updated_at: '',
      last_location: '',
      created_location: '',
      is_superuser: false,
      is_managed: false,
      is_password_expired: false,
      is_active: false,
      is_staff: false,
      is_email_verified: false,
      is_password_autoset: false,
      is_onboarded: false,
      token: '',
      billing_address_country: '',
      billing_address: '',
      has_billing_address: false,
      user_timezone: '',
      last_active: '',
      last_login_time: '',
      last_logout_time: '',
      last_login_ip: '',
      last_logout_ip: '',
      last_login_medium: '',
      last_login_uagent: '',
      token_updated_at: '',
      last_workspace_id: '',
      my_issues_prop: '',
      role: null,
      is_bot: false,
      theme: {},
      groups: [],
      user_permissions: [],
    );
  }

  UserProfile copyWith({
    String? id,
    String? last_login,
    String? username,
    String? mobile_number,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar,
    String? date_joined,
    String? created_at,
    String? updated_at,
    String? last_location,
    String? created_location,
    bool? is_superuser,
    bool? is_managed,
    bool? is_password_expired,
    bool? is_active,
    bool? is_staff,
    bool? is_email_verified,
    bool? is_password_autoset,
    bool? is_onboarded,
    String? token,
    String? billing_address_country,
    String? billing_address,
    bool? has_billing_address,
    String? user_timezone,
    String? last_active,
    String? last_login_time,
    String? last_logout_time,
    String? last_login_ip,
    String? last_logout_ip,
    String? last_login_medium,
    String? last_login_uagent,
    String? token_updated_at,
    String? last_workspace_id,
    String? my_issues_prop,
    String? role,
    bool? is_bot,
    Map? theme,
    List<dynamic>? groups,
    List<dynamic>? user_permissions,
  }) {
    return UserProfile(
      id: id ?? this.id,
      last_login: last_login ?? this.last_login,
      username: username ?? this.username,
      mobile_number: mobile_number ?? this.mobile_number,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      avatar: avatar ?? this.avatar,
      date_joined: date_joined ?? this.date_joined,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      last_location: last_location ?? this.last_location,
      created_location: created_location ?? this.created_location,
      is_superuser: is_superuser ?? this.is_superuser,
      is_managed: is_managed ?? this.is_managed,
      is_password_expired: is_password_expired ?? this.is_password_expired,
      is_active: is_active ?? this.is_active,
      is_staff: is_staff ?? this.is_staff,
      is_email_verified: is_email_verified ?? this.is_email_verified,
      is_password_autoset: is_password_autoset ?? this.is_password_autoset,
      is_onboarded: is_onboarded ?? this.is_onboarded,
      token: token ?? this.token,
      billing_address_country:
          billing_address_country ?? this.billing_address_country,
      billing_address: billing_address ?? this.billing_address,
      has_billing_address: has_billing_address ?? this.has_billing_address,
      user_timezone: user_timezone ?? this.user_timezone,
      last_active: last_active ?? this.last_active,
      last_login_time: last_login_time ?? this.last_login_time,
      last_logout_time: last_logout_time ?? this.last_logout_time,
      last_login_ip: last_login_ip ?? this.last_login_ip,
      last_logout_ip: last_logout_ip ?? this.last_logout_ip,
      last_login_medium: last_login_medium ?? this.last_login_medium,
      last_login_uagent: last_login_uagent ?? this.last_login_uagent,
      token_updated_at: token_updated_at ?? this.token_updated_at,
      last_workspace_id: last_workspace_id ?? this.last_workspace_id,
      my_issues_prop: my_issues_prop ?? this.my_issues_prop,
      role: role ?? this.role,
      is_bot: is_bot ?? this.is_bot,
      theme: theme ?? this.theme,
      groups: groups ?? this.groups,
      user_permissions: user_permissions ?? this.user_permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'last_login': last_login,
      'username': username,
      'mobile_number': mobile_number,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
      'date_joined': date_joined,
      'created_at': created_at,
      'updated_at': updated_at,
      'last_location': last_location,
      'created_location': created_location,
      'is_superuser': is_superuser,
      'is_managed': is_managed,
      'is_password_expired': is_password_expired,
      'is_active': is_active,
      'is_staff': is_staff,
      'is_email_verified': is_email_verified,
      'is_password_autoset': is_password_autoset,
      'is_onboarded': is_onboarded,
      'token': token,
      'billing_address_country': billing_address_country,
      'billing_address': billing_address,
      'has_billing_address': has_billing_address,
      'user_timezone': user_timezone,
      'last_active': last_active,
      'last_login_time': last_login_time,
      'last_logout_time': last_logout_time,
      'last_login_ip': last_login_ip,
      'last_logout_ip': last_logout_ip,
      'last_login_medium': last_login_medium,
      'last_login_uagent': last_login_uagent,
      'token_updated_at': token_updated_at,
      'last_workspace_id': last_workspace_id,
      'my_issues_prop': my_issues_prop,
      'role': role,
      'is_bot': is_bot,
      'theme': theme,
      'groups': groups,
      'user_permissions': user_permissions,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      last_login: map['last_login'],
      username: map['username'],
      mobile_number: map['mobile_number'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      avatar: map['avatar'],
      date_joined: map['date_joined'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      last_location: map['last_location'],
      created_location: map['created_location'],
      is_superuser: map['is_superuser'],
      is_managed: map['is_managed'],
      is_password_expired: map['is_password_expired'],
      is_active: map['is_active'],
      is_staff: map['is_staff'],
      is_email_verified: map['is_email_verified'],
      is_password_autoset: map['is_password_autoset'],
      is_onboarded: map['is_onboarded'],
      token: map['token'],
      billing_address_country: map['billing_address_country'],
      billing_address: map['billing_address'],
      has_billing_address: map['has_billing_address'],
      user_timezone: map['user_timezone'],
      last_active: map['last_active'],
      last_login_time: map['last_login_time'],
      last_logout_time: map['last_logout_time'],
      last_login_ip: map['last_login_ip'],
      last_logout_ip: map['last_logout_ip'],
      last_login_medium: map['last_login_medium'],
      last_login_uagent: map['last_login_uagent'],
      token_updated_at: map['token_updated_at'],
      last_workspace_id: map['last_workspace_id'],
      my_issues_prop: map['my_issues_prop'],
      role: map['role'],
      is_bot: map['is_bot'],
      theme: map['theme'],
      groups: map['groups'],
      user_permissions: map['user_permissions'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(id: $id, last_login: $last_login, username: $username, mobile_number: $mobile_number, email: $email, first_name: $first_name, last_name: $last_name, avatar: $avatar, date_joined: $date_joined, created_at: $created_at, updated_at: $updated_at, last_location: $last_location, created_location: $created_location, is_superuser: $is_superuser, is_managed: $is_managed, is_password_expired: $is_password_expired, is_active: $is_active, is_staff: $is_staff, is_email_verified: $is_email_verified, is_password_autoset: $is_password_autoset, is_onboarded: $is_onboarded, token: $token, billing_address_country: $billing_address_country, billing_address: $billing_address, has_billing_address: $has_billing_address, user_timezone: $user_timezone, last_active: $last_active, last_login_time: $last_login_time, last_logout_time: $last_logout_time, last_login_ip: $last_login_ip, last_logout_ip: $last_logout_ip, last_login_medium: $last_login_medium, last_login_uagent: $last_login_uagent, token_updated_at: $token_updated_at, last_workspace_id: $last_workspace_id, my_issues_prop: $my_issues_prop, role: $role, is_bot: $is_bot, theme: $theme, groups: $groups, user_permissions: $user_permissions)';
  }
}

class UserProfile {
  String? token;
  UserData? userData;

  UserProfile({ this.token, this.userData});

  UserProfile.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userData != null) {
      data['user_data'] = this.userData?.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  Profile? profile;
  String? uid;
  String? username;
  String? mobile;
  String? email;
  bool? isMobileVerified;
  bool? isEmailVerified;
  bool? isAdmin;
  bool? isSuperuser;
  bool? isActive;
  String? created;

  UserData(
      {this.id,
      this.profile,
      this.uid,
      this.username,
      this.mobile,
      this.email,
      this.isMobileVerified,
      this.isEmailVerified,
      this.isAdmin,
      this.isSuperuser,
      this.isActive,
      this.created});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    uid = json['uid'];
    username = json['username'];
    mobile = json['mobile'];
    email = json['email'];
    isMobileVerified = json['is_mobile_verified'];
    isEmailVerified = json['is_email_verified'];
    isAdmin = json['is_admin'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.profile != null) {
      data['profile'] = this.profile?.toJson();
    }
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['is_mobile_verified'] = this.isMobileVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_admin'] = this.isAdmin;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['created'] = this.created;
    return data;
  }
}

class Profile {
  int? id;
  String? name;
  String? image;
  String? dob;
  String? gender;
  int? user;

  Profile(
      {this.id,
      this.name,
      this.image,
      this.dob,
      this.gender,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dob = json['dob'];
    gender = json['gender'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['user'] = this.user;
    return data;
  }
}
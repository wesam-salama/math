class UserData {
  var message;
  User user;

  UserData({this.message, this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  var name;
  var gender;
  var levelId;
  var location;
  var supervisor;
  var supervisorType;
  var phone;
  var avatar;
  var updatedAt;
  var createdAt;
  var id;

  User(
      {this.name,
      this.gender,
      this.levelId,
      this.location,
      this.supervisor,
      this.supervisorType,
      this.phone,
      this.avatar,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    levelId = json['level_id'];
    location = json['location'];
    supervisor = json['supervisor'];
    supervisorType = json['supervisor_type'];
    phone = json['phone'];
    avatar = json['avatar'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['level_id'] = this.levelId;
    data['location'] = this.location;
    data['supervisor'] = this.supervisor;
    data['supervisor_type'] = this.supervisorType;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class MeUser {
  int id;
  String name;
  String phone;
  String phoneVerifiedAt;
  String gender;
  var dateOfBirth;
  String location;
  String supervisor;
  var supervisorType;
  bool blockedAt;
  String createdAt;
  String updatedAt;
  int levelId;
  String power;
  String avatar;

  MeUser(
      {this.id,
      this.name,
      this.phone,
      this.phoneVerifiedAt,
      this.gender,
      this.dateOfBirth,
      this.location,
      this.supervisor,
      this.supervisorType,
      this.blockedAt,
      this.createdAt,
      this.updatedAt,
      this.levelId,
      this.power,
      this.avatar});

  MeUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    phoneVerifiedAt = json['phone_verified_at'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    location = json['location'];
    supervisor = json['supervisor'];
    supervisorType = json['supervisor_type'];
    blockedAt = json['blocked_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    levelId = json['level_id'];
    power = json['power'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['location'] = this.location;
    data['supervisor'] = this.supervisor;
    data['supervisor_type'] = this.supervisorType;
    data['blocked_at'] = this.blockedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['level_id'] = this.levelId;
    data['power'] = this.power;
    data['avatar'] = this.avatar;
    return data;
  }
}

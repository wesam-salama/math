class Levels {
  var currentPage;
  List<LevelsData> data;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  Levels(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Levels.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<LevelsData>();
      json['data'].forEach((v) {
        data.add(new LevelsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class LevelsData {
  var id;
  var name;
  var color;
  var nameEn;
  var description;
  var createdAt;
  var updatedAt;
  var videosCount;
  var unitsCount;
  var usersCount;
  List<Units> units;
  List<Users> users;

  LevelsData(
      {this.id,
      this.name,
      this.color,
      this.nameEn,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.videosCount,
      this.unitsCount,
      this.usersCount,
      this.units,
      this.users});

  LevelsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    nameEn = json['name_en'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videosCount = json['videos_count'];
    unitsCount = json['units_count'];
    usersCount = json['users_count'];
    if (json['units'] != null) {
      units = new List<Units>();
      json['units'].forEach((v) {
        units.add(new Units.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['name_en'] = this.nameEn;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['videos_count'] = this.videosCount;
    data['units_count'] = this.unitsCount;
    data['users_count'] = this.usersCount;
    if (this.units != null) {
      data['units'] = this.units.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
  var id;
  var userId;
  var levelId;
  var title;
  var description;
  var createdAt;
  var updatedAt;
  var price;
  var itemDeletedAt;
  var term;
  var mathType;

  Units(
      {this.id,
      this.userId,
      this.levelId,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.itemDeletedAt,
      this.term,
      this.mathType});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    levelId = json['level_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    itemDeletedAt = json['item_deleted_at'];
    term = json['term'];
    mathType = json['math_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['level_id'] = this.levelId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['item_deleted_at'] = this.itemDeletedAt;
    data['term'] = this.term;
    data['math_type'] = this.mathType;
    return data;
  }
}

class Users {
  var id;
  var name;
  var phone;
  var phoneVerifiedAt;
  var gender;
  var dateOfBirth;
  var location;
  var supervisor;
  var supervisorType;
  var blockedAt;
  var createdAt;
  var updatedAt;
  var levelId;
  var power;
  var avatar;

  Users(
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

  Users.fromJson(Map<String, dynamic> json) {
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

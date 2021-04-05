class UnitTwilvAlivent {
  int currentPage;
  List<UnitTwilvAliventData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  UnitTwilvAlivent(
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

  UnitTwilvAlivent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<UnitTwilvAliventData>();
      json['data'].forEach((v) {
        data.add(new UnitTwilvAliventData.fromJson(v));
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

class UnitTwilvAliventData {
  int id;
  int userId;
  int levelId;
  String title;
  String description;
  String createdAt;
  String updatedAt;
  int price;
  Null itemDeletedAt;
  int term;
  String mathType;
  int videosCount;
  Level level;

  UnitTwilvAliventData(
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
      this.mathType,
      this.videosCount,
      this.level});

  UnitTwilvAliventData.fromJson(Map<String, dynamic> json) {
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
    videosCount = json['videos_count'];
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
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
    data['videos_count'] = this.videosCount;
    if (this.level != null) {
      data['level'] = this.level.toJson();
    }
    return data;
  }
}

class Level {
  int id;
  String name;
  String color;
  String nameEn;
  String description;
  String createdAt;
  String updatedAt;

  Level(
      {this.id,
      this.name,
      this.color,
      this.nameEn,
      this.description,
      this.createdAt,
      this.updatedAt});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    nameEn = json['name_en'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}

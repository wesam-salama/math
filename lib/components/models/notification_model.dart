class Notification1 {
  int currentPage;
  List<DataNotification> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  var nextPageUrl;
  String path;
  int perPage;
  var prevPageUrl;
  int to;
  int total;

  Notification1(
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

  Notification1.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<DataNotification>();
      json['data'].forEach((v) {
        data.add(new DataNotification.fromJson(v));
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

class DataNotification {
  int id;
  int levelId;
  String description;
  String link;
  String icon;
  var expiredAt;
  String createdAt;
  String updatedAt;

  DataNotification(
      {this.id,
      this.levelId,
      this.description,
      this.link,
      this.icon,
      this.expiredAt,
      this.createdAt,
      this.updatedAt});

  DataNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelId = json['level_id'];
    description = json['description'];
    link = json['link'];
    icon = json['icon'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level_id'] = this.levelId;
    data['description'] = this.description;
    data['link'] = this.link;
    data['icon'] = this.icon;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

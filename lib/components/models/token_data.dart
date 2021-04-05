class TokenData {
  String accessToken;
  String tokenType;
  int expiresIn;
  String message;

  TokenData({this.accessToken, this.tokenType, this.expiresIn, this.message});

  TokenData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['message'] = this.message;
    return data;
  }
}

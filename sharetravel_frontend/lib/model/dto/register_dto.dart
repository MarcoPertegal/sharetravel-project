class RegisterDto {
  String? username;
  String? password;
  String? fullName;

  RegisterDto({this.username, this.password, this.fullName});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['fullName'] = fullName;
    return data;
  }
}

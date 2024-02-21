class RegisterDto {
  String? username;
  String? password;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? personalDescription;
  String? avatar;

  RegisterDto(
      {this.username,
      this.password,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.personalDescription,
      this.avatar});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    personalDescription = json['personalDescription'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['personalDescription'] = personalDescription;
    data['avatar'] = avatar;
    return data;
  }
}

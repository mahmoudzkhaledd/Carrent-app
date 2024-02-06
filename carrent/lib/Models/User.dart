class User {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String phone = "";
  bool verifiedEmail = false;
  bool gender = true;
  DateTime birthdate = DateTime.now();
  String companyName = "";
  String profilePic = "";

  User();

  User copy() {
    User user = User();
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    user.password = password;
    user.verifiedEmail = verifiedEmail;
    user.gender = gender;
    user.birthdate = birthdate;
    user.profilePic = profilePic;
    user.id = id;
    user.phone = phone;
    user.companyName = companyName;
    return user;
  }

  User.fromJsonSearch(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profilePic'] ?? "";
    companyName = json['companyName'] ?? "";
  }

  String get getQrCode => 'user $id';
  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    phone = json['phone'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    verifiedEmail = json['verifiedEmail'] ?? false;
    gender = json['gender'] ?? false;
    profilePic = json['profilePic'] ?? "";
    companyName = json['companyName'] ?? "";
    if (json['birthdate'] != null) {
      birthdate = DateTime.parse(json['birthdate'].toString());
    }
  }
  Map<String, dynamic> toJsonSignup() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "companyName": companyName,
        "gender": gender,
        "phone": phone,
        "birthdate": birthdate.toString(),
      };
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['verifiedEmail'] = verifiedEmail;
    data['gender'] = gender;
    data['birthdate'] = birthdate;
    data['companyName'] = companyName;
    data['profilePic'] = profilePic;
    return data;
  }
}

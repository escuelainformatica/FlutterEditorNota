class User {
  late String UserName;
  late String Password;
  late String Level;

  User(this.UserName, this.Password, this.Level);

  User.fromJson(Map<String, dynamic> json) {
    UserName = json['UserName']??"";
    Password = json['Password']??"";
    Level = json['Level']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.UserName;
    data['Password'] = this.Password;
    data['Level'] = this.Level;
    return data;
  }


}
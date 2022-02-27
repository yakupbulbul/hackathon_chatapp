class UserModel {
  String? email;
  String? firstName;
  String? secondName;

  UserModel({this.email, this.firstName, this.secondName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      firstName: map['name'],
      secondName: map['lastname'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': firstName,
      'lastname': secondName,
    };
  }
}

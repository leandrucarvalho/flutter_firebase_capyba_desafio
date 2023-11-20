class UserModel {
  late String? firstname;
  late String? lastname;
  late String? email;
  late bool emailConfirmed;

  UserModel({
    this.firstname,
    this.lastname,
    this.email,
    this.emailConfirmed = false,
  });

  factory UserModel.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return UserModel(
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      email: snapshot['email'],
      emailConfirmed: snapshot['emailVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (firstname != null) "firstname": firstname,
      if (lastname != null) "lastname": lastname,
      if (email != null) "email": email,
    };
  }

  UserModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
  }) {
    return UserModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
    );
  }
}

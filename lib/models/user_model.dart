class UserModel {
  late String? firstname;
  late String? lastname;
  late String? email;

  UserModel({
    this.firstname,
    this.lastname,
    this.email,
  });

  factory UserModel.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return UserModel(
      firstname: snapshot['firstname'],
      lastname: snapshot['lastname'],
      email: snapshot['email'],
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

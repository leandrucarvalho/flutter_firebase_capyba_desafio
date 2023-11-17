import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? firstname;
  final String? lastname;
  final String? email;

  User({
    this.firstname,
    this.lastname,
    this.email,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      firstname: data?['firstname'],
      lastname: data?['lastname'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstname != null) "firstname": firstname,
      if (lastname != null) "lastname": lastname,
      if (email != null) "email": email,
    };
  }
}

import 'dart:convert';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String password;
  final String image;
  final String email;
  final String dateOfBirth;

  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.password,
      this.image,
      this.email,
      this.dateOfBirth});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'image': image,
      'email': email,
      'dateOfBirth': dateOfBirth,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
      image: map['image'],
      email: map['email'],
      dateOfBirth: map['dateOfBirth'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, firstName: $firstName, lastName: $lastName, password: $password, image: $image, email: $email, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.uid == uid &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.password == password &&
        o.image == image &&
        o.email == email &&
        o.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        password.hashCode ^
        image.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode;
  }
}

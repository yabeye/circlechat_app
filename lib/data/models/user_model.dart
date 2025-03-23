import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    this.about,
    this.profileImageUrl,
    this.phoneNumber,
    this.joinedAt,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return UserModel(
      uid: id ?? json['uid'],
      name: json['name'] as String? ?? '',
      about: json['about'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      joinedAt: (json['joinedAt'] as Timestamp?)?.toDate(),
    );
  }

  final String uid;
  final String name;
  final String? about;
  final String? profileImageUrl;
  final String? phoneNumber;
  final DateTime? joinedAt;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'about': about,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'joinedAt': joinedAt != null ? Timestamp.fromDate(joinedAt!) : null,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? about,
    String? profileImageUrl,
    String? phoneNumber,
    DateTime? joinedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      about: about ?? this.about,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, name: $name, about: $about, profileImageUrl: $profileImageUrl, phoneNumber: $phoneNumber, joinedAt: $joinedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          about == other.about &&
          profileImageUrl == other.profileImageUrl &&
          phoneNumber == other.phoneNumber &&
          joinedAt == other.joinedAt;

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      about.hashCode ^
      profileImageUrl.hashCode ^
      phoneNumber.hashCode ^
      joinedAt.hashCode;
}

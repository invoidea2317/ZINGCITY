import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final String email;
  final String phone;
  final String userName;
  final int status;
  final int kycStatus;
  final String address;
  final String designation;
  final String aboutMe;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final int isAgency;
  final int ownerId;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    required this.userName,
    required this.status,
    required this.kycStatus,
    required this.address,
    required this.designation,
    required this.aboutMe,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.isAgency,
    required this.ownerId,
  });

  UserProfileModel copyWith({
    int? id,
    String? name,
    String? image,
    String? email,
    String? phone,
    String? userName,
    int? status,
    int? kycStatus,
    String? address,
    String? designation,
    String? aboutMe,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    int? isAgency,
    int? ownerId,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      kycStatus: kycStatus ?? this.kycStatus,
      address: address ?? this.address,
      designation: designation ?? this.designation,
      aboutMe: aboutMe ?? this.aboutMe,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      isAgency: isAgency ?? this.isAgency,
      ownerId: ownerId ?? this.ownerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'phone': phone,
      'user_name': userName,
      'status': status,
      'kyc_status': kycStatus,
      'address': address,
      'designation': designation,
      'about_me': aboutMe,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'is_agency': isAgency,
      'owner_id': ownerId,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    //print('uuuuuuuuuuuuuu');
    return UserProfileModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userName: map['user_name'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      kycStatus: map['kyc_status'] != null
          ? int.parse(map['kyc_status'].toString())
          : 0,
      address: map['address'] ?? '',
      designation: map['designation'] ?? '',
      aboutMe: map['about_me'] ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      linkedin: map['linkedin'] ?? '',
      instagram: map['instagram'] ?? '',
      isAgency:
          map['is_agency'] != null ? int.parse(map['is_agency'].toString()) : 0,
      ownerId:
          map['owner_id'] != null ? int.parse(map['owner_id'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      image,
      email,
      phone,
      userName,
      status,
      kycStatus,
      address,
      designation,
      aboutMe,
      facebook,
      twitter,
      linkedin,
      instagram,
      isAgency,
      ownerId,
    ];
  }
}

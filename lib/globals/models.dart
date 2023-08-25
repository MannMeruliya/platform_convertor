import 'dart:io';

class detail {
  String? name;
  String? num;
  String? chat;
  File? image;
  File? profileImage;
  String? bio;
  String? profileName;

  detail({
    required this.name,
    required this.num,
    required this.chat,
    this.image,
    this.bio,
    this.profileImage,
    this.profileName,
  });
}

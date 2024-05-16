// To parse this JSON data, do
//
//     final userModel = userModelfromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
    String? firstname;
    String? username;
    String? middlename;
    String? lastname;
    String? email;
    String? image;
    bool? emailVerifiedAt;
    bool? phoneVerifiedAt;
    String? walletBalance;
    int? id;
    dynamic phone;
    dynamic referralLink;

    UserModel({
        this.firstname,
        this.username,
        this.middlename,
        this.lastname,
        this.image, 
        this.email,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.walletBalance,
        this.id,
        this.phone,
        this.referralLink,
    });

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        firstname: json["firstname"],
        username: json["username"],
        middlename: json["middlename"],
        lastname: json["lastname"],
        image: json["image"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phoneVerifiedAt: json["phone_verified_at"],
        walletBalance: json["wallet_balance"],
        id: json["id"],
        phone: json["phone"],
        referralLink: json["referral_link"],
    );

    Map<String, dynamic> toMap() => {
        "firstname": firstname,
        "username": username,
        "middlename": middlename,
        "lastname": lastname,
        "image": image,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone_verified_at": phoneVerifiedAt,
        "wallet_balance": walletBalance,
        "id": id,
        "phone": phone,
        "referral_link": referralLink,
    };
}

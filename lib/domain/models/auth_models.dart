// class AuthModel {
//   String? password;
//   String? email;

//   AuthModel({this.password, this.email});

//   AuthModel.fromJson(Map<String, dynamic> json) {
//     password = json['password'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['password'] = password;
//     data['email'] = email;
//     return data;
//   }

//   AuthModel copyWith({
//     final String? password,
//     final String? email,
//   }) {
//     return AuthModel(
//       password: password ?? this.password,
//       email: email ?? this.email,
//     );
//   }
// }

// class FcmToken {
//   String? fcmToken;

//   FcmToken({this.fcmToken});

//   FcmToken.fromJson(Map<String, dynamic> json) {
//     fcmToken = json['fcmToken'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['fcmToken'] = fcmToken;
//     return data;
//   }

//   FcmToken copyWith({
//     final String? device,
//     final String? fcmToken,
//     final String? language,
//   }) {
//     return FcmToken(
//       fcmToken: fcmToken ?? this.fcmToken,
//     );
//   }
// }

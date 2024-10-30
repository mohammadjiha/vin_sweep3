//
//
// class UserModel {
//   String email;
//   String fullName;
//   String mobile;
//   String? profileImg;
//   String uid;
//   String username;
//   bool isVerify;
//   String? token;
//
//   UserModel(
//       {required this.email,
//         required this.fullName,
//         required this.mobile,
//         this.profileImg,
//         this.token,
//         required this.uid,
//         required this.username,
//         this.isVerify = false});
//
//   // factory UserModel.fromJson(Map<String, dynamic> map) => UserModel(
//   //   email: map["Email"],
//   //   fullName: map["FullName"],
//   //   mobile: map["MobileNumber"],
//   //   profileImg: map["profileImg"],
//   //   uid: map["UID"],
//   //   username: map["UserName"],
//   //   isVerify: map["isVerify"],
//   // );
//
//   // factory UserModel.fromQueryDocumentSnapShot(QueryDocumentSnapshot map) {
//   //   UserModel model;
//   //   model = UserModel(
//   //     email: map["Email"],
//   //     fullName: map["FullName"],
//   //     mobile: map["MobileNumber"],
//   //     uid: map["UID"],
//   //     username: map["UserName"],
//   //     isVerify: map["isVerify"],
//   //   );
//
//   //   try {
//   //     model.profileImg = map['ProfileImg'];
//   //   } catch (e, s) {
//   //     FirebaseCrashlytics.instance.recordError(e, s,
//   //         reason: 'Profile img error Error with Firebase login', fatal: true);
//   //   }
//   //   return model;
//   // }
//
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> map = {
//       "Email": email,
//       "FullName": fullName,
//       "MobileNumber": mobile,
//       "UID": uid,
//       "UserName": username,
//       "isVerify": isVerify,
//     };
//     if (profileImg != null) {
//       map.putIfAbsent("ProfileImg", () => profileImg);
//     }
//     return map;
//   }
// }

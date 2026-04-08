class UserDataModel {
  final String userName;
  final String userEmail;

  UserDataModel({
    required this.userName,
    required this.userEmail,

  });

  UserDataModel.fromFirestore(Map<String, dynamic> data)
      : this(
    userName: data["userName"],
    userEmail: data["userEmail"],

  );

  Map<String, dynamic> toFirestore() {
    return {
      "userName": userName,
      "userEmail": userEmail,

    };
  }
}
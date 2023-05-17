class UserModel {
  final int id;
  final String userId;
  final String phoneNumber;
  // final String dateCreated;

  UserModel({
    required this.id,
    required this.userId,
    required this.phoneNumber,
    // required this.dateCreated
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      // 'dateCreated': dateCreated
    };
  }

  factory UserModel.fromMap(int id, Map<dynamic, dynamic> map) {
    return UserModel(
      id: id,
      userId: map['userId'],
      phoneNumber: map['phoneNumber'],
      // dateCreated: map['dateCreated']
    );
  }
}

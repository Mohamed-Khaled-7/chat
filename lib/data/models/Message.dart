class MessageModel {
  final String? message;
  final String? email;
  final String? createdAt;
  MessageModel({
    required this.email,
    required this.message,
    required this.createdAt,
  });
  factory MessageModel.fromMap(Map<String, dynamic> jsonData) {
    return MessageModel(
      message: jsonData['message'],
      email: jsonData['email'],
      createdAt: jsonData['createdAt'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'message': message, 'email': email, 'createdAt': createdAt};
  }
}

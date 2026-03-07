class MessageModel {
  final String? message;
  final String? id;
  final String? time;
  MessageModel({required this.id, required this.message, this.time});
  factory MessageModel.fromMap(Map<String, dynamic> jsonData) {
    return MessageModel(message: jsonData['message'], id: jsonData['id'], time: jsonData['createdAt']);
  }
}

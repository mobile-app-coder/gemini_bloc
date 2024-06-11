import 'package:dartz/dartz.dart';
import 'package:gemini_app/data/models/message_model.dart';

abstract class HiveRepository {
  Future<Either<String, List<MessageModel>>> getMessages();

  Future<void> saveMessage(MessageModel messageModel);
}

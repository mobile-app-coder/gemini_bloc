import 'package:dartz/dartz.dart';
import 'package:gemini_app/data/datasources/local/no_sql.dart';
import 'package:gemini_app/data/models/message_model.dart';
import 'package:gemini_app/domain/repositories/hive_repository.dart';

class HiveRepositoryImplementation extends HiveRepository {
  @override
  Future<Either<String, List<MessageModel>>> getMessages() async {
    try {
      var messages = HiveService.getMessages();
      return Right(messages);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> saveMessage(MessageModel messageModel) async {
    HiveService.saveMessage(messageModel);
  }
}

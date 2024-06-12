import 'package:dartz/dartz.dart';
import 'package:gemini_app/domain/repositories/hive_repository.dart';

import '../../data/models/message_model.dart';

class GetMessagesDbUseCase {
  final HiveRepository repository;

  GetMessagesDbUseCase(this.repository);

  Future<Either<String, List<MessageModel>>> call() async {
    return await repository.getMessages();
  }
}

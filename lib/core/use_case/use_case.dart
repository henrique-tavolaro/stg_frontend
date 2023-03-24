import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/error/failure.dart';

abstract class UseCase<Type, Props> {
  Future<Either<Failure, Type>> call({required Props props});
}

class NoProps {
  const NoProps();
}

import 'package:dartz/dartz.dart';
import 'package:stg_frontend/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({required Params params});
}

class NoParams {
  const NoParams();
}

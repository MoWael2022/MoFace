import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';

abstract class BaseUserUseCase<input, out> {
  Future<Either<Failure, out>> call(input input);
}

class NoParameter {
  const NoParameter();
}

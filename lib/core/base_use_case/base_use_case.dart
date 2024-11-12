import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class BaseUseCase<input, out> {
  Future<Either<Failure, out>> call(input input);
}

class NoParameter {
  const NoParameter();
}

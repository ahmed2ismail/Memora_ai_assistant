import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> cacheFirstTimer();
  Future<Either<Failure, bool>> checkIfUserIsFirstTimer();
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/ai_repository.dart';
import '../datasources/gemini_remote_datasource.dart';

/// Concrete implementation of [AiRepository] backed by [GeminiRemoteDataSource].
///
/// Wraps ALL possible exceptions from the Gemini SDK and Dio layer into
/// structured [Failure] objects so the presentation layer never crashes.
class AiRepositoryImpl implements AiRepository {
  final GeminiRemoteDataSource remoteDataSource;

  AiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> sendMessage({
    required String message,
    required List<Map<String, String>> conversationHistory,
    String? dashboardContext,
  }) async {
    try {
      final response = await remoteDataSource.sendMessage(
        message: message,
        conversationHistory: conversationHistory,
      );
      return Right(response);
    } on DioException catch (e) {
      // HTTP-level errors (timeouts, bad responses, connection issues)
      return Left(ServerFailure.fromDioException(e));
    } on Exception catch (e) {
      // Gemini SDK exceptions (safety blocks, quota, invalid key, model errors)
      // The google_generative_ai package throws GenerativeAIException
      // which extends Exception, so we catch it here.
      return Left(GeminiFailure.fromGeminiException(e));
    } catch (e) {
      // Truly unexpected errors (type errors, assertion failures, etc.)
      return Left(ServerFailure(
        message: 'An unexpected error occurred: ${e.toString().length > 100 ? '${e.toString().substring(0, 100)}...' : e.toString()}',
      ));
    }
  }
}

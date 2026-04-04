import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

const kCacheFirstTimer = 'kCacheFirstTimer';

abstract class OnboardingLocalDataSource {
  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences prefs;

  OnboardingLocalDataSourceImpl({required this.prefs});

  @override
  Future<void> cacheFirstTimer() async {
    try {
      final result = await prefs.setBool(kCacheFirstTimer, false);
      if (!result) throw CacheException();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return prefs.getBool(kCacheFirstTimer) ?? true;
    } catch (e) {
      throw CacheException();
    }
  }
}

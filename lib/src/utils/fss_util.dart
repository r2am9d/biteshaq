import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FssUtil {
  factory FssUtil() => _instance;

  FssUtil._internal();

  static final _fss = FlutterSecureStorage(
    aOptions: _androidOptions(),
    iOptions: _iosOptions(),
  );
  static final FssUtil _instance = FssUtil._internal();

  static AndroidOptions _androidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _iosOptions() => IOSOptions.defaultOptions;

  Future<String?> read({required String key}) async => _fss.read(key: key);

  Future<void> write({required String key, required String value}) async =>
      _fss.write(key: key, value: value);

  Future<void> delete({required String key}) async => _fss.delete(key: key);
}

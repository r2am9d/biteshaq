import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FssUtil {
  FssUtil._internal();

  static final _fss = FlutterSecureStorage(
    aOptions: _androidOptions(),
    iOptions: _iosOptions(),
  );
  static final FssUtil _instance = FssUtil._internal();

  factory FssUtil() => _instance;

  static AndroidOptions _androidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions _iosOptions() => const IOSOptions();

  Future<String?> read({required String key}) async =>
      await _fss.read(key: key);

  void write({required String key, required String value}) async =>
      await _fss.write(key: key, value: value);

  void delete({required String key}) async => await _fss.delete(key: key);
}

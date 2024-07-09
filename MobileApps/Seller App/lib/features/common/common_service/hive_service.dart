import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:razin_commerce_seller_flutter/config/app_constants.dart';

class HiveService {
  final Ref ref;
  HiveService({required this.ref});

// Save auth token
  Future<void> saveToken({required String token}) async {
    await Hive.openBox(AppConstants.authBox).then(
      (box) => [box.put(AppConstants.authToken, token), box.close()],
    );
  }

  Future setPrimaryColor({required String color}) async {
    final box = Hive.box(AppConstants.appSettingsBox);
    box.put(AppConstants.primaryColor, color);
  }

// Get auth token
  Future<String?> getToken() async {
    final box = await Hive.openBox(AppConstants.authBox);
    final value = box.get(AppConstants.authToken);
    //box.close();
    return value;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_commerce_seller_flutter/features/common/common_service/common_service.dart';
import 'package:razin_commerce_seller_flutter/features/common/common_service/hive_service.dart';
import 'package:razin_commerce_seller_flutter/features/common/repositories/common_repository.dart';

final commonRepositoryProvider = Provider((ref) => CommonRepository(ref: ref));

final hiveServiceProvider = Provider((ref) => HiveService(ref: ref));

final commonServiceProvider = StateNotifierProvider<CommonService, bool>(
  (ref) => CommonService(ref: ref),
);

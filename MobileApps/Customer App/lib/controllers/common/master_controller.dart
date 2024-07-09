import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/common/master_model.dart';
import 'package:razin_shop/services/common/master_service_provider.dart';

class MasterController extends StateNotifier<bool> {
  final Ref ref;

  MasterController(this.ref) : super(false);

  late MasterModel _masterModel;
  MasterModel get materModel => _masterModel;

  Future<MasterModel?> getMasterData() async {
    try {
      final response =
          await ref.read(masterServiceProvider).getMasterSettings();
      _masterModel = MasterModel.fromJson(response.data);
      return _masterModel;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }
}

final masterControllerProvider = StateNotifierProvider<MasterController, bool>(
    (ref) => MasterController(ref));

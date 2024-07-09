import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razin_shop/models/common/contact_us.dart';
import 'package:razin_shop/services/common/other_service_provider.dart';
import 'package:razin_shop/utils/global_function.dart';

import '../../models/common/html_content.dart';

final termsAndConditionsControllerProvider = StateNotifierProvider.autoDispose<
    TermsAndConditionController, AsyncValue<HtmlContentModel>>((ref) {
  final controller = TermsAndConditionController(ref);
  controller.getTermsAndConditions();
  return controller;
});

class TermsAndConditionController
    extends StateNotifier<AsyncValue<HtmlContentModel>> {
  final Ref ref;

  TermsAndConditionController(
    this.ref,
  ) : super(const AsyncValue.loading());

  Future<void> getTermsAndConditions() async {
    try {
      final response =
          await ref.read(otherServiceProvider).getTermsAndConditions();
      state = AsyncData(HtmlContentModel.fromJson(response.data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}

final privacyPolicyControllerProvider = StateNotifierProvider.autoDispose<
    PrivacyPolicyController, AsyncValue<HtmlContentModel>>((ref) {
  final controller = PrivacyPolicyController(ref);
  controller.getPrivacyPolicy();
  return controller;
});

class PrivacyPolicyController
    extends StateNotifier<AsyncValue<HtmlContentModel>> {
  final Ref ref;

  PrivacyPolicyController(
    this.ref,
  ) : super(const AsyncValue.loading());

  Future<void> getPrivacyPolicy() async {
    try {
      final response = await ref.read(otherServiceProvider).getPrivacyPolicy();
      state = AsyncData(HtmlContentModel.fromJson(response.data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}

final refundPolicyControllerProvider = StateNotifierProvider.autoDispose<
    RefundPolicyController, AsyncValue<HtmlContentModel>>((ref) {
  final controller = RefundPolicyController(ref);
  controller.getRefundPolicy();
  return controller;
});

class RefundPolicyController
    extends StateNotifier<AsyncValue<HtmlContentModel>> {
  final Ref ref;
  RefundPolicyController(this.ref) : super(const AsyncValue.loading());
  Future<void> getRefundPolicy() async {
    try {
      final response = await ref.read(otherServiceProvider).getRefundPolicy();
      state = AsyncData(HtmlContentModel.fromJson(response.data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}

final supportControllerProvider =
    StateNotifierProvider<SupportController, bool>((ref) {
  final controller = SupportController(ref);

  return controller;
});

class SupportController extends StateNotifier<bool> {
  final Ref ref;

  SupportController(
    this.ref,
  ) : super(false);

  Future<void> support(
      {required String subject, required String message}) async {
    try {
      state = true;
      final response = await ref
          .read(otherServiceProvider)
          .support(subject: subject, message: message);
      GlobalFunction.showCustomSnackbar(
          message: response.data['message'], isSuccess: true);
      state = false;
    } catch (error) {
      debugPrint(error.toString());
      GlobalFunction.showCustomSnackbar(message: message, isSuccess: true);
      state = false;
    }
  }
}

final contactUsControllerProvider =
    StateNotifierProvider<ContactUsController, AsyncValue<ContactUsModel>>(
        (ref) {
  final controller = ContactUsController(ref);
  controller.getContactUsInfo();
  return controller;
});

class ContactUsController extends StateNotifier<AsyncValue<ContactUsModel>> {
  final Ref ref;
  ContactUsController(this.ref) : super(const AsyncValue.loading());
  Future<void> getContactUsInfo() async {
    try {
      final response = await ref.read(otherServiceProvider).getContactUsinfo();
      state = AsyncData(ContactUsModel.fromMap(response.data));
    } catch (error, stackTrace) {
      debugPrint(error.toString());
      state = AsyncError(error, stackTrace);
    }
  }
}

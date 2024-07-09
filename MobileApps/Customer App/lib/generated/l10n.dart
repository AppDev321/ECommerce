// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Deliver to`
  String get deliverTo {
    return Intl.message(
      'Deliver to',
      name: 'deliverTo',
      desc: '',
      args: [],
    );
  }

  /// `Search your product here!`
  String get searchProduct {
    return Intl.message(
      'Search your product here!',
      name: 'searchProduct',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `View More`
  String get viewMore {
    return Intl.message(
      'View More',
      name: 'viewMore',
      desc: '',
      args: [],
    );
  }

  /// `Deal of the Day`
  String get dealOfTheDay {
    return Intl.message(
      'Deal of the Day',
      name: 'dealOfTheDay',
      desc: '',
      args: [],
    );
  }

  /// `Ending in`
  String get endingIn {
    return Intl.message(
      'Ending in',
      name: 'endingIn',
      desc: '',
      args: [],
    );
  }

  /// `Popular Products`
  String get popularProducts {
    return Intl.message(
      'Popular Products',
      name: 'popularProducts',
      desc: '',
      args: [],
    );
  }

  /// `Just For You`
  String get justForYou {
    return Intl.message(
      'Just For You',
      name: 'justForYou',
      desc: '',
      args: [],
    );
  }

  /// `Saved Address`
  String get savedAddress {
    return Intl.message(
      'Saved Address',
      name: 'savedAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNew {
    return Intl.message(
      'Add New',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Customer Review`
  String get customerReview {
    return Intl.message(
      'Customer Review',
      name: 'customerReview',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Price:High To Low`
  String get priceHighToLow {
    return Intl.message(
      'Price:High To Low',
      name: 'priceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `Price: Low To High`
  String get priceLowToHigh {
    return Intl.message(
      'Price: Low To High',
      name: 'priceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `New Product`
  String get newProduct {
    return Intl.message(
      'New Product',
      name: 'newProduct',
      desc: '',
      args: [],
    );
  }

  /// `Most Selling`
  String get mostSelling {
    return Intl.message(
      'Most Selling',
      name: 'mostSelling',
      desc: '',
      args: [],
    );
  }

  /// `Top Seller`
  String get topSeller {
    return Intl.message(
      'Top Seller',
      name: 'topSeller',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get productPrice {
    return Intl.message(
      'Product Price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Read More`
  String get readMore {
    return Intl.message(
      'Read More',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Read Less`
  String get readLess {
    return Intl.message(
      'Read Less',
      name: 'readLess',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Estimated delivery time`
  String get estdTime {
    return Intl.message(
      'Estimated delivery time',
      name: 'estdTime',
      desc: '',
      args: [],
    );
  }

  /// `About Product`
  String get aboutProduct {
    return Intl.message(
      'About Product',
      name: 'aboutProduct',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Visit Store`
  String get vistiStore {
    return Intl.message(
      'Visit Store',
      name: 'vistiStore',
      desc: '',
      args: [],
    );
  }

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message(
      'Buy Now',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `This product is already in your cart!`
  String get productInCart {
    return Intl.message(
      'This product is already in your cart!',
      name: 'productInCart',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Store voucher`
  String get storeVoucher {
    return Intl.message(
      'Store voucher',
      name: 'storeVoucher',
      desc: '',
      args: [],
    );
  }

  /// `Enter promo code here`
  String get promoCode {
    return Intl.message(
      'Enter promo code here',
      name: 'promoCode',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get orderSummary {
    return Intl.message(
      'Order Summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total`
  String get subTotal {
    return Intl.message(
      'Sub Total',
      name: 'subTotal',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge`
  String get deliveryCharge {
    return Intl.message(
      'Delivery Charge',
      name: 'deliveryCharge',
      desc: '',
      args: [],
    );
  }

  /// `Payable Amount`
  String get payableAmount {
    return Intl.message(
      'Payable Amount',
      name: 'payableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Please select shop for confirm the checkout!`
  String get shopSelectValidation {
    return Intl.message(
      'Please select shop for confirm the checkout!',
      name: 'shopSelectValidation',
      desc: '',
      args: [],
    );
  }

  /// `Voucher from:`
  String get voucherFrom {
    return Intl.message(
      'Voucher from:',
      name: 'voucherFrom',
      desc: '',
      args: [],
    );
  }

  /// `Minimum spend`
  String get minimumSpend {
    return Intl.message(
      'Minimum spend',
      name: 'minimumSpend',
      desc: '',
      args: [],
    );
  }

  /// `Validity till`
  String get validity {
    return Intl.message(
      'Validity till',
      name: 'validity',
      desc: '',
      args: [],
    );
  }

  /// `Collected`
  String get collected {
    return Intl.message(
      'Collected',
      name: 'collected',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `Get in Touch`
  String get getInTouch {
    return Intl.message(
      'Get in Touch',
      name: 'getInTouch',
      desc: '',
      args: [],
    );
  }

  /// `Always within your reach`
  String get alwaysWithYourReach {
    return Intl.message(
      'Always within your reach',
      name: 'alwaysWithYourReach',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Write subject here`
  String get writeSubjectHere {
    return Intl.message(
      'Write subject here',
      name: 'writeSubjectHere',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Start writing...`
  String get startWriting {
    return Intl.message(
      'Start writing...',
      name: 'startWriting',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `or,Contact via`
  String get contactVia {
    return Intl.message(
      'or,Contact via',
      name: 'contactVia',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Manage Address`
  String get manageAddress {
    return Intl.message(
      'Manage Address',
      name: 'manageAddress',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Refund Policy`
  String get refundPolicy {
    return Intl.message(
      'Refund Policy',
      name: 'refundPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsCondistions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsCondistions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to logout?`
  String get logoutDialogTitle {
    return Intl.message(
      'Are you sure want to logout?',
      name: 'logoutDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `You will need to re-enter your credentials to access your account again.Your local save data will be clean!`
  String get logoutDialogDes {
    return Intl.message(
      'You will need to re-enter your credentials to access your account again.Your local save data will be clean!',
      name: 'logoutDialogDes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recoverPassword {
    return Intl.message(
      'Recover Password',
      name: 'recoverPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the phone number that you used when register to recover your password. You will receive a OTP code.`
  String get recoverPassDes {
    return Intl.message(
      'Enter the phone number that you used when register to recover your password. You will receive a OTP code.',
      name: 'recoverPassDes',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterPhoneNum {
    return Intl.message(
      'Enter your phone number',
      name: 'enterPhoneNum',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message(
      'Send OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterotp {
    return Intl.message(
      'Enter OTP',
      name: 'enterotp',
      desc: '',
      args: [],
    );
  }

  /// `We sent OTP code to your phone number`
  String get weSentOtp {
    return Intl.message(
      'We sent OTP code to your phone number',
      name: 'weSentOtp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm OTP`
  String get confirmOtp {
    return Intl.message(
      'Confirm OTP',
      name: 'confirmOtp',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code in`
  String get resendCode {
    return Intl.message(
      'Resend Code in',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get createNewPassword {
    return Intl.message(
      'Create New Password',
      name: 'createNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Type and confirm a secret new password for your account.`
  String get typeConfirmSecretPassword {
    return Intl.message(
      'Type and confirm a secret new password for your account.',
      name: 'typeConfirmSecretPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create new password`
  String get createNewPass {
    return Intl.message(
      'Create new password',
      name: 'createNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get confirmNewPass {
    return Intl.message(
      'Confirm new password',
      name: 'confirmNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `is required!`
  String get isRequired {
    return Intl.message(
      'is required!',
      name: 'isRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please sign up to continue shopping`
  String get signUpToContinue {
    return Intl.message(
      'Please sign up to continue shopping',
      name: 'signUpToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter full name`
  String get enFullName {
    return Intl.message(
      'Enter full name',
      name: 'enFullName',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Search country name`
  String get searchCountryName {
    return Intl.message(
      'Search country name',
      name: 'searchCountryName',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty!`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty!',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Product Not Found!`
  String get productNotFount {
    return Intl.message(
      'Product Not Found!',
      name: 'productNotFount',
      desc: '',
      args: [],
    );
  }

  /// `Favourites `
  String get favorites {
    return Intl.message(
      'Favourites ',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processig {
    return Intl.message(
      'Processing',
      name: 'processig',
      desc: '',
      args: [],
    );
  }

  /// `On The Way`
  String get onTheWay {
    return Intl.message(
      'On The Way',
      name: 'onTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Service Item`
  String get serviceItem {
    return Intl.message(
      'Service Item',
      name: 'serviceItem',
      desc: '',
      args: [],
    );
  }

  /// `Shopping From`
  String get shoppingFrom {
    return Intl.message(
      'Shopping From',
      name: 'shoppingFrom',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get orderDate {
    return Intl.message(
      'Order Date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `How was the product?`
  String get hWtheProduct {
    return Intl.message(
      'How was the product?',
      name: 'hWtheProduct',
      desc: '',
      args: [],
    );
  }

  /// `Write something about this product`
  String get writeSATP {
    return Intl.message(
      'Write something about this product',
      name: 'writeSATP',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Again`
  String get orderAgain {
    return Intl.message(
      'Order Again',
      name: 'orderAgain',
      desc: '',
      args: [],
    );
  }

  /// `Download Invoice`
  String get downloadInvoice {
    return Intl.message(
      'Download Invoice',
      name: 'downloadInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Default Address`
  String get defaultAddress {
    return Intl.message(
      'Default Address',
      name: 'defaultAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get addNewAddress {
    return Intl.message(
      'Add New Address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get flat {
    return Intl.message(
      'Flat',
      name: 'flat',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postalCode {
    return Intl.message(
      'Postal Code',
      name: 'postalCode',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 1`
  String get addressLine1 {
    return Intl.message(
      'Address Line 1',
      name: 'addressLine1',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 2`
  String get addressLine2 {
    return Intl.message(
      'Address Line 2',
      name: 'addressLine2',
      desc: '',
      args: [],
    );
  }

  /// `Address Tag`
  String get addressTag {
    return Intl.message(
      'Address Tag',
      name: 'addressTag',
      desc: '',
      args: [],
    );
  }

  /// `Make it default address`
  String get makeItDefault {
    return Intl.message(
      'Make it default address',
      name: 'makeItDefault',
      desc: '',
      args: [],
    );
  }

  /// `Delete this`
  String get deleteThis {
    return Intl.message(
      'Delete this',
      name: 'deleteThis',
      desc: '',
      args: [],
    );
  }

  /// `Office`
  String get office {
    return Intl.message(
      'Office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `My Order`
  String get myOrder {
    return Intl.message(
      'My Order',
      name: 'myOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to cancel this order?`
  String get orderCancelDialogDes {
    return Intl.message(
      'Are you sure want to cancel this order?',
      name: 'orderCancelDialogDes',
      desc: '',
      args: [],
    );
  }

  /// `No vouchers found for this store!`
  String get voucherNotAvailable {
    return Intl.message(
      'No vouchers found for this store!',
      name: 'voucherNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter current password`
  String get enterCurrentPass {
    return Intl.message(
      'Enter current password',
      name: 'enterCurrentPass',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Shops`
  String get shops {
    return Intl.message(
      'Shops',
      name: 'shops',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Whoops!!`
  String get whoops {
    return Intl.message(
      'Whoops!!',
      name: 'whoops',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection was found. Check your connection or try again.`
  String get noInternetDes {
    return Intl.message(
      'No Internet connection was found. Check your connection or try again.',
      name: 'noInternetDes',
      desc: '',
      args: [],
    );
  }

  /// `Check Internet Connection`
  String get checkInternetConnection {
    return Intl.message(
      'Check Internet Connection',
      name: 'checkInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please select Shop to apply the promo code!`
  String get couponApplyValidation {
    return Intl.message(
      'Please select Shop to apply the promo code!',
      name: 'couponApplyValidation',
      desc: '',
      args: [],
    );
  }

  /// `Email or Phone`
  String get emailOrPhone {
    return Intl.message(
      'Email or Phone',
      name: 'emailOrPhone',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

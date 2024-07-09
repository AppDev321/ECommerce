import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:razin_commerce_seller_flutter/config/app_color.dart';
import 'package:razin_commerce_seller_flutter/config/app_text_style.dart';
import 'package:razin_commerce_seller_flutter/config/theme.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_details.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/models/wallet_history_filter_model.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/providers/wallet_provider.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/widgets/wallet_card.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/widgets/withdraw_dialog.dart';
import 'package:razin_commerce_seller_flutter/features/wallet/widgets/withdraw_history_card.dart';
import 'package:razin_commerce_seller_flutter/gen/assets.gen.dart';
import 'package:razin_commerce_seller_flutter/utils/global_function.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();

  static final List<Map<String, dynamic>> filterOptions = [
    {
      'value': 'Today',
      'key': 'today',
    },
    {
      'value': 'This Week',
      'key': 'this_week',
    },
    {
      'value': 'Last Week',
      'key': 'last_week',
    },
    {
      'value': 'This Month',
      'key': 'this_month',
    },
    {
      'value': 'Last Month',
      'key': 'last_month',
    },
    {
      'value': 'This Year',
      'key': 'this_year',
    },
    {
      'value': 'Last Year',
      'key': 'last_year',
    },
  ];
}

class _WalletState extends ConsumerState<Wallet> {
  int page = 1;
  int perPage = 20;
  @override
  void initState() {
    if (mounted) ref.refresh(selectedFilterOption.notifier).state;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(walletHistoryServiceProvider.notifier).getWalletHistory(
          filterModel: WalletHistoryFilterModel(page: page, perPage: perPage));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          _buildDateWiseFilterWidget(),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWalletSummaryWidget(),
          Gap(24.h),
          _buildWithdrawalHistoryWidget(),
        ],
      ),
    );
  }

  Widget _buildWalletSummaryWidget() {
    return Container(
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: ref.watch(walletDetailsServiceProvider('today')).when(
            data: (walletDetails) => Column(
              children: [
                _walletHeaderWiget(walletDetails: walletDetails),
                Gap(8.h),
                _buildCommissionAndProfitWidget(walletDetails: walletDetails),
                Gap(28.h),
                walletDetails.pendingWithdraw != null
                    ? _buildWithdrawRequestCardWidget(
                        walletDetails: walletDetails)
                    : _buildWithdrawCardWidget(walletDetails: walletDetails),
                Gap(16.h),
                _lifeTimeSales(walletDetails: walletDetails),
              ],
            ),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(child: CircularProgressIndicator())),
            ),
          ),
    );
  }

  Widget _buildWithdrawalHistoryWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ref.watch(walletHistoryServiceProvider)
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : _buildHistoryWidget(),
    );
  }

  Widget _walletHeaderWiget({required WalletDetails walletDetails}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.99, -0.12),
          end: const Alignment(0.99, 0.12),
          colors: [
            const Color(0xFFB822FF),
            colors(context).primaryColor!,
          ],
        ),
        borderRadius: BorderRadius.circular(16.dm),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sales in ${ref.watch(selectedFilterOption)['value'] == 'Today' ? DateFormat.MMMM().format(DateTime.now()) : ref.watch(selectedFilterOption)['value']}',
                style: AppTextStyle.text12B700.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colors(GlobalFunction.navigatorKey.currentContext)
                        .light),
              ),
              SvgPicture.asset(Assets.svg.walletElement)
            ],
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${walletDetails.totalSales}',
                style: AppTextStyle.text24B700.copyWith(
                  color:
                      colors(GlobalFunction.navigatorKey.currentContext).light,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                decoration: ShapeDecoration(
                  color: colors(GlobalFunction.navigatorKey.currentContext)
                      .light!
                      .withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100.dm,
                    ),
                  ),
                ),
                child: Text(
                  walletDetails.growthPercentage,
                  style: AppTextStyle.text12B700.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colors(GlobalFunction.navigatorKey.currentContext)
                        .light,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommissionAndProfitWidget(
      {required WalletDetails walletDetails}) {
    return Row(
      children: [
        Flexible(
          child: WalletCardWidget(
            text: 'Commission',
            icon: Assets.svg.commissionCircle,
            amount: '-\$${walletDetails.commission}',
          ),
        ),
        Gap(8.w),
        Flexible(
          child: WalletCardWidget(
            text: 'Profit',
            icon: Assets.svg.dollarCircle,
            amount: '\$${walletDetails.profit}',
          ),
        ),
      ],
    );
  }

  Widget _buildWithdrawCardWidget({required WalletDetails walletDetails}) {
    return Container(
      padding: EdgeInsets.all(12.dm),
      decoration: BoxDecoration(
        color: AppStaticColor.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${walletDetails.withdrawableAmount}',
                  style: AppTextStyle.text16B700.copyWith(
                    fontSize: 18.sp,
                    color: AppStaticColor.white,
                  ),
                ),
                Gap(4.h),
                Text(
                  'Withdrawable amount',
                  style: AppTextStyle.text12B700.copyWith(
                    fontSize: 12.sp,
                    color: AppStaticColor.secondary,
                  ),
                )
              ],
            ),
          ),
          Gap(16.w),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () => walletDetails.isWithdrawable
                  ? showDialog(
                      useSafeArea: false,
                      context: context,
                      barrierDismissible: false,
                      useRootNavigator: false,
                      builder: (context) => WithdrawDialog(
                        walletDetails: walletDetails,
                      ),
                    )
                  : null,
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  color: walletDetails.isWithdrawable
                      ? null
                      : colors(context).dark!.withOpacity(0.5),
                ),
                child: Container(
                  height: 36,
                  decoration: ShapeDecoration(
                    color: AppStaticColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Withdraw',
                      style: AppTextStyle.text12B700
                          .copyWith(color: AppStaticColor.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWithdrawRequestCardWidget(
      {required WalletDetails walletDetails}) {
    return Container(
      padding: EdgeInsets.all(12.dm),
      decoration: BoxDecoration(
        color: AppStaticColor.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '\$${walletDetails.pendingWithdraw?.amount}',
                      style: AppTextStyle.text16B700.copyWith(
                        fontSize: 18.sp,
                        color: AppStaticColor.white,
                      ),
                    ),
                    Gap(5.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.dm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.dm),
                        color: AppStaticColor.orange.withOpacity(0.9),
                      ),
                      child: Text('Pending',
                          style: AppTextStyle.text12B700
                              .copyWith(fontWeight: FontWeight.w400)),
                    ),
                  ],
                ),
                Gap(4.h),
                Text(
                  'Withdrawal request',
                  style: AppTextStyle.text12B700.copyWith(
                    fontSize: 12.sp,
                    color: AppStaticColor.secondary,
                  ),
                )
              ],
            ),
          ),
          Gap(16.w),
          SvgPicture.asset(Assets.svg.walletPending)
        ],
      ),
    );
  }

  Widget _lifeTimeSales({required WalletDetails walletDetails}) {
    return Container(
      decoration: BoxDecoration(
        color: AppStaticColor.secondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        leading: SvgPicture.asset(
          Assets.svg.lifeTimeSales,
          colorFilter:
              ColorFilter.mode(AppStaticColor.primary, BlendMode.srcIn),
        ),
        title: Text(
          'Lifetime sales',
          style: AppTextStyle.text14B400.copyWith(color: AppStaticColor.gray),
        ),
        trailing: Text(
          '\$${walletDetails.lifetimeSales}',
          style: AppTextStyle.text14B700,
        ),
      ),
    );
  }

  Widget _buildHistoryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Withdrawal History'),
        Gap(16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ref
              .watch(walletHistoryServiceProvider.notifier)
              .walletHistoryList
              .length,
          itemBuilder: ((context, index) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: WithdrawHistoryCard(
                  walletHistory: ref
                      .watch(walletHistoryServiceProvider.notifier)
                      .walletHistoryList[index],
                ),
              )),
        ),
        Gap(18.h),
        if (ref.watch(walletHistoryServiceProvider.notifier).totalHistoryCount >
            perPage)
          _buildLoadMorebutton(),
        Gap(38.h),
      ],
    );
  }

  Widget _buildLoadMorebutton() {
    return InkWell(
      onTap: () => ref
          .read(walletHistoryServiceProvider.notifier)
          .getWalletHistory(
            filterModel: WalletHistoryFilterModel(page: page, perPage: perPage),
          ),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 38.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppStaticColor.primary),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            'Load More',
            style: AppTextStyle.text14B700.copyWith(
              fontWeight: FontWeight.w500,
              color: AppStaticColor.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateWiseFilterWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: () => _popupMenuWidget(),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 36.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(
                color: ref.watch(isActiveFilter)
                    ? colors(GlobalFunction.navigatorKey.currentContext)
                        .primaryColor!
                    : AppStaticColor.secondary),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Text(
                ref.watch(selectedFilterOption)['value'],
                style: AppTextStyle.text14B400
                    .copyWith(color: AppStaticColor.gray),
              ),
              Gap(5.w),
              SvgPicture.asset(ref.watch(isActiveFilter)
                  ? Assets.svg.arrowTop
                  : Assets.svg.arrowBottom)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _popupMenuWidget() {
    ref.read(isActiveFilter.notifier).state = true;
    return showMenu(
      elevation: 1,
      color: colors(GlobalFunction.navigatorKey.currentContext).light,
      surfaceTintColor:
          colors(GlobalFunction.navigatorKey.currentContext).light,
      context: GlobalFunction.navigatorKey.currentContext!,
      position: RelativeRect.fromLTRB(100, 80.h, 0, 0),
      items: Wallet.filterOptions.map(
        (option) {
          final value = option['value'];
          return PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            value: option,
            child: RadioListTile(
              visualDensity: VisualDensity.compact,
              value: option,
              groupValue: ref.watch(selectedFilterOption),
              onChanged: (selectedOption) {
                final selectedKey = selectedOption!['key'];
                ref.read(selectedFilterOption.notifier).state = selectedOption;
                ref.read(walletDetailsServiceProvider(selectedKey));

                GoRouter.of(GlobalFunction.navigatorKey.currentContext!).pop();
              },
              title: Text(
                value,
                style: AppTextStyle.text14B400
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ).toList(),
    ).then(
      (value) => ref.read(isActiveFilter.notifier).state = false,
    );
  }
}

final selectedFilterOption = StateProvider<Map<String, dynamic>>((ref) => {
      'value': 'Today',
      'key': 'today',
    });
final isActiveFilter = StateProvider<bool>((ref) => false);

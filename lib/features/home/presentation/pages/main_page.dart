import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salon_reservation/features/transaction/presentation/transactions_page.dart';
import '../../../reservation/presentation/reservation_list_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.givenIndex});

  final int? givenIndex;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.givenIndex ?? 0;
    super.initState();
  }

  final List<Widget> _tabs = [
    const DashboardPage(),
    const MyReservationsPage(),
    const TransactionsPage(),
  ];


  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: AppStyles.body,
        unselectedLabelStyle: AppStyles.body,
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
        items:  [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                width: 28.w,
                semanticsLabel: 'home'.tr()
            ),
            icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 28.w,
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'home'.tr()
            ),
            label: 'home'.tr(),
          ),

          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/orders.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                semanticsLabel: 'reservations'
            ),
            icon: SvgPicture.asset(
                'assets/icons/orders.svg',
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'reservations'
            ),
            label: 'reservations'.tr(),
          ),

          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
                'assets/icons/transaction.svg',
                colorFilter: const ColorFilter.mode(AppColors.secondary, BlendMode.srcIn),
                semanticsLabel: 'transactions'
            ),
            icon: SvgPicture.asset(
                'assets/icons/transaction.svg',
                colorFilter: const ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
                semanticsLabel: 'transactions'
            ),
            label: 'transactions'.tr(),
          ),
        ],
      ),
    );
  }
}

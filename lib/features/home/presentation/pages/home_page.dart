import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/boilerplate/get_model/widgets/get_model.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/formatters.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/features/transaction/data/transaction_model.dart';
import 'package:salon_reservation/features/transaction/domain/transaction_repo.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/widget/custom_card.dart';
import '../../../../core/widget/custom_grid.dart';
import '../../../salon/presentation/services_page.dart';
import '../../../salon/presentation/edit_salon_details_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {



  @override
  Widget build(BuildContext context) {
    List<CustomCardItem> menuItems = [
      CustomCardItem(
          title: 'services'.tr(),
          icon: Icons.category,
          onPressed: () => Navigation.push(context, const ServicesPage())),

      CustomCardItem(
          title: 'editSalon'.tr(),
          icon: Icons.edit,
          onPressed: () => Navigation.push(context, const EditSalonDetailsPage())),
    ];

    return BasePage(
      //drawer: const CustomDrawer(),
      isCentered: false,
      title: 'adminPanel'.tr(),
      isScrollable: false,
      content: Column(
        children: [
          GetModel<RemainingResponseModel>(
            repositoryCallBack: (data) => TransactionRepository.getRemaining(),
            modelBuilder: (model) {
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text('${'remaining'.tr()}: ${Formatters.formatPrice(double.parse(model!.remaining.toString())) ?? ''}', style: AppStyles.title.copyWith(fontWeight: FontWeight.w600),));
            },

          ),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // You can change the number of cards in a row here
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5),
              children: menuItems
                  .map((item) =>  CustomCard(
                  icon: item.icon, title: item.title, onPressed: item.onPressed))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}



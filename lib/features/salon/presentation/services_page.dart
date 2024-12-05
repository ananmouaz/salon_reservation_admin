import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/features/salon/presentation/add_service_page.dart';
import 'package:salon_reservation/features/salon/domain/salon_repo.dart';
import 'package:salon_reservation/features/salon/presentation/widget/service_widget.dart';

import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/utils/navigation.dart';
import '../../../core/utils/service_locator.dart';
import '../data/model/salon_model.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'services'.tr(),
        isScrollable: false,
        hasMenu: false,
        isCentered: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.black,),
        onPressed: () {
          Navigation.push(context, const AddServicePage());
        },
      ),
        content: Column(
      children: [
        Expanded(
          child: PaginationList<ServiceModel>(
          onCubitCreated: (cubit) {
                ServiceLocator.setServices(cubit!);
          },
              repositoryCallBack: (data) => SalonRepository.getServices(data),
              listBuilder: (model) {
            return ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                return ServiceWidget(
                    onTap: () {

                    },
                    service: model[index]);
              },
            );}),
        )],
    ));
  }
}

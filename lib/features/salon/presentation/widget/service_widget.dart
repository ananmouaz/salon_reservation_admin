import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/api/core_models/message_response_model.dart';
import 'package:salon_reservation/core/boilerplate/create_model/cubits/create_model_cubit.dart';
import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/formatters.dart';
import 'package:salon_reservation/core/utils/navigation.dart';
import 'package:salon_reservation/features/salon/domain/salon_repo.dart';

import '../../data/model/salon_model.dart';
import '../edit_service_page.dart';

class ServiceWidget extends StatefulWidget {
  final ServiceModel? service;
  final VoidCallback? onTap;

  const ServiceWidget({
    super.key,
    required this.service,
    this.onTap,
  });

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  late CreateModelCubit deleteService;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.service?.name != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 20,
                          ),
                          Width.v8,
                          Text(
                            widget.service?.name ?? '',
                            style: AppStyles.title
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      IconButton(
                        color: AppColors.white,
                        onPressed: () {
                          Navigation.push(
                              context,
                              EditServicePage(
                                serviceModel: widget.service ?? ServiceModel(),
                              ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      )
                    ],
                  )
                : Align(
              alignment: Alignment.centerRight,
                  child: IconButton(
                      color: AppColors.white,
                      onPressed: () {
                        Navigation.push(
                            context,
                            EditServicePage(
                              serviceModel: widget.service ?? ServiceModel(),
                            ));
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                ),
            if (widget.service?.name != null) Height.v8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.service?.service ?? '',
                  style: AppStyles.headline
                      .copyWith(color: AppColors.white, fontSize: 16),
                ),
                Text(
                  (widget.service?.type ?? '').tr(),
                  style: AppStyles.title.copyWith(color: AppColors.white),
                ),
              ],
            ),
            Height.v8,
            const Divider(
              color: AppColors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled_outlined,
                      color: AppColors.white,
                    ),
                    Width.v8,
                    Text(
                      '${widget.service?.duration}',
                      style: AppStyles.body.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                Text(
                  Formatters.formatPrice(
                      widget.service?.price?.toDouble() ?? 0),
                  style: AppStyles.headline.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/features/reservation/presentation/widget/status_widget.dart';
import 'package:salon_reservation/features/transaction/data/transaction_model.dart';

import '../../../../core/utils/navigation.dart';
import '../../../core/formatters.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, this.transaction});

  final Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColors.secondary)
          ),
          color: AppColors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${'paid'.tr()}: ${transaction?.payment.toString() ?? ' '}',
                      style: AppStyles.title,
                    ),
                    Text(
                      '${'remaining'.tr()}: ${transaction?.remaining.toString() ?? ' '}',
                      style: AppStyles.title,
                    ),
                  ],
                )
              ),
              if(transaction?.createdAt != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: AppColors.secondary.withOpacity(0.8),
                child: Text(
                  Formatters.formatDatetime(transaction?.createdAt.toString() ?? '') ?? '',
                  style: AppStyles.title.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

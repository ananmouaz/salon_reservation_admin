import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/api/core_models/message_response_model.dart';
import 'package:salon_reservation/core/boilerplate/create_model/cubits/create_model_cubit.dart';
import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/constants/app_colors.dart';
import 'package:salon_reservation/core/constants/app_styles.dart';
import 'package:salon_reservation/core/utils/service_locator.dart';
import 'package:salon_reservation/core/widget/custom_button.dart';
import 'package:salon_reservation/core/widget/form/custom_text_field.dart';
import 'package:salon_reservation/core/widget/loading_widget.dart';
import 'package:salon_reservation/features/reservation/data/change_status_request_model.dart';
import 'package:salon_reservation/features/reservation/domain/reservation_repo.dart';
import 'package:salon_reservation/features/reservation/presentation/widget/status_widget.dart';

import '../../../../core/utils/di.dart';
import '../../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../../core/validator.dart';
import '../../data/reservation_model.dart';

class ReservationCard extends StatefulWidget {
  const ReservationCard({Key? key, this.reservation, this.onPressed}) : super(key: key);

  final Reservation? reservation;
  final VoidCallback? onPressed;

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  late String selectedStatus;

  Map<String, String> arabicToEnglish = {
    "قيد الانتظار" : "pending",
    "موافق عليه" : "approved",
    "منتهية" : "finished",
    "ألغيت" : "canceled",
  };

  static final AppPreferences appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    selectedStatus = appPreferences.getLanguage() == 'ar' ? (widget.reservation?.status?.toLowerCase().tr() ?? 'pending'.tr()) : widget.reservation?.status?.toLowerCase().tr() ?? 'pending'.tr(); // Set the initial status
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.secondary)),
            color: AppColors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.reservation?.price.toString() ?? '',
                            style: AppStyles.title
                                .copyWith(color: AppColors.secondary),
                          ),
                          Text(
                            widget.reservation?.business?.name ?? '',
                            style: AppStyles.headline
                                .copyWith(color: AppColors.secondary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.reservation?.service?.service ?? '',
                            style: AppStyles.body
                                .copyWith(color: AppColors.secondary),
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) {
                              return {'editStatus'.tr(), 'editTotal'.tr()}
                                  .map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                            onSelected: (String choice) {
                              // Handle menu item selection
                              if (choice == 'editStatus'.tr()) {
                                _showStatusBottomSheet();
                              } else if (choice == 'editTotal'.tr()) {
                                _showLoading();
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  color: AppColors.secondary.withOpacity(0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.reservation?.time ?? '',
                        style: AppStyles.body.copyWith(color: AppColors.white),
                      ),
                      StatusWidget(status: widget.reservation?.status?.toLowerCase() ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  late CreateModelCubit changeStatusCubit;
  late CreateModelCubit changeTotalCubit;
  final TextEditingController _priceController = TextEditingController();


  void _showLoading() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Create a focus node to control the focus of the text field
        FocusNode focusNode = FocusNode();

        // Request focus when the bottom sheet is displayed
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(focusNode);
        });

        return CreateModel<MessageResponseModel>(
          loading: const LoadingWidget(),
          repositoryCallBack: (data) => ReservationRepository.changeTotal(data),
          onCubitCreated: (cubit) {
            changeTotalCubit = cubit;
          },
          onSuccess: (model) {
            ServiceLocator.refreshReservations();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message ?? '', style: AppStyles.body),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pop(context); // Close the bottom sheet
          },
          child: Column(
            children: [
              CustomTextField(
                labelText: 'price'.tr(),
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value) => Validator.validateEmpty(value ?? '', 'price'.tr()),
                focusNode: focusNode, // Assign the focus node to the text field
              ),
              CustomButton(
                text: 'submit'.tr(),
                onTap: () {
                  changeTotalCubit.createModel(ChangeTotalRequestModel(price: int.parse(_priceController.text), reservationId: widget.reservation?.id ?? 0));
                },
              ),
            ],
          ),
        );
      },
    );

  }

  void _showStatusBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CreateModel<MessageResponseModel>(
          repositoryCallBack: (data) => ReservationRepository.changeStatus(data),
          onCubitCreated: (cubit) {
            changeStatusCubit = cubit;
          },
          onSuccess: (model) {
            ServiceLocator.refreshReservations();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message ?? '', style: AppStyles.body,),
                backgroundColor: AppColors.green,
              ),
            );
            Navigator.pop(context); // Close the bottom sheet
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                title: Text('approved'.tr()),
                value: 'approved'.tr(),
                groupValue: selectedStatus,
                onChanged: (String? value) {
                  changeStatusCubit.createModel(ChangeStatusRequestModel(status: appPreferences.getLanguage() == 'ar' ? (arabicToEnglish[value?.tr()] ?? '') : value ?? 'approved'.tr(), reservationId: widget.reservation?.id ?? 0));
                  _handleStatusChange(value!);
                },
              ),
              RadioListTile<String>(
                title:  Text('pending'.tr()),
                value: 'pending'.tr(),
                groupValue: selectedStatus,
                onChanged: (String? value) {
                  changeStatusCubit.createModel(ChangeStatusRequestModel(status: appPreferences.getLanguage() == 'ar' ? (arabicToEnglish[value?.tr()] ?? '') : value!, reservationId: widget.reservation?.id ?? 0));
                  _handleStatusChange(value!);
                },
              ),
              RadioListTile<String>(
                title:  Text('cancelled'.tr()),
                value: 'cancelled'.tr(),
                groupValue: selectedStatus,
                onChanged: (String? value) {
                  changeStatusCubit.createModel(ChangeStatusRequestModel(status: appPreferences.getLanguage() == 'ar' ? (arabicToEnglish[value?.tr()] ?? '') : value!, reservationId: widget.reservation?.id ?? 0));
                  _handleStatusChange(value!);
                },
              ),
              RadioListTile<String>(
                title:  Text('finished'.tr()),
                value: 'finished'.tr(),
                groupValue: selectedStatus,
                onChanged: (String? value) {
                  changeStatusCubit.createModel(ChangeStatusRequestModel(status: appPreferences.getLanguage() == 'ar' ? (arabicToEnglish[value?.tr()] ?? '') : value!, reservationId: widget.reservation?.id ?? 0));
                  _handleStatusChange(value!);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleStatusChange(String newStatus) {
    //ReservationRepository.changeStatus(newStatus ?? "", widget.reservation?.id ?? 0);

    // Add your logic here to handle the status change
    setState(() {
      selectedStatus = newStatus;
    });

    // Trigger your custom action based on the selected status
    // You can call a function or perform any action here
    print('Status changed to: $newStatus');
  }
}

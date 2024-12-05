import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/features/salon/data/model/update_business_request_model.dart';

import '../../../core/api/core_models/message_response_model.dart';
import '../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../core/boilerplate/create_model/widgets/create_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/helpers.dart';
import '../../../core/utils/navigation.dart';
import '../../../core/validator.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_dropdown.dart';
import '../../../core/widget/form/custom_text_field.dart';
import '../../home/presentation/pages/main_page.dart';
import '../domain/salon_repo.dart';

class EditSalonDetailsPage extends StatefulWidget {
  const EditSalonDetailsPage({super.key});

  @override
  State<EditSalonDetailsPage> createState() => _EditSalonDetailsPageState();
}

class _EditSalonDetailsPageState extends State<EditSalonDetailsPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _openingHoursController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> statuses = ['open'.tr(), 'closed'.tr()];
  String selectedStatus = '';
  late CreateModelCubit editSalonCubit;


  @override
  void initState() {
    selectedStatus = statuses.first;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'editSalon'.tr(),
        isScrollable: false,
        hasMenu: false,
        isCentered: false,
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'name'.tr(),
                keyboardType: TextInputType.text,
                controller: _nameController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'name'.tr()),
              ),
              Height.v12,
              CustomDropdown(
                label: 'status'.tr(),
                value: selectedStatus,
                items: statuses,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value ?? '';
                  });
                },
              ),
              Height.v12,
              CustomTextField(
                labelText: 'location'.tr(),
                keyboardType: TextInputType.text,
                controller: _locationController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'location'.tr()),
              ),
              Height.v12,
              CustomTextField(
                labelText: 'openingHours'.tr(),
                keyboardType: TextInputType.text,
                controller: _openingHoursController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'openingHours'.tr()),
              ),
              Height.v12,
              CreateModel<MessageResponseModel>(
                  onCubitCreated: (cubit) {
                    editSalonCubit = cubit;
                  },
                  repositoryCallBack: (data) => SalonRepository.updateSalon(data),
                  onSuccess: (model) async{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(model.message ?? '', style: AppStyles.body,),
                        backgroundColor: AppColors.green,
                      ),
                    );
                    Navigation.pushReplacement(context, const MainPage());
                  },
                  child: CustomButton(
                      text: 'submit'.tr(), onTap: () {
                    if(_formKey.currentState!.validate()) {
                      editSalonCubit.createModel(
                          UpdateBusinessRequestModel(
                            location: _locationController.text,
                            name: _nameController.text,
                            hijabis: 1,
                            status: selectedStatus,
                            openingHours: _openingHoursController.text,
                          )
                      );
                    }
                  }
                  )
              )
            ],
          ),
        ));
  }
}

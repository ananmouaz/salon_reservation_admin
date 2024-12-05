import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salon_reservation/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:salon_reservation/core/constants/helpers.dart';
import 'package:salon_reservation/core/widget/base_page.dart';
import 'package:salon_reservation/core/widget/custom_button.dart';
import 'package:salon_reservation/core/widget/custom_dropdown.dart';
import 'package:salon_reservation/features/salon/data/model/add_service_request_model.dart';
import 'package:salon_reservation/features/salon/domain/salon_repo.dart';

import '../../../core/api/core_models/message_response_model.dart';
import '../../../core/boilerplate/create_model/cubits/create_model_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/di.dart';
import '../../../core/utils/navigation.dart';
import '../../../core/utils/service_locator.dart';
import '../../../core/utils/shared_perefrences/shared_perefrences_helper.dart';
import '../../../core/validator.dart';
import '../../../core/widget/form/custom_text_field.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late CreateModelCubit addServiceCubit;
  List<String> types = ['hair'.tr(), 'makeup'.tr(), 'nails'.tr(), 'eyelashes'.tr(), 'tattoo'.tr()];
  String selectedType = '';
  static final AppPreferences appPreferences = instance<AppPreferences>();

  Map<String, String> arabicToEnglish = {
    "شعر": "hair",
    "مكياج": "makeup",
    "أضافر": "nails",
    "رموش": "eyelashes",
    "تاتو": "tattoo",
  };

  @override
  void initState() {
    selectedType = types.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'addService'.tr(),
        isScrollable: false,
        hasMenu: false,
        isCentered: false,
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                labelText: 'service'.tr(),
                keyboardType: TextInputType.text,
                controller: _serviceNameController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'service'.tr()),
              ),
              Height.v12,
              CustomDropdown(
                label: 'type'.tr(),
                value: selectedType,
                items: types,
                onChanged: (value) {
                  setState(() {
                    selectedType = value ?? '';
                  });
                },
              ),
              Height.v12,
              CustomTextField(
                labelText: 'employee'.tr(),
                keyboardType: TextInputType.text,
                controller: _employeeNameController,
              ),
              Height.v12,
              CustomTextField(
                labelText: 'duration'.tr(),
                keyboardType: TextInputType.number,
                controller: _durationController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'duration'.tr()),
              ),
              Height.v12,
              CustomTextField(
                labelText: 'price'.tr(),
                keyboardType: TextInputType.number,
                controller: _priceController,
                validator: (value) =>
                    Validator.validateEmpty(value ?? '', 'price'.tr()),
              ),
              Height.v12,
              CreateModel<MessageResponseModel>(
                  onCubitCreated: (cubit) {
                    addServiceCubit = cubit;
                  },
                  repositoryCallBack: (data) => SalonRepository.addService(data),
                  onSuccess: (model) async{
                    ServiceLocator.refreshServices();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(model.message ?? '', style: AppStyles.body,),
                        backgroundColor: AppColors.green,
                      ),
                    );
                    Navigation.pop(context);
                  },
                  child: CustomButton(
                      text: 'submit'.tr(), onTap: () {
                    if(_formKey.currentState!.validate()) {
                      addServiceCubit.createModel(
                          AddServiceRequestModel(
                            price: _priceController.text,
                            name: _employeeNameController.text,
                            duration: _durationController.text,
                            service: _serviceNameController.text,
                            type: (appPreferences.getLanguage() == 'ar') ? arabicToEnglish[selectedType] : selectedType,
                            status: 1
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

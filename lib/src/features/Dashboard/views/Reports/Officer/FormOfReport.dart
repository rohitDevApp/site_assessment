import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Officer/SubmitReport.dart';
import 'package:site_assessment/src/utils/user.dart';

import '../../../../../api/firebaseApi.dart';
import '../../../../../common_widgets/DateSelectorWithInput.dart';
import '../../../../../common_widgets/NumberInput.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../constants/firebase.dart';

class FormOfReport extends StatefulWidget {
  const FormOfReport({super.key});

  @override
  State<StatefulWidget> createState() => FormReportState();
}

//Form State
class FormReportState extends State<FormOfReport> {
  int currentStep = 0;
  bool isFirstStep() => currentStep == 0;
  bool isLastStep() => currentStep == steps().length - 1;
  bool isComplete = false;
  final personalFormKey = GlobalKey<FormState>();
  final measurementsFormKey = GlobalKey<FormState>();
  final dateFromKey = GlobalKey<FormState>();
  bool isLoading = false;

  final TextEditingController customerController = TextEditingController();
  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateOfVisitController = TextEditingController();
  final TextEditingController pumpCapacityController = TextEditingController();
  final TextEditingController pumpEfficiencyController =
      TextEditingController();
  final TextEditingController liquidTemperatureController =
      TextEditingController();
  final TextEditingController electricPowerController = TextEditingController();
  final TextEditingController installationDateController =
      TextEditingController();
  final TextEditingController lastServiceDateController =
      TextEditingController();

  //List for Generate Report
  List<Step> steps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            stepStyle: StepStyle(
                color: currentStep >= 0
                    ? currentStep > 0
                        ? Colors.green
                        : AppColors.mainColor
                    : Colors.grey),
            isActive: currentStep > 0,
            title: CustomText(
                "Personal", 12, FontWeight.bold, AppColors.mainColor),
            content: Column(
              children: [
                Form(
                    key: personalFormKey,
                    child: Column(
                      spacing: 12,
                      children: [
                        InputFormField(customerController, "Customer Name",Icons.contact_page_outlined),
                        InputFormField(siteNameController, "Site Name" ,Icons.business_outlined),
                        InputFormField(locationController, "Location",Icons.location_on_outlined),
                      ],
                    ))
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            stepStyle: StepStyle(
                color: currentStep >= 1
                    ? currentStep > 1
                        ? Colors.green
                        : AppColors.mainColor
                    : Colors.grey),
            isActive: currentStep >= 1,
            title: CustomText(
                "Measurements", 12, FontWeight.bold, AppColors.mainColor),
            content: Column(
              spacing: 12,
              children: [
                Form(
                    key: measurementsFormKey,
                    child: Column(
                      spacing: 12,
                      children: [
                        NumberInput(
                            pumpCapacityController, "PumpCapacity (m³/h)"),
                        NumberInput(
                            pumpEfficiencyController, "PumpEfficiency (%)"),
                        NumberInput(liquidTemperatureController,
                            "LiquidTemperature (°C)"),
                        NumberInput(
                            electricPowerController, "ElectricalPower (KW)"),
                      ],
                    ))
              ],
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            stepStyle: StepStyle(
                color: currentStep >= 2
                    ? currentStep > 2
                        ? Colors.green
                        : AppColors.mainColor
                    : Colors.grey),
            isActive: currentStep >= 2,
            title: CustomText("Date", 12, FontWeight.bold, AppColors.mainColor),
            content: Column(
              spacing: 12,
              children: [
                Form(
                    key: dateFromKey,
                    child: Column(
                      spacing: 12,
                      children: [
                        DateSelectorWithInput(
                            dateOfVisitController, "Select DateOfVisit"),
                        DateSelectorWithInput(installationDateController,
                            "Select InstallationDate"),
                        DateSelectorWithInput(lastServiceDateController,
                            "Select LastServiceDate"),
                      ],
                    ))
              ],
            )),
      ];

  //validateAndProceed
  void validateAndProceed() {
    final formKeys = [personalFormKey, measurementsFormKey, dateFromKey];
    final bool isFormValidate =
        formKeys[currentStep].currentState?.validate() ?? false;
    if (isFormValidate) {
      if (!isLastStep()) {
        setState(() {
          currentStep += 1;
        });
      }
    }
  }

  //validateAndSubmit
  void validateAndSubmit() async {
    var data = await CurrentUser.get();
    print(data['managerId']);
    setState(() {
      isLoading = true;
    });
    final formKeys = [personalFormKey, measurementsFormKey, dateFromKey];
    bool isValid = true;
    for (var key in formKeys) {
      if (!key.currentState!.validate()) {
        isValid = false;
        break;
      }
    }

    if (isValid) {
      final reportData = <String, dynamic>{
        "managerId": data['managerId'],
        "officerId": data['userId'],
        "customerName": customerController.text,
        "siteName": siteNameController.text,
        "location": locationController.text,
        "pumpCapacity": pumpCapacityController.text,
        "pumpEfficiency": pumpEfficiencyController.text,
        "liquidTemperature": liquidTemperatureController.text,
        "electricalPower": electricPowerController.text,
        "dateOfVisit": dateOfVisitController.text,
        "installationDate": installationDateController.text,
        "lastServiceDate": lastServiceDateController.text,
        "submitReportDate": DateTime.now()
      };
      try {
        // print("Final Submission: All forms are valid! $reportData");
        var res = await FireBaseApi.insert(
            FireBaseConstant.reportCollection, reportData);
      } catch (err) {
        print(err);
      } finally {
        setState(() {
          isLoading = false;
          isComplete = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(

                spacing: 8,
                children: [
                  Icon(
                    Icons.insert_chart,
                    color: AppColors.mainColor,
                  ),
                  CustomText("Generate Report", 22, FontWeight.bold,
                      AppColors.mainColor),
                ],
              ),
              isComplete
                  ? SubmitReport()
                  : Expanded(
                      child: Theme(
                          data: ThemeData(
                            canvasColor: AppColors.lightBlue,
                          ),
                          child: Stepper(
                              elevation: 4,
                              type: StepperType.horizontal,
                              steps: steps(),
                              currentStep: currentStep,
                              onStepContinue: () {
                                if (isLastStep()) {
                                  setState(() => isComplete = true);
                                } else {
                                  setState(() => currentStep += 1);
                                }
                              },
                              onStepCancel: () {
                                if (isFirstStep()) {
                                } else {
                                  setState(() => currentStep -= 1);
                                }
                              },
                              controlsBuilder: (context, details) => Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        if (isFirstStep()) ...[
                                          Expanded(
                                              child: ElevatedButton(
                                                  onPressed: validateAndProceed,
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8))),
                                                  child: CustomText(
                                                      "Start",
                                                      14,
                                                      FontWeight.bold,
                                                      Colors.white))),
                                        ],
                                        if (!isLastStep() &&
                                            !isFirstStep()) ...[
                                          Expanded(
                                              child: ElevatedButton(
                                                  onPressed:
                                                      details.onStepCancel,
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              AppColors
                                                                  .mainColor)),
                                                  child: CustomText(
                                                      "Back",
                                                      14,
                                                      FontWeight.bold,
                                                      Colors.white))),
                                          Expanded(
                                              child: ElevatedButton(
                                                  onPressed: validateAndProceed,
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              AppColors
                                                                  .mainColor)),
                                                  child: CustomText(
                                                      "Next",
                                                      14,
                                                      FontWeight.bold,
                                                      Colors.white))),
                                        ],
                                        if (isLastStep() && !isLoading) ...[
                                        Expanded(
                                                  child: ElevatedButton(
                                                      onPressed:
                                                          details.onStepCancel,
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  AppColors
                                                                      .mainColor)),
                                                      child: CustomText(
                                                          "Back",
                                                          14,
                                                          FontWeight.bold,
                                                          Colors.white))),
                                          Expanded(
                                                  child: ElevatedButton(
                                                      onPressed:
                                                          validateAndSubmit,
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  AppColors
                                                                      .mainColor)),
                                                      child: CustomText(
                                                          "Submit",
                                                          14,
                                                          FontWeight.bold,
                                                          Colors.white))),
                                        ],

                                        if(isLoading) ...[
                                          Container(
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.37,top: 12),
                                            child:CircularProgressIndicator(color: AppColors.mainColor,) ,
                                          )
                                        ]
                                      ],
                                    ),
                                  )))),
            ],
          ),
        ),
      ),
    ));
  }
}

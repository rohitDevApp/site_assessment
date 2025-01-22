import 'package:flutter/material.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ReportDto.dart';

import 'SingleReport.dart';

class ManagerReports extends StatefulWidget {
  const ManagerReports({super.key});

  @override
  State<StatefulWidget> createState() => ManagerReportState();
}

//Manager Reports State
class ManagerReportState extends State<ManagerReports> {
  final List<ReportDto> arrReports = [
    ReportDto(
        customerName: 'Ronit Gupta',
        siteName: 'Industrial Site',
        location: 'Chicago, GPS Coordinates:',
        dateOfVisit: 'February 10, 2025',
        pumpCapacity: '120',
        pumpEfficiency: '80',
        liquidTemperature: '25',
        electricalPowerConsumption: '40',
        installationDate: 'June 2022',
        lastServiceDate: 'December 2024'),
    ReportDto(
        customerName: 'Ravi Kumar',
        siteName: 'Gurgaon Site',
        location: 'Gurgaon, Sector 32 , Tower A ',
        dateOfVisit: 'February 20, 2022',
        pumpCapacity: '230',
        pumpEfficiency: '60',
        liquidTemperature: '28',
        electricalPowerConsumption: '45',
        installationDate: 'May 2022',
        lastServiceDate: 'Nov 2024'),
    ReportDto(
        customerName: 'Aman Kumar',
        siteName: 'Gurgaon Site',
        location: 'Gurgaon, Sector 32 , Tower A ',
        dateOfVisit: 'February 20, 2022',
        pumpCapacity: '230',
        pumpEfficiency: '60',
        liquidTemperature: '28',
        electricalPowerConsumption: '45',
        installationDate: 'May 2022',
        lastServiceDate: 'Nov 2024'),
    ReportDto(
        customerName: 'Karan Kumar',
        siteName: 'Gurgaon Site',
        location: 'Gurgaon, Sector 32 , Tower A ',
        dateOfVisit: 'February 20, 2022',
        pumpCapacity: '230',
        pumpEfficiency: '60',
        liquidTemperature: '28',
        electricalPowerConsumption: '45',
        installationDate: 'May 2022',
        lastServiceDate: 'Nov 2024'),
    ReportDto(
        customerName: 'Vikram Kumar',
        siteName: 'Gurgaon Site',
        location: 'Gurgaon, Sector 32 , Tower A ',
        dateOfVisit: 'February 20, 2022',
        pumpCapacity: '230',
        pumpEfficiency: '60',
        liquidTemperature: '28',
        electricalPowerConsumption: '45',
        installationDate: 'May 2022',
        lastServiceDate: 'Nov 2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, index) {
        final report = arrReports[index];
        return SingleReport(report);
      },
      itemCount: arrReports.length,
    ));
  }
}

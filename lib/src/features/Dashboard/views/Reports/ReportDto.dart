class ReportDto {
  final String reportId;
  final String customerName;
  final String siteName;
  final String location;
  final String dateOfVisit;
  final String pumpCapacity;
  final String pumpEfficiency;
  final String liquidTemperature;
  final String electricalPowerConsumption;
  final String installationDate;
  final String lastServiceDate;
  final String submitReportDate;

  ReportDto({
    required this.reportId,
    required this.customerName,
    required this.siteName,
    required this.location,
    required this.dateOfVisit,
    required this.pumpCapacity,
    required this.pumpEfficiency,
    required this.liquidTemperature,
    required this.electricalPowerConsumption,
    required this.installationDate,
    required this.lastServiceDate,
    required this.submitReportDate,
  });


}

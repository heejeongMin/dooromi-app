class WorkInfo {
  int numberOfHeavyEquipment;
  int numberOfPartners;
  int workDaysOfTheMonth;
  double workPayOfTheMonth;
  int workDaysOfLastMonth;
  double workPayOfLastMonth;

  WorkInfo(
      this.numberOfHeavyEquipment,
      this.numberOfPartners,
      this.workDaysOfTheMonth,
      this.workPayOfTheMonth,
      this.workDaysOfLastMonth,
      this.workPayOfLastMonth);

  int get getNumberOfHeavyEquipment => numberOfHeavyEquipment;
  int get getNumberOfPartners => numberOfPartners;
  int get getWorkDaysOfTheMonth => workDaysOfTheMonth;
  double get getWorkPayOfTheMonth => workPayOfTheMonth;
  int get getWorkDaysOfLastMonth => workDaysOfLastMonth;
  double get getWorkPayOfLastMonth => workPayOfLastMonth;

  static WorkInfo fromJson(Map<String, dynamic> response) {
    return new WorkInfo(
        response['numberOfHeavyEquipment'],
        response['numberOfPartners'],
        response['workDaysOfTheMonth'],
        response['workPayOfTheMonth'],
        response['workDaysOfLastMonth'],
        response['workPayOfLastMonth']);
  }

}
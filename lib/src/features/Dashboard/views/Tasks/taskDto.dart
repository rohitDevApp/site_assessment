class TaskDto {
  final String taskId;
  final String taskName;
  final String taskStatus;
  final String taskAction;
  final String taskAssignOfficer;
  final DateTime taskDate;

  TaskDto(this.taskName, this.taskId, this.taskStatus, this.taskDate, this.taskAssignOfficer, this.taskAction);
}
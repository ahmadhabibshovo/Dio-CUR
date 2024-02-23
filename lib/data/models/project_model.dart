class Project {
  final int? id;
  final String startDate;
  final String endDate;
  final int? startDayOfYear;
  final int? endDayOfYear;
  final String projectName;
  final String projectUpdate;
  final String assignedEngineer;
  final String assignedTechnician;
  final int? duration;

  Project({
    this.id,
    required this.startDate,
    required this.endDate,
    this.startDayOfYear,
    this.endDayOfYear,
    required this.projectName,
    required this.projectUpdate,
    required this.assignedEngineer,
    required this.assignedTechnician,
    this.duration,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json['id'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        startDayOfYear: json['start_day_of_year'],
        endDayOfYear: json['end_day_of_year'],
        projectName: json['project_name'],
        projectUpdate: json['project_update'],
        assignedEngineer: json['assigned_engineer'],
        assignedTechnician: json['assigned_technician'],
        duration: json['duration'],
      );

  Map<String, dynamic> toJson() => {
        'start_date': startDate,
        'end_date': endDate,
        'project_name': projectName,
        'project_update': projectUpdate,
        'assigned_engineer': assignedEngineer,
        'assigned_technician': assignedTechnician,
      };
}

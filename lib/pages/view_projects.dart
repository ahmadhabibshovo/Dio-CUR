import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubetech/data/repository/repository.dart';

import '../data/models/project_model.dart';

class ViewProjects extends StatefulWidget {
  const ViewProjects({super.key});

  @override
  State<ViewProjects> createState() => _ViewProjectsState();
}

class _ViewProjectsState extends State<ViewProjects> {
  final projectNameController = TextEditingController();
  final projectStartDateController = TextEditingController();
  final projectEndDateController = TextEditingController();
  final projectAssignedEngineerController = TextEditingController();
  final projectAssignedTechnicianController = TextEditingController();
  final projectUpdateController = TextEditingController();
  clearAllTextField() {
    projectNameController.clear();
    projectStartDateController.clear();
    projectEndDateController.clear();
    projectAssignedEngineerController.clear();
    projectAssignedTechnicianController.clear();
    projectUpdateController.clear();
  }

  bool isLoaded = false;
  List<Project> projectList = [];
  Future getProjectList() async {
    final tempList = await Repository().getProjects();
    projectList = tempList.reversed.toList();
  }

  final boldStyle = const TextStyle(fontWeight: FontWeight.bold);
  @override
  void initState() {
    getProjectList().then((value) {
      setState(() {
        isLoaded = true;
      });
    });

    super.initState();
  }

  bool darkMode = Get.isDarkMode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              setState(() {
                darkMode = !darkMode;
              });
            },
            icon: Icon(darkMode ? Icons.dark_mode : Icons.sunny),
          ),
        ],
      ),
      body: isLoaded
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: projectList.map((project) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID : ${project.id} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Project Name : ${project.projectName} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Start Date : ${project.startDate} ',
                                style: boldStyle,
                              ),
                              Text(
                                'End Date : ${project.endDate} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Assigned Engineer : ${project.assignedEngineer} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Assigned Technician : ${project.assignedTechnician} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Project Update : ${project.projectUpdate} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Start Day of Year : ${project.startDayOfYear} ',
                                style: boldStyle,
                              ),
                              Text(
                                'End Day of Year : ${project.endDayOfYear} ',
                                style: boldStyle,
                              ),
                              Text(
                                'Duration : ${project.duration} ',
                                style: boldStyle,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                projectNameController.text =
                                    project.projectName;
                                projectStartDateController.text =
                                    project.startDate;
                                projectEndDateController.text = project.endDate;
                                projectAssignedEngineerController.text =
                                    project.assignedEngineer;
                                projectAssignedTechnicianController.text =
                                    project.assignedTechnician;
                                projectUpdateController.text =
                                    project.projectUpdate;

                                Get.defaultDialog(
                                  barrierDismissible: true,
                                  middleText: 'Project ID : ${project.id}',
                                  title: "Edit Project",
                                  textConfirm: "Confirm",
                                  textCancel: "Cancel",
                                  onCancel: () {
                                    clearAllTextField();
                                  },
                                  onConfirm: () async {
                                    Project _project = Project.fromJson({
                                      "project_name":
                                          projectNameController.text,
                                      "start_date":
                                          projectStartDateController.text,
                                      "end_date": projectEndDateController.text,
                                      "assigned_engineer":
                                          projectAssignedEngineerController
                                              .text,
                                      "assigned_technician":
                                          projectAssignedTechnicianController
                                              .text,
                                      "project_update":
                                          projectUpdateController.text,
                                    });
                                    List response = await Repository()
                                        .updateProject(_project, project.id!);
                                    if (response[1]) {
                                      Get.snackbar("Response", response[0],
                                          duration: const Duration(seconds: 2));
                                      clearAllTextField();
                                      await Future.delayed(
                                              const Duration(seconds: 3))
                                          .then((value) =>
                                              Get.offAll(const ViewProjects()));
                                    } else {
                                      Get.defaultDialog(
                                          title: "Error",
                                          middleText: response[0],
                                          textCancel: 'Close');
                                    }
                                  },
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: projectNameController,
                                        decoration: const InputDecoration(
                                            label: Text("Project Name")),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: projectStartDateController,
                                        decoration: const InputDecoration(
                                          label: Text("Start Date"),
                                          hintText: "YYYY-MM-DD",
                                        ),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: projectEndDateController,
                                        decoration: const InputDecoration(
                                          label: Text("End Date"),
                                          hintText: "YYYY-MM-DD",
                                        ),
                                      ),
                                      TextField(
                                        controller:
                                            projectAssignedEngineerController,
                                        decoration: const InputDecoration(
                                            label: Text("Assigned Engineer")),
                                      ),
                                      TextField(
                                        controller:
                                            projectAssignedTechnicianController,
                                        decoration: const InputDecoration(
                                            label: Text("Assigned Technician")),
                                      ),
                                      TextField(
                                        controller: projectUpdateController,
                                        decoration: const InputDecoration(
                                            label: Text("Update")),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          Get.defaultDialog(
            barrierDismissible: true,
            middleText: "",
            title: "Add Project",
            textConfirm: "Confirm",
            textCancel: "Cancel",
            onConfirm: () async {
              Project _project = Project.fromJson({
                "project_name": projectNameController.text,
                "start_date": projectStartDateController.text,
                "end_date": projectEndDateController.text,
                "assigned_engineer": projectAssignedEngineerController.text,
                "assigned_technician": projectAssignedTechnicianController.text,
                "project_update": projectUpdateController.text,
              });
              List response = await Repository().addProject(_project);
              if (response[1]) {
                Get.snackbar("Response", response[0],
                    duration: const Duration(seconds: 2));
                await Future.delayed(const Duration(seconds: 3))
                    .then((value) => Get.offAll(const ViewProjects()));
              } else {
                Get.defaultDialog(
                    title: "Error",
                    middleText: response[0],
                    textCancel: 'Close');
              }
            },
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: projectNameController,
                  decoration:
                      const InputDecoration(label: Text("Project Name")),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: projectStartDateController,
                  decoration: const InputDecoration(
                    label: Text("Start Date"),
                    hintText: "YYYY-MM-DD",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: projectEndDateController,
                  decoration: const InputDecoration(
                    label: Text("End Date"),
                    hintText: "YYYY-MM-DD",
                  ),
                ),
                TextField(
                  controller: projectAssignedEngineerController,
                  decoration:
                      const InputDecoration(label: Text("Assigned Engineer")),
                ),
                TextField(
                  controller: projectAssignedTechnicianController,
                  decoration:
                      const InputDecoration(label: Text("Assigned Technician")),
                ),
                TextField(
                  controller: projectUpdateController,
                  decoration: const InputDecoration(label: Text("Update")),
                ),
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}

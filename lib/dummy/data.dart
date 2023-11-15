import '../models/section.dart';
import '../models/form.dart';
import '../models/opened_form.dart';

class DummyData {
  static List<SmartShedSection> getSections() {
    return [
      SmartShedSection(id: 'section_id_1', name: 'Section 1'),
      SmartShedSection(id: 'section_id_2', name: 'Section 2'),
      SmartShedSection(id: 'section_id_3', name: 'Section 3'),
      SmartShedSection(id: 'section_id_4', name: 'Section 4'),
      SmartShedSection(id: 'section_id_5', name: 'Section 5'),
      SmartShedSection(id: 'section_id_6', name: 'Section 6'),
    ];
  }

  static List<SmartShedForm> getFormsForSection(String sectionId) {
    if (sectionId == 'section_id_1') {
      return [
        SmartShedForm(
            id: 'form_id_1', name: 'Form 1', description: 'Description 1'),
        SmartShedForm(
            id: 'form_id_2', name: 'Form 2', description: 'Description 2'),
        SmartShedForm(
            id: 'form_id_3', name: 'Form 3', description: 'Description 3'),
      ];
    } else if (sectionId == 'section_id_2') {
      return [
        SmartShedForm(
            id: 'form_id_4', name: 'Form 4', description: 'Description 3'),
        SmartShedForm(
            id: 'form_id_5', name: 'Form 5', description: 'Description 4'),
        SmartShedForm(
            id: 'form_id_6', name: 'Form 6', description: 'Description 5'),
      ];
    } else if (sectionId == 'section_id_3') {
      return [
        SmartShedForm(
            id: 'form_id_7', name: 'Form 7', description: 'Description 6'),
        SmartShedForm(
            id: 'form_id_8', name: 'Form 8', description: 'Description 7'),
        SmartShedForm(
            id: 'form_id_9', name: 'Form 9', description: 'Description 8'),
      ];
    } else if (sectionId == 'section_id_4') {
      return [
        SmartShedForm(
            id: 'form_id_10', name: 'Form 10', description: 'Description 9'),
        SmartShedForm(
            id: 'form_id_11', name: 'Form 11', description: 'Description 10'),
        SmartShedForm(
            id: 'form_id_12', name: 'Form 12', description: 'Description 11'),
      ];
    } else if (sectionId == 'section_id_5') {
      return [
        SmartShedForm(
            id: 'form_id_13', name: 'Form 13', description: 'Description 12'),
        SmartShedForm(
            id: 'form_id_14', name: 'Form 14', description: 'Description 13'),
        SmartShedForm(
            id: 'form_id_15', name: 'Form 15', description: 'Description 14'),
      ];
    } else if (sectionId == 'section_id_6') {
      return [
        SmartShedForm(
            id: 'form_id_16', name: 'Form 16', description: 'Description 15'),
        SmartShedForm(
            id: 'form_id_17', name: 'Form 17', description: 'Description 16'),
        SmartShedForm(
            id: 'form_id_18', name: 'Form 18', description: 'Description 17'),
      ];
    }
    return [];
  }

  // The Dashboard will show the recent forms of the worker.
  // The recent forms are the forms that are opened by the worker recently.
  // The worker can open a form by clicking on the form name in the
  // Recent Forms section in the Dashboard.
  static List<OpenedSmartShedForm> getRecentlyOpenedForms() {
    return [
      OpenedSmartShedForm(
        id: 'opened_form_id_1',
        name: 'Opened Form 1',
        description: 'Description 1',
        status: 'In Progress',
        formId: 'form_id_1',
        sectionId: 'section_id_1',
        createdAt: DateTime.parse('2021-10-01 10:00:00'),
      ),
      OpenedSmartShedForm(
        id: 'opened_form_id_2',
        name: 'Opened Form 2',
        description: 'Description 2',
        status: 'In Progress',
        formId: 'form_id_4',
        sectionId: 'section_id_2',
        createdAt: DateTime.parse('2021-10-02 10:00:00'),
      ),
      OpenedSmartShedForm(
        id: 'opened_form_id_3',
        name: 'Opened Form 3',
        description: 'Description 3',
        status: 'In Progress',
        formId: 'form_id_10',
        sectionId: 'section_id_4',
        createdAt: DateTime.parse('2021-10-03 10:00:00'),
      ),
      OpenedSmartShedForm(
        id: 'opened_form_id_4',
        name: 'Opened Form 4',
        description: 'Description 4',
        status: 'In Progress',
        formId: 'form_id_12',
        sectionId: 'section_id_4',
        createdAt: DateTime.parse('2021-10-04 10:00:00'),
      ),
      OpenedSmartShedForm(
        id: 'opened_form_id_5',
        name: 'Opened Form 5',
        description: 'Description 5',
        status: 'In Progress',
        formId: 'form_id_17',
        sectionId: 'section_id_6',
        createdAt: DateTime.parse('2021-10-05 10:00:00'),
      ),
    ];
  }

  // When worker clicks on a section in the Dashboard,
  // he will be redirected to Forms by Section page.
  // This page will show all the forms of that section.

  // This will also show the recent forms opened by the worker
  // in that section. The worker can open a form by clicking on
  // the form name in the Recent Forms section in the Forms by Section page.
  static List<OpenedSmartShedForm> getRecentlyOpenedFormsByMeForSection(
      String sectionId) {
    if (sectionId == 'section_id_1') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_1',
          name: 'Opened Form 1',
          description: 'Description 1',
          status: 'In Progress',
          formId: 'form_id_1',
          sectionId: 'section_id_1',
          createdAt: DateTime.parse('2021-10-01 10:00:00'),
        ),
      ];
    } else if (sectionId == 'section_id_2') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_2',
          name: 'Opened Form 2',
          description: 'Description 2',
          status: 'In Progress',
          formId: 'form_id_4',
          sectionId: 'section_id_2',
          createdAt: DateTime.parse('2021-10-02 10:00:00'),
        ),
      ];
    } else if (sectionId == 'section_id_3') {
      return [];
    } else if (sectionId == 'section_id_4') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_3',
          name: 'Opened Form 3',
          description: 'Description 3',
          status: 'In Progress',
          formId: 'form_id_10',
          sectionId: 'section_id_4',
          createdAt: DateTime.parse('2021-10-03 10:00:00'),
        ),
        OpenedSmartShedForm(
          id: 'opened_form_id_4',
          name: 'Opened Form 4',
          description: 'Description 4',
          status: 'In Progress',
          formId: 'form_id_12',
          sectionId: 'section_id_4',
          createdAt: DateTime.parse('2021-10-04 10:00:00'),
        ),
      ];
    } else if (sectionId == 'section_id_5') {
      return [];
    } else if (sectionId == 'section_id_6') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_5',
          name: 'Opened Form 5',
          description: 'Description 5',
          status: 'In Progress',
          formId: 'form_id_17',
          sectionId: 'section_id_6',
          createdAt: DateTime.parse('2021-10-05 10:00:00'),
        ),
      ];
    }
    return [];
  }

  // When worker clicks on a section in the Dashboard,
  // he will be redirected to Forms by Section page.
  // This page will show all the forms of that section and the
  // recent forms opened by the worker in that section.

  // But if worker wants to edit a form not opened by him,
  // he should also be able to see all the opened forms of
  // that section. The worker can open a form by clicking on
  // the form name in the Opened Forms section in the Forms by Section page.
  static List<OpenedSmartShedForm> getRecentlyOpenedFormsForSection(
      String sectionId) {
    if (sectionId == 'section_id_1') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_1',
          name: 'Opened Form 1',
          description: 'Description 1',
          status: 'In Progress',
          formId: 'form_id_1',
          sectionId: 'section_id_1',
          createdAt: DateTime.parse('2021-10-01 10:00:00'),
          createdBy: 'Worker 1',
        ),
      ];
    } else if (sectionId == 'section_id_2') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_2',
          name: 'Opened Form 2',
          description: 'Description 2',
          status: 'In Progress',
          formId: 'form_id_4',
          sectionId: 'section_id_2',
          createdAt: DateTime.parse('2021-10-02 10:00:00'),
          createdBy: 'Worker 2',
        ),
        OpenedSmartShedForm(
          id: 'opened_form_id_3',
          name: 'Opened Form 3',
          description: 'Description 3',
          status: 'In Progress',
          formId: 'form_id_10',
          sectionId: 'section_id_4',
          createdAt: DateTime.parse('2021-10-03 10:00:00'),
          createdBy: 'Worker 3',
        ),
      ];
    } else if (sectionId == 'section_id_3') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_4',
          name: 'Opened Form 4',
          description: 'Description 4',
          status: 'In Progress',
          formId: 'form_id_12',
          sectionId: 'section_id_4',
          createdAt: DateTime.parse('2021-10-04 10:00:00'),
          createdBy: 'Worker 4',
        ),
      ];
    } else if (sectionId == 'section_id_4') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_4',
          name: 'Opened Form 4',
          description: 'Description 4',
          status: 'In Progress',
          formId: 'form_id_12',
          sectionId: 'section_id_4',
          createdAt: DateTime.parse('2021-10-04 10:00:00'),
          createdBy: 'Worker 4',
        ),
      ];
    } else if (sectionId == 'section_id_5') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_5',
          name: 'Opened Form 5',
          description: 'Description 5',
          status: 'In Progress',
          formId: 'form_id_17',
          sectionId: 'section_id_6',
          createdAt: DateTime.parse('2021-10-05 10:00:00'),
          createdBy: 'Worker 5',
        ),
      ];
    } else if (sectionId == 'section_id_6') {
      return [
        OpenedSmartShedForm(
          id: 'opened_form_id_5',
          name: 'Opened Form 5',
          description: 'Description 5',
          status: 'In Progress',
          formId: 'form_id_17',
          sectionId: 'section_id_6',
          createdAt: DateTime.parse('2021-10-05 10:00:00'),
          createdBy: 'Worker 5',
        ),
      ];
    }
    return [];
  }
}

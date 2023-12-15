import '../../models/user.dart';
import '../../utils/api/employees.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class EmployeesController {
  static final EmployeesAPIHandler _employeesAPIHandler = EmployeesAPIHandler();
  static final _logger = LoggerService.getLogger('EmployeesController');

  static Future<void> init() async {
    _logger.info('Initializing PositionController');
  }

  static Future addEmployees(List<List<String>> emails) async {
    _logger.info('Adding employees');

    final response = await _employeesAPIHandler.addEmployees(emails);

    if (response['status'] == 'success') {
      _logger.info('Employees added successfully');
      ToastController.success(response['message']);
    } else {
      _logger.error('Error adding employees');
      ToastController.error(response['message']);
    }
  }

  static Future<Map<String, List<String>>> getEmployees() async {
    _logger.info('Getting employees');

    final response = await _employeesAPIHandler.getEmployees();

    if (response['status'] == 'success') {
      _logger.info('Employees retrieved successfully');

      // Convert List<dynamic> to List<String>
      List<String> authority = [];
      List<String> supervisor = [];
      List<String> worker = [];

      for (var email in response['employees']['authority']) {
        authority.add(email);
      }

      for (var email in response['employees']['supervisor']) {
        supervisor.add(email);
      }

      for (var email in response['employees']['worker']) {
        worker.add(email);
      }

      return {
        'authority': authority,
        'supervisor': supervisor,
        'worker': worker,
      };
    } else {
      _logger.error('Error getting employees');
      ToastController.error(response['message']);
      return {
        'authority': [],
        'supervisor': [],
        'worker': [],
      };
    }
  }

  static Future<Map<String, List<String>>> getEmployeesFromGoogleSheet() async {
    _logger.info('Getting employees from Google Sheet');

    final response = await _employeesAPIHandler.getEmployeesFromGoogleSheet();

    if (response['status'] == 'success') {
      _logger.info('Employees retrieved successfully');

      // Convert List<dynamic> to List<String>
      List<String> authority = [];
      List<String> supervisor = [];
      List<String> worker = [];

      for (var email in response['employees'][0].sublist(1)) {
        authority.add(email);
      }

      for (var email in response['employees'][1].sublist(1)) {
        supervisor.add(email);
      }

      for (var email in response['employees'][2].sublist(1)) {
        worker.add(email);
      }

      return {
        'authority': authority,
        'supervisor': supervisor,
        'worker': worker,
      };
    } else {
      _logger.error('Error getting employees');
      ToastController.error(response['message']);
      return {
        'authority': [],
        'supervisor': [],
        'worker': [],
      };
    }
  }

  static Future<Map<String, List<SmartShedUser>>> getUsers(
      {bool forSupervisor = false}) async {
    _logger.info('Getting users');

    final response = await _employeesAPIHandler.getUsers(
        position: forSupervisor ? 'worker' : null);

    if (response['status'] == 'success') {
      _logger.info('Users retrieved successfully');

      List<SmartShedUser> authority = [];
      List<SmartShedUser> supervisor = [];
      List<SmartShedUser> worker = [];

      for (var user in response['users']['authority']) {
        authority.add(SmartShedUser.fromJson({
          ...user,
          'position': 'authority',
        }));
      }

      for (var user in response['users']['supervisor']) {
        supervisor.add(SmartShedUser.fromJson({
          ...user,
          'position': 'supervisor',
        }));
      }

      for (var user in response['users']['worker']) {
        worker.add(SmartShedUser.fromJson({
          ...user,
          'position': 'worker',
        }));
      }

      return {
        'authority': authority,
        'supervisor': supervisor,
        'worker': worker,
      };
    } else {
      _logger.error('Error getting users');
      ToastController.error(response['message']);
      return {
        'authority': [],
        'supervisor': [],
        'worker': [],
      };
    }
  }

  static Future<Map<String, dynamic>> deleteUsers(List<String> userIds) async {
    _logger.info('Deleting users');

    final response = await _employeesAPIHandler.deleteUsers(userIds);

    if (response['status'] == 'success') {
      _logger.info('Users deleted successfully');
      ToastController.success(response['message']);
    } else {
      _logger.error('Error deleting users');
      ToastController.error(response['message']);
    }

    return response;
  }
}

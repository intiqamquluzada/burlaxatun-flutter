import 'package:dio/src/response.dart';

import '../contractor/select_task_contract.dart';
import '../services/remote/select_task_service.dart';

class SelectTaskRepo implements SelectTaskContract {
  SelectTaskRepo(this.selectTaskService);

  final SelectTaskService selectTaskService;

  @override
  Future<Response> declineTask({required int taskId}) {
    return selectTaskService.declineTask(taskId: taskId);
  }

  @override
  Future<Response> selectTask({required int taskId}) {
    return selectTaskService.selectTask(taskId: taskId);
  }
}

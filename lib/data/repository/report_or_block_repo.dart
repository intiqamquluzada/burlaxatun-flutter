import 'package:dio/src/response.dart';

import '../contractor/report_or_block_contract.dart';
import '../services/remote/report_or_block_service.dart';

class ReportOrBlockRepo implements ReportOrBlockContract {
  ReportOrBlockRepo(this.reportOrBlockService);

  final ReportOrBlockService reportOrBlockService;

  @override
  Future<Response> reportComment({required int commentId}) {
    return reportOrBlockService.reportComment(commentId: commentId);
  }

  @override
  Future<Response> blockUser({required int userId}) {
    return reportOrBlockService.blockUser(userId: userId);
  }
}

import '../../models/result/result_model.dart';

abstract class ResultDao {
  Future<List<Result>> submitTestResult(Result result);

  Future<List<Result>> getTestResults(String email);
}

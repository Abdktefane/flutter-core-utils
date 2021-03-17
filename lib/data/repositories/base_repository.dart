import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
/* 
abstract class BaseRepository {
  /// Check if the
  Either<Failure, T> checkResponse<T>(EitherFailureOr<T> body, String data);
}

class BaseRepositoryImpl extends BaseRepository {
  final DataConnectionChecker connectionChecker;
  final BaseRemoteDataSource baseRemoteDataSource;

  BaseRepositoryImpl({
    @required this.connectionChecker,
    @required this.baseRemoteDataSource,
  });

  // TODO(abd): change this into NETWORK RESULT
  @override
  Either<Failure, T> checkResponse<T>(EitherFailureOr<T> body, String data) {
    try {
      return body();
    } catch (e) {
      return Left(UnknownFailure(
        'msg_something_wrong',
        // json.decode(data)['message'],
      ));
    }
  }
} */

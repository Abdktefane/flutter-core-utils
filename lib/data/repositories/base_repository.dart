import 'package:core_sdk/data/datasource/base_remote_data_source.dart';

abstract class BaseRepository {
  const BaseRepository(this.baseRemoteDataSource);

  final BaseRemoteDataSource baseRemoteDataSource;
}

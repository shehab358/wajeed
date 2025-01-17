import 'package:injectable/injectable.dart';
import 'package:wajeed/features/home/data/data_source.dart/home_remote_data_source/home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeApiRemoteDataSource implements HomeRemoteDataSource {}

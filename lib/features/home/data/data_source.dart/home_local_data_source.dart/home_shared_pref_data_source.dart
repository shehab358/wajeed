import 'package:injectable/injectable.dart';
import 'package:wajeed/features/home/data/data_source.dart/home_local_data_source.dart/home_local_data_source.dart';

@LazySingleton(as: HomeLocalDataSource)
class HomeSharedPrefDataSource implements HomeLocalDataSource {}

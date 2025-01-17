// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:wajeed/core/di/register_module.dart' as _i85;
import 'package:wajeed/features/home/data/data_source.dart/home_local_data_source.dart/home_local_data_source.dart'
    as _i633;
import 'package:wajeed/features/home/data/data_source.dart/home_local_data_source.dart/home_shared_pref_data_source.dart'
    as _i812;
import 'package:wajeed/features/home/data/data_source.dart/home_remote_data_source/home_api_remote_data_source.dart'
    as _i232;
import 'package:wajeed/features/home/data/data_source.dart/home_remote_data_source/home_remote_data_source.dart'
    as _i1036;
import 'package:wajeed/features/home/data/repository/home_repository_impl.dart'
    as _i670;
import 'package:wajeed/features/home/domain/repository/home_repository.dart'
    as _i342;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.getSharedPref,
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i342.HomeRepository>(() => _i670.HomeRepositoryImpl());
    gh.lazySingleton<_i633.HomeLocalDataSource>(
        () => _i812.HomeSharedPrefDataSource());
    gh.lazySingleton<_i1036.HomeRemoteDataSource>(
        () => _i232.HomeApiRemoteDataSource());
    return this;
  }
}

class _$RegisterModule extends _i85.RegisterModule {}

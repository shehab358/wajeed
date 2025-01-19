// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:wajeed/core/di/register_module.dart' as _i85;
import 'package:wajeed/features/auth/data/data_source/local/auth_local_data_source.dart'
    as _i644;
import 'package:wajeed/features/auth/data/data_source/local/auth_shared_pref_data_source.dart'
    as _i925;
import 'package:wajeed/features/auth/data/data_source/remote/auth_firebase_remote_data_source.dart'
    as _i473;
import 'package:wajeed/features/auth/data/data_source/remote/auth_remote_data_source.dart'
    as _i464;
import 'package:wajeed/features/auth/data/repository/auth_repository_impl.dart'
    as _i274;
import 'package:wajeed/features/auth/domain/repository/auth_repositoy.dart'
    as _i306;
import 'package:wajeed/features/auth/domain/use_case.dart/login.dart' as _i383;
import 'package:wajeed/features/auth/domain/use_case.dart/logout.dart' as _i202;
import 'package:wajeed/features/auth/domain/use_case.dart/register.dart'
    as _i307;
import 'package:wajeed/features/auth/domain/use_case.dart/reset_password.dart'
    as _i824;
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
import 'package:wajeed/features/home/presentation/cubit/home_cubit.dart'
    as _i381;

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
    gh.lazySingleton<_i381.HomeCubit>(() => _i381.HomeCubit());
    gh.lazySingleton<_i342.HomeRepository>(() => _i670.HomeRepositoryImpl());
    gh.singleton<_i644.AuthLocalDataSource>(
        () => _i925.AuthSharedPrefDataSource(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i633.HomeLocalDataSource>(
        () => _i812.HomeSharedPrefDataSource());
    gh.lazySingleton<_i1036.HomeRemoteDataSource>(
        () => _i232.HomeApiRemoteDataSource());
    gh.singleton<_i464.AuthRemoteDataSource>(
        () => _i473.AuthFirebaseRemoteDataSource());
    gh.singleton<_i306.AuthRepository>(() => _i274.AuthRepositoryImpl(
          gh<_i464.AuthRemoteDataSource>(),
          gh<_i644.AuthLocalDataSource>(),
        ));
    gh.singleton<_i383.Login>(() => _i383.Login(gh<_i306.AuthRepository>()));
    gh.singleton<_i202.Logout>(() => _i202.Logout(gh<_i306.AuthRepository>()));
    gh.singleton<_i307.Register>(
        () => _i307.Register(gh<_i306.AuthRepository>()));
    gh.singleton<_i824.ResetPassword>(
        () => _i824.ResetPassword(gh<_i306.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i85.RegisterModule {}

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
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart'
    as _i11;
import 'package:wajeed/features/category/data/data_source/category_remote_data_soucre.dart'
    as _i786;
import 'package:wajeed/features/category/data/repository.dart/category_repository_impl.dart'
    as _i721;
import 'package:wajeed/features/category/domain/repository/category_repository.dart'
    as _i352;
import 'package:wajeed/features/category/domain/use_case/add_category.dart'
    as _i334;
import 'package:wajeed/features/category/domain/use_case/delete_category.dart'
    as _i710;
import 'package:wajeed/features/category/domain/use_case/fetch_categories.dart'
    as _i23;
import 'package:wajeed/features/category/presentation/cubit/category_cubit.dart'
    as _i774;
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
    gh.lazySingleton<_i786.CategoryRemoteDataSource>(
        () => _i786.CategoryFirebaseRemoteDataSource());
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
    gh.lazySingleton<_i352.CategoryRepository>(() =>
        _i721.CategoryRepositoryImpl(gh<_i786.CategoryRemoteDataSource>()));
    gh.singleton<_i383.Login>(() => _i383.Login(gh<_i306.AuthRepository>()));
    gh.singleton<_i202.Logout>(() => _i202.Logout(gh<_i306.AuthRepository>()));
    gh.singleton<_i307.Register>(
        () => _i307.Register(gh<_i306.AuthRepository>()));
    gh.singleton<_i824.ResetPassword>(
        () => _i824.ResetPassword(gh<_i306.AuthRepository>()));
    gh.lazySingleton<_i334.AddCategory>(
        () => _i334.AddCategory(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i710.DeleteCategory>(
        () => _i710.DeleteCategory(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i23.FetchCategories>(
        () => _i23.FetchCategories(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i774.CategoryCubit>(() => _i774.CategoryCubit(
          gh<_i334.AddCategory>(),
          gh<_i23.FetchCategories>(),
          gh<_i710.DeleteCategory>(),
        ));
    gh.singleton<_i11.AuthCubit>(() => _i11.AuthCubit(
          gh<_i307.Register>(),
          gh<_i383.Login>(),
          gh<_i202.Logout>(),
          gh<_i824.ResetPassword>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i85.RegisterModule {}

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
import 'package:wajeed/features/category/data/repository/category_repository_impl.dart'
    as _i356;
import 'package:wajeed/features/category/domain/repository/category_repository.dart'
    as _i352;
import 'package:wajeed/features/category/domain/use_case/add_category.dart'
    as _i334;
import 'package:wajeed/features/category/domain/use_case/delete_category.dart'
    as _i710;
import 'package:wajeed/features/category/domain/use_case/fetch_all_categories.dart'
    as _i315;
import 'package:wajeed/features/category/domain/use_case/fetch_user_categories.dart'
    as _i538;
import 'package:wajeed/features/category/presentation/cubit/add_category_cubit/add_category_cubit.dart'
    as _i884;
import 'package:wajeed/features/category/presentation/cubit/delete_category_c/delete_category_cubit.dart'
    as _i482;
import 'package:wajeed/features/category/presentation/cubit/fetch_all_categories_cubit/fetch_all_categories_cubit.dart'
    as _i187;
import 'package:wajeed/features/category/presentation/cubit/fetch_user_categories_cubit/fetch_user_categories_cubit.dart'
    as _i296;
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
import 'package:wajeed/features/home/presentation/cubit/basket_cubit.dart'
    as _i45;
import 'package:wajeed/features/orders/data/data_source/order_remote_data_source.dart'
    as _i125;
import 'package:wajeed/features/orders/data/repository/order_repository_impl.dart'
    as _i579;
import 'package:wajeed/features/orders/domain/repository/order_repository.dart'
    as _i332;
import 'package:wajeed/features/orders/domain/use_case/create_order.dart'
    as _i107;
import 'package:wajeed/features/orders/domain/use_case/fetch_user_orders.dart'
    as _i902;
import 'package:wajeed/features/orders/domain/use_case/fetch_user_store_orders.dart'
    as _i381;
import 'package:wajeed/features/orders/domain/use_case/update_order.dart'
    as _i540;
import 'package:wajeed/features/orders/presentation/cubit/create_oredr_cubit/create_order_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/cubit/update_order_cubit.dart'
    as _i426;
import 'package:wajeed/features/orders/presentation/cubit/fetch_store_orders_cubit/fetch_store_orders_cubit.dart'
    as _i399;
import 'package:wajeed/features/orders/presentation/cubit/fetch_user_orders_cubit/fetch_user_orders_cubit.dart'
    as _i74;
import 'package:wajeed/features/product/data/data_source/product_remote_data_source.dart'
    as _i587;
import 'package:wajeed/features/product/data/repository/product_repository_impl.dart'
    as _i11;
import 'package:wajeed/features/product/domain/repository/product_repository.dart'
    as _i94;
import 'package:wajeed/features/product/domain/use_case/add_product.dart'
    as _i714;
import 'package:wajeed/features/product/domain/use_case/delete_product.dart'
    as _i326;
import 'package:wajeed/features/product/domain/use_case/fetch_all_products.dart'
    as _i312;
import 'package:wajeed/features/product/domain/use_case/fetch_user_product.dart'
    as _i727;
import 'package:wajeed/features/product/presentation/cubit/add_product_cubit/add_product_cubit.dart'
    as _i484;
import 'package:wajeed/features/product/presentation/cubit/delete_product_cubit/delete_product_cubit.dart'
    as _i669;
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_cubit.dart'
    as _i477;
import 'package:wajeed/features/product/presentation/cubit/fetch_user_products_cubit/fetch_user_products_cubit.dart'
    as _i417;
import 'package:wajeed/features/store/data/data_source/store_remote_data_source.dart'
    as _i631;
import 'package:wajeed/features/store/data/repository/stores_repository_impl.dart'
    as _i67;
import 'package:wajeed/features/store/domain/repository/stores_repository.dart'
    as _i636;
import 'package:wajeed/features/store/domain/use_case/create_store.dart'
    as _i406;
import 'package:wajeed/features/store/domain/use_case/delete_store.dart'
    as _i21;
import 'package:wajeed/features/store/domain/use_case/get_all_stores.dart'
    as _i471;
import 'package:wajeed/features/store/domain/use_case/get_store.dart' as _i207;
import 'package:wajeed/features/store/domain/use_case/update_store.dart'
    as _i369;
import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_cubit.dart'
    as _i1047;
import 'package:wajeed/features/store/presentation/cubit/create_store_cubit/create_store_cubit.dart'
    as _i938;
import 'package:wajeed/features/store/presentation/cubit/delete_store_cubit/delete_store_cubit.dart'
    as _i968;
import 'package:wajeed/features/store/presentation/cubit/store_get_cubit/store_get_cubit.dart'
    as _i348;
import 'package:wajeed/features/store/presentation/cubit/update_store_cubit/update_store_cubit.dart'
    as _i202;

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
    gh.lazySingleton<_i45.BasketCubit>(() => _i45.BasketCubit());
    gh.lazySingleton<_i342.HomeRepository>(() => _i670.HomeRepositoryImpl());
    gh.singleton<_i644.AuthLocalDataSource>(
        () => _i925.AuthSharedPrefDataSource(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i786.CategoryRemoteDataSource>(
        () => _i786.CategoryFirebaseRemoteDataSource());
    gh.lazySingleton<_i587.ProductRemoteDataSource>(
        () => _i587.ProductFirebaseRemoteDataSource());
    gh.lazySingleton<_i631.StoreRemoteDataSource>(
        () => _i631.StoreFirebaseRemoteDataSource());
    gh.lazySingleton<_i352.CategoryRepository>(() =>
        _i356.CategoryRepositoryImpl(gh<_i786.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i633.HomeLocalDataSource>(
        () => _i812.HomeSharedPrefDataSource());
    gh.lazySingleton<_i1036.HomeRemoteDataSource>(
        () => _i232.HomeApiRemoteDataSource());
    gh.singleton<_i464.AuthRemoteDataSource>(
        () => _i473.AuthFirebaseRemoteDataSource());
    gh.lazySingleton<_i125.OrderRemoteDataSource>(
        () => _i125.OrderFirebaseRemoteDataSource());
    gh.lazySingleton<_i334.AddCategory>(
        () => _i334.AddCategory(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i710.DeleteCategory>(
        () => _i710.DeleteCategory(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i315.FetchAllCategories>(
        () => _i315.FetchAllCategories(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i538.FetchUserCategories>(
        () => _i538.FetchUserCategories(gh<_i352.CategoryRepository>()));
    gh.lazySingleton<_i884.AddCategoryCubit>(
        () => _i884.AddCategoryCubit(gh<_i334.AddCategory>()));
    gh.singleton<_i306.AuthRepository>(() => _i274.AuthRepositoryImpl(
          gh<_i464.AuthRemoteDataSource>(),
          gh<_i644.AuthLocalDataSource>(),
        ));
    gh.lazySingleton<_i332.OrderRepository>(
        () => _i579.OrderRepositoryImpl(gh<_i125.OrderRemoteDataSource>()));
    gh.lazySingleton<_i94.ProductRepository>(
        () => _i11.ProductRepositoryImpl(gh<_i587.ProductRemoteDataSource>()));
    gh.lazySingleton<_i636.StoreRepository>(
        () => _i67.StoresRepositoryImpl(gh<_i631.StoreRemoteDataSource>()));
    gh.lazySingleton<_i296.FetchUserCategoriesCubit>(
        () => _i296.FetchUserCategoriesCubit(gh<_i538.FetchUserCategories>()));
    gh.lazySingleton<_i187.FetchAllCategoriesCubit>(
        () => _i187.FetchAllCategoriesCubit(gh<_i315.FetchAllCategories>()));
    gh.lazySingleton<_i482.DeleteCategoryCubit>(
        () => _i482.DeleteCategoryCubit(gh<_i710.DeleteCategory>()));
    gh.singleton<_i383.Login>(() => _i383.Login(gh<_i306.AuthRepository>()));
    gh.singleton<_i202.Logout>(() => _i202.Logout(gh<_i306.AuthRepository>()));
    gh.singleton<_i307.Register>(
        () => _i307.Register(gh<_i306.AuthRepository>()));
    gh.singleton<_i824.ResetPassword>(
        () => _i824.ResetPassword(gh<_i306.AuthRepository>()));
    gh.lazySingleton<_i714.AddProduct>(
        () => _i714.AddProduct(gh<_i94.ProductRepository>()));
    gh.lazySingleton<_i326.DeleteProduct>(
        () => _i326.DeleteProduct(gh<_i94.ProductRepository>()));
    gh.lazySingleton<_i312.FetchAllProducts>(
        () => _i312.FetchAllProducts(gh<_i94.ProductRepository>()));
    gh.lazySingleton<_i727.FetchUserProducts>(
        () => _i727.FetchUserProducts(gh<_i94.ProductRepository>()));
    gh.lazySingleton<_i477.FetchAllProductsCubit>(
        () => _i477.FetchAllProductsCubit(gh<_i312.FetchAllProducts>()));
    gh.lazySingleton<_i381.FetchUserStoreOrders>(
        () => _i381.FetchUserStoreOrders(gh<_i332.OrderRepository>()));
    gh.lazySingleton<_i107.CreateOrder>(
        () => _i107.CreateOrder(gh<_i332.OrderRepository>()));
    gh.lazySingleton<_i902.FetchUserOrders>(
        () => _i902.FetchUserOrders(gh<_i332.OrderRepository>()));
    gh.lazySingleton<_i540.UpdateOrder>(
        () => _i540.UpdateOrder(gh<_i332.OrderRepository>()));
    gh.lazySingleton<_i399.FetchStoreOrdersCubit>(
        () => _i399.FetchStoreOrdersCubit(gh<_i381.FetchUserStoreOrders>()));
    gh.lazySingleton<_i669.DeleteProductCubit>(
        () => _i669.DeleteProductCubit(gh<_i326.DeleteProduct>()));
    gh.lazySingleton<_i484.AddProductCubit>(
        () => _i484.AddProductCubit(gh<_i714.AddProduct>()));
    gh.lazySingleton<_i406.CreateStore>(
        () => _i406.CreateStore(gh<_i636.StoreRepository>()));
    gh.lazySingleton<_i21.DeleteStore>(
        () => _i21.DeleteStore(gh<_i636.StoreRepository>()));
    gh.lazySingleton<_i471.GetAllStores>(
        () => _i471.GetAllStores(gh<_i636.StoreRepository>()));
    gh.lazySingleton<_i207.GetStore>(
        () => _i207.GetStore(gh<_i636.StoreRepository>()));
    gh.lazySingleton<_i369.UpdateStore>(
        () => _i369.UpdateStore(gh<_i636.StoreRepository>()));
    gh.lazySingleton<_i348.StoreGetCubit>(
        () => _i348.StoreGetCubit(gh<_i207.GetStore>()));
    gh.lazySingleton<_i417.FetchUserProductsCubit>(
        () => _i417.FetchUserProductsCubit(gh<_i727.FetchUserProducts>()));
    gh.singleton<_i11.AuthCubit>(() => _i11.AuthCubit(
          gh<_i307.Register>(),
          gh<_i383.Login>(),
          gh<_i202.Logout>(),
          gh<_i824.ResetPassword>(),
        ));
    gh.lazySingleton<CreateOrderCubit>(
        () => CreateOrderCubit(gh<_i107.CreateOrder>()));
    gh.lazySingleton<_i426.UpdateOrderCubit>(
        () => _i426.UpdateOrderCubit(gh<_i540.UpdateOrder>()));
    gh.lazySingleton<_i74.FetchUserOrdersCubit>(
        () => _i74.FetchUserOrdersCubit(gh<_i902.FetchUserOrders>()));
    gh.lazySingleton<_i938.CreateStoreCubit>(
        () => _i938.CreateStoreCubit(gh<_i406.CreateStore>()));
    gh.lazySingleton<_i1047.AllStoresGetCubit>(
        () => _i1047.AllStoresGetCubit(gh<_i471.GetAllStores>()));
    gh.lazySingleton<_i968.DeleteStoreCubit>(
        () => _i968.DeleteStoreCubit(gh<_i21.DeleteStore>()));
    gh.lazySingleton<_i202.UpdateStoreCubit>(
        () => _i202.UpdateStoreCubit(gh<_i369.UpdateStore>()));
    return this;
  }
}

class _$RegisterModule extends _i85.RegisterModule {}

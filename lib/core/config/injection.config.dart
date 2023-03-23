// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stg_frontend/core/network/client.dart' as _i4;
import 'package:stg_frontend/core/network/i_client.dart' as _i3;
import 'package:stg_frontend/domain/i_repositories/i_department_repository.dart'
    as _i11;
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart'
    as _i7;
import 'package:stg_frontend/external/remote_datasource/department_datasource.dart'
    as _i10;
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart'
    as _i6;
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart'
    as _i9;
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart'
    as _i5;
import 'package:stg_frontend/infra/repositories/department_repository.dart'
    as _i12;
import 'package:stg_frontend/infra/repositories/task_repository.dart' as _i8;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.IHttpClient>(_i4.HttpClient());
  gh.factory<_i5.ITaskDatasource>(
      () => _i6.TaskDatasource(gh<_i3.IHttpClient>()));
  gh.factory<_i7.ITaskRepository>(
      () => _i8.TaskRepository(gh<_i5.ITaskDatasource>()));
  gh.factory<_i9.IDepartmentDatasource>(
      () => _i10.DepartmentDatasource(gh<_i3.IHttpClient>()));
  gh.factory<_i11.IDepartmentRepository>(
      () => _i12.DepartmentRepository(gh<_i9.IDepartmentDatasource>()));
  return getIt;
}

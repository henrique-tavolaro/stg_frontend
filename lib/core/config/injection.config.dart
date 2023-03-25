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
    as _i17;
import 'package:stg_frontend/domain/i_repositories/i_task_repository.dart'
    as _i7;
import 'package:stg_frontend/domain/use_cases/department/create_department_use_case.dart'
    as _i20;
import 'package:stg_frontend/domain/use_cases/department/delete_department_use_case.dart.dart'
    as _i21;
import 'package:stg_frontend/domain/use_cases/department/fetch_department_use_case.dart'
    as _i22;
import 'package:stg_frontend/domain/use_cases/department/fetch_departments_use_case.dart'
    as _i23;
import 'package:stg_frontend/domain/use_cases/task/create_task_use_case.dart'
    as _i10;
import 'package:stg_frontend/domain/use_cases/task/delete_task_use_case.dart.dart'
    as _i11;
import 'package:stg_frontend/domain/use_cases/task/fetch_task_use_case.dart'
    as _i12;
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_by_department_use_case.dart'
    as _i13;
import 'package:stg_frontend/domain/use_cases/task/fetch_tasks_use_case.dart'
    as _i14;
import 'package:stg_frontend/domain/use_cases/task/update_task_use_case.dart'
    as _i9;
import 'package:stg_frontend/external/remote_datasource/department_datasource.dart'
    as _i16;
import 'package:stg_frontend/external/remote_datasource/task_datasource.dart'
    as _i6;
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart'
    as _i15;
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart'
    as _i5;
import 'package:stg_frontend/infra/repositories/department_repository.dart'
    as _i18;
import 'package:stg_frontend/infra/repositories/task_repository.dart' as _i8;
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart'
    as _i24;
import 'package:stg_frontend/presentation/cubit/task_details/task_details_cubit.dart'
    as _i19;

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
  gh.factory<_i9.UpdateTaskUseCase>(
      () => _i9.UpdateTaskUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i10.CreateTaskUseCase>(
      () => _i10.CreateTaskUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i11.DeleteTaskUseCase>(
      () => _i11.DeleteTaskUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i12.FetchTaskUseCase>(
      () => _i12.FetchTaskUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i13.FetchTasksByDepartmentUseCase>(
      () => _i13.FetchTasksByDepartmentUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i14.FetchTasksUseCase>(
      () => _i14.FetchTasksUseCase(gh<_i7.ITaskRepository>()));
  gh.factory<_i15.IDepartmentDatasource>(
      () => _i16.DepartmentDatasource(gh<_i3.IHttpClient>()));
  gh.factory<_i17.IDepartmentRepository>(
      () => _i18.DepartmentRepository(gh<_i15.IDepartmentDatasource>()));
  gh.singleton<_i19.TaskDetailsCubit>(_i19.TaskDetailsCubit(
    gh<_i12.FetchTaskUseCase>(),
    gh<_i11.DeleteTaskUseCase>(),
    gh<_i9.UpdateTaskUseCase>(),
  ));
  gh.factory<_i20.CreateDepartmentUseCase>(
      () => _i20.CreateDepartmentUseCase(gh<_i17.IDepartmentRepository>()));
  gh.factory<_i21.DeleteDepartmentUseCase>(
      () => _i21.DeleteDepartmentUseCase(gh<_i17.IDepartmentRepository>()));
  gh.factory<_i22.FetchDepartmentUseCase>(
      () => _i22.FetchDepartmentUseCase(gh<_i17.IDepartmentRepository>()));
  gh.factory<_i23.FetchDepartmentsUseCase>(
      () => _i23.FetchDepartmentsUseCase(gh<_i17.IDepartmentRepository>()));
  gh.singleton<_i24.DepartmentListCubit>(_i24.DepartmentListCubit(
    gh<_i23.FetchDepartmentsUseCase>(),
    gh<_i20.CreateDepartmentUseCase>(),
  ));
  return getIt;
}

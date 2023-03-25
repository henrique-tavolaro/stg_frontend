import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/home/widgets/alert_dialog.dart';
import 'package:stg_frontend/presentation/pages/home/widgets/department_list_tile.dart';
import 'package:stg_frontend/presentation/pages/home/widgets/empty_page.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DepartmentListCubit>()..fetchDepartments(),
      child: const DepartmentPageView(),
    );
  }
}

class DepartmentPageView extends StatefulWidget {
  const DepartmentPageView({Key? key}) : super(key: key);

  @override
  State<DepartmentPageView> createState() => _DepartmentPageViewState();
}

class _DepartmentPageViewState extends State<DepartmentPageView> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        body: BlocConsumer<DepartmentListCubit, DepartmentListState>(
          listener: (context, state) {
            switch (state.status) {
              case DepartmentListStatus.initial:
                () => {};
                break;
              case DepartmentListStatus.loading:
                () => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              CircularProgressIndicator(),
                              // indicador de carregamento
                              SizedBox(width: 10),
                              // espaço entre o indicador e o texto
                              Text("Carregando..."),
                            ],
                          ),
                        ),
                      )
                    };
                break;
              case DepartmentListStatus.loaded:
                () => {};
                break;
              case DepartmentListStatus.failure:
                () => {};
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case DepartmentListStatus.initial:
                return const EmptyPage();
              case DepartmentListStatus.loaded:
                if (state.departmentList.isEmpty) {
                  return const EmptyPage();
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.departmentList.length,
                      itemBuilder: (context, index) {
                        final item = state.departmentList[index];
                        return DepartmentListTile(
                          title: item.name,
                          index: index,
                          onClick: () async =>
                              context.go('/tasks_page', extra: item.name),
                        );
                      });
                }
              case DepartmentListStatus.failure:
                return const EmptyPage();
              case DepartmentListStatus.loading:
                return const EmptyPage();
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return MyAlertDialog(
                    controller: _textEditingController,
                    onClick: () {
                      final text = _textEditingController.text;

                      getIt<DepartmentListCubit>().createDepartmentUseCase(
                          props: CreateDepartmentProps(text));
                      Navigator.of(context).pop();
                      _textEditingController.clear();
                    },
                  );
                });
          },
          backgroundColor: AppColor.purple600,
          label: const Text(AppTexts.newArea),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stg_frontend/core/constants/app_texts.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/utils/snackbar.dart';
import 'package:stg_frontend/infra/i_remote_datasource/i_department_datasource.dart';
import 'package:stg_frontend/presentation/cubit/department_list/department_list_cubit.dart';
import 'package:stg_frontend/presentation/pages/widgets/alert_dialog_textfield.dart';
import 'package:stg_frontend/presentation/pages/home/widgets/department_list_tile.dart';
import 'package:stg_frontend/presentation/pages/home/widgets/empty_page.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/presentation/pages/widgets/custom_floating_action_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<DepartmentListCubit>()
        ..fetchDepartments(),
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
            state.maybeWhen(
                created: () => showSnackbar(context, AppTexts.areaCreated),
                failed: (_) => showSnackbar(context, AppTexts.internalError),
                orElse: () {});
          },
          builder: (context, state) {
            return state.maybeWhen(
                loaded: (departmentList) {
                  if (departmentList.isEmpty) {
                    return const EmptyPage();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: departmentList.length,
                      itemBuilder: (context, index) {
                        final item = departmentList[index];
                        return DepartmentListTile(
                          title: item.name,
                          index: index,
                          onClick: () async =>
                              context.push('/tasks_page', extra: item.name),
                        );
                      },
                    );
                  }
                },
                loading: () =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                orElse: () => const EmptyPage());
          },
        ),
        floatingActionButton: CustomFloatingActionButton(
          textEditingController: _textEditingController,
          onClick: () async {
            final text = _textEditingController.text;

            if (text.isNotEmpty) {
              getIt<DepartmentListCubit>().createDepartment(
                  props: CreateDepartmentProps(text));
              context.pop();
              _textEditingController.clear();
            }
          },
          dialogText: AppTexts.areaRegister,
          buttonText: AppTexts.newArea,),
      ),
    );
  }
}

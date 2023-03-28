import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stg_frontend/core/config/injection.dart';
import 'package:stg_frontend/core/design_system/app_colors.dart';
import 'package:stg_frontend/core/design_system/app_textstyle.dart';
import 'package:stg_frontend/infra/i_remote_datasource/I_task_datasource.dart';
import 'package:stg_frontend/infra/models/tree/tree_model.dart';
import 'package:stg_frontend/presentation/cubit/tree/tree_cubit.dart';

class TreePage extends StatefulWidget {
  final String department;

  const TreePage({Key? key, required this.department}) : super(key: key);

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  late TreeCubit cubit;

  @override
  void initState() {
    cubit = getIt<TreeCubit>()
      ..fetchTree(props: FetchTreeByDepartmentProps(widget.department));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.grey200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.department.toUpperCase()),
          centerTitle: true,
        ),
        body: BlocBuilder<TreeCubit, TreeState>(
            bloc: cubit,
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (treeList) => ListView(
                  children: [
                    for (final tree in treeList)
                      tree.treeList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: ExpansionTile(
                                backgroundColor: AppColor.grey400,
                                collapsedBackgroundColor: AppColor.grey400,
                                textColor: Colors.black,
                                iconColor: Colors.black,
                                title: Text(tree.name).h3(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                children: [
                                  for (final subTreeModel in tree.treeList)
                                    _buildTreeNode(
                                      treeModel: subTreeModel,
                                      index: 4,
                                      padding: 0,
                                    ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 2,
                              ),
                              child: ListTile(
                                tileColor: AppColor.grey400,
                                textColor: Colors.black,
                                title: Text(tree.name).h3(
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                  ],
                ),
                failed: (error) => Center(child: Text(error)),
              );
            }),
      ),
    );
  }

  Widget _buildTreeNode(
      {required TreeModel treeModel,
      required double padding,
      required int index}) {
    padding += 16;
    index -= 1;

    return treeModel.treeList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ExpansionTile(
              backgroundColor: colorList[index - 1 < 0 ? 0 : index - 1],
              collapsedBackgroundColor: colorList[index < 0 ? 0 : index],
              iconColor: Colors.black,
              textColor: Colors.black,
              title: Padding(
                padding: EdgeInsets.only(left: padding),
                child: Text(treeModel.name),
              ),
              children: [
                for (final subTreeModel in treeModel.treeList)
                  _buildTreeNode(
                    treeModel: subTreeModel,
                    padding: padding,
                    index: index,
                  ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              tileColor: colorList[index < 0 ? 0 : index],
              textColor: Colors.black,
              title: Padding(
                padding: EdgeInsets.only(left: padding),
                child: Text(treeModel.name),
              ),
            ),
          );
  }

  List<Color> colorList = [
    AppColor.treeColor1,
    AppColor.treeColor2,
    AppColor.treeColor3,
    AppColor.treeColor4
  ];
}

class CustomExpansionTile extends StatelessWidget {
  final Widget title;
  final Color backgroundColor;
  final Color colapsedBackgroundColor;
  final Widget function;


  const CustomExpansionTile({Key? key, required this.title, required this.backgroundColor, required this.colapsedBackgroundColor, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: title,
      backgroundColor: backgroundColor,
      collapsedTextColor: colapsedBackgroundColor,
      textColor: Colors.black,
      iconColor: Colors.black,
      children: [
        function
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Navigator.of(context).pop();
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
                          ? ExpansionTile(
                              backgroundColor: AppColor.grey400,
                              collapsedBackgroundColor: AppColor.grey400,
                              textColor: Colors.black,
                              shape: const Border(
                                  bottom: BorderSide(
                                      color: AppColor.grey900, width: 0.5)),
                              title: Text(tree.name).h3(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              children: [
                                for (final subTreeModel in tree.treeList)
                                  _buildTreeNode(subTreeModel, 0, 36, 4),
                              ],
                            )
                          : ListTile(
                              tileColor: AppColor.grey400,
                              textColor: Colors.black,
                              shape: const Border(
                                  bottom: BorderSide(
                                      color: AppColor.grey900, width: 0.5)),
                              title: Text(tree.name).h3(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
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
      TreeModel treeModel, double padding, double elevation, int index) {
    padding += 8;
    elevation -= 4;
    index -= 1;

    return treeModel.treeList.isNotEmpty
        ? ExpansionTile(
            backgroundColor: colorList[index],
            collapsedBackgroundColor: colorList[index],
            textColor: Colors.black,
            shape: const Border(
                bottom: BorderSide(color: AppColor.grey900, width: 0.5)),
            title: Padding(
              padding: EdgeInsets.only(left: padding),
              child: Text(treeModel.name),
            ),
            children: [
              for (final subTreeModel in treeModel.treeList)
                _buildTreeNode(
                    subTreeModel, padding, elevation, index < 0 ? 0 : index),
            ],
          )
        : ListTile(
            tileColor: AppColor.grey400,
            textColor: Colors.black,
            shape: const Border(
              bottom: BorderSide(color: AppColor.grey900, width: 0.5),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: padding),
              child: Text(treeModel.name),
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

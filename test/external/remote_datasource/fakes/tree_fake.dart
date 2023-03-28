import 'package:stg_frontend/infra/models/tree/tree_model.dart';

final treeFake = [{
  "id": "tree_entity_1",
  "name": "Tree Entity 1",
  "treeList": [
    {
      "id": "sub_tree_1",
      "name": "Sub Tree 1",
      "treeList": []
    },
    {
      "id": "sub_tree_2",
      "name": "Sub Tree 2",
      "treeList": [
        {
          "id": "sub_tree_2_1",
          "name": "Sub Tree 2.1",
          "treeList": []
        }
      ]
    }
  ]
}];

final treeListFake = treeFake.map<TreeModel>((i) {
  final item = TreeModel.fromJson(i);
  return item;
}).toList();

import 'base_select_entity.dart';

class SelectEntity implements BaseSelectEntity {
  @override
  bool isSelection;
  @override
  String title;

  SelectEntity(this.title,{this.isSelection});
}

import 'package:flutter_app/model/singer/singer_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SingerListEntity") {
      return SingerListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
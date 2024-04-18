import 'package:flutter_application_1/objectbox.g.dart';

abstract class Repository<T> {
  late final Box<T> box;

  Stream<List<T>> getAllEntitiesInStream() =>
      box.query().watch(triggerImmediately: true).map((query) => query.find());

  T? getEntity(int id) => box.get(id);

  int insertEntity(T entity) => box.put(entity);

  bool removeEntity(int id) => box.remove(id);

  int updateEntity(T entity) {
    return box.put(entity);
  }
}

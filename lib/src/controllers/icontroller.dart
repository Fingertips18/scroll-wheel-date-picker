abstract interface class IController<T> {
  IController copyWith();
  int get selectedIndex;
  List<String> get items;
}

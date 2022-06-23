import 'package:flutter/foundation.dart';

@immutable
class Genre {
  final String name;
  final bool isSelected;
  final int id;

  const Genre({required this.name, this.isSelected = false, this.id = 0});

  Genre toggleSelected() {
    return Genre(
      name: name,
      isSelected: !isSelected,
      id: id,
    );
  }

  @override
  String toString() {
    return 'Genre{name: $name, isSelected: $isSelected, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Genre && name == other.name && isSelected == other.isSelected && id == other.id;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode ^ id.hashCode;


}
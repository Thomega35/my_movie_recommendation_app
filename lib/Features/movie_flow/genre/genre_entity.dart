import 'package:flutter/material.dart';

@immutable
class GenreEntity {
  final int id;
  final String name;

  const GenreEntity({
    required this.id,
    required this.name,
  });

  factory GenreEntity.fromMap(Map<String, dynamic> json) {
    return GenreEntity(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  String toString() => 'GenreEntity { id: $id, name: $name }';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenreEntity && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

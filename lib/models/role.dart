import 'package:equatable/equatable.dart';

class Role extends Equatable{
  final int id;
  final String name;

  Role({this.id, this.name});

  List<Object>get props=>[id,name];
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"],
      name: json["name"],
    );
  }
  @override
  String toString() {
    return 'Role{id:$id,name:$name}';
  }
}
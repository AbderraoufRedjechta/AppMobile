import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish {
  final int id;
  final String name;
  final String description;
  final int price;
  final int stock;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);
}

import 'package:equatable/equatable.dart';

class WeatherInfo extends Equatable {
  const WeatherInfo({
    this.id,
    this.status,
    this.description,
    this.icon,
  });

  final int? id;
  final String? status;
  final String? description;
  final String? icon;

  @override
  List<Object?> get props => [
        id,
        status,
        description,
        icon,
      ];
}

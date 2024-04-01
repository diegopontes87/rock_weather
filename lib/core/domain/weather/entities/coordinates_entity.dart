import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates({
    this.longitude,
    this.latitude,
  });

  final double? longitude;
  final double? latitude;

  @override
  List<Object?> get props => [
        longitude,
        latitude,
      ];
}

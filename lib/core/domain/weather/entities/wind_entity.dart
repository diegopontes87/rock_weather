import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  const Wind({
    this.speed,
    this.gust,
    this.windDirectionDegrees,
  });

  final double? speed;
  final double? gust;
  final int? windDirectionDegrees;

  @override
  List<Object?> get props => [
        speed,
        gust,
        windDirectionDegrees,
      ];
}

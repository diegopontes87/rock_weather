import 'package:equatable/equatable.dart';

class Rain extends Equatable {
  const Rain({
    this.rainVolumeLastHour,
  });

  final double? rainVolumeLastHour;

  @override
  List<Object?> get props => [
        rainVolumeLastHour,
      ];
}

import 'package:equatable/equatable.dart';

class Clouds extends Equatable {
  const Clouds({
    this.cloudinessPercentage,
  });
  final int? cloudinessPercentage;

  @override
  List<Object?> get props => [
        cloudinessPercentage,
      ];
}

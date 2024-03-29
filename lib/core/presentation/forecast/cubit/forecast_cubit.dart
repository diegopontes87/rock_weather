import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_state.dart';
part 'forecast_cubit.freezed.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastState.initial());
}

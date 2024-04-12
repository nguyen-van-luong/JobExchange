part of 'cu_cv_bloc.dart';

@immutable
sealed class CUCVState extends Equatable {
  const CUCVState();

  @override
  List<Object?> get props => [];
}

final class CUCVInitialState extends CUCVState {}

class LoadFailure extends CUCVState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}

class CuCVStateData extends CUCVState {
  final CVDto? cv;
  final List<Province> provinces;
  final List<Industry> industries;
  List<Specialization> specializations;

  CuCVStateData({required this.cv, required this.provinces, required this.industries, required this.specializations});

  @override
  List<Object?> get props => [cv, provinces, industries, specializations];
}

class SaveSuccess extends CUCVState {

  SaveSuccess();
}

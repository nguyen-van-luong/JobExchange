part of 'cu_job_bloc.dart';

@immutable
sealed class CUJobState extends Equatable {
  const CUJobState();

  @override
  List<Object?> get props => [];
}

final class CUJobInitialState extends CUJobState {}

class PostFailure extends CUJobState {
  final String message;
  final NotifyType notifyType;

  PostFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}

class CuJobStateData extends CUJobState {
  final JobDto? job;
  final List<Province> provinces;
  final List<Industry> industries;

  CuJobStateData({required this.job, required this.provinces, required this.industries});

  @override
  List<Object?> get props => [job, provinces, industries];
}

class SaveSuccess extends CUJobState {

  SaveSuccess();
}

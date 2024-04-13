part of 'job_detail_bloc.dart';

@immutable
sealed class JobDetailState extends Equatable {
  const JobDetailState();

  @override
  List<Object?> get props => [];
}

final class JobInitialState extends JobDetailState {}

class LoadSuccess extends JobDetailState {
  final Job job;

  LoadSuccess({required this.job});

  @override
  List<Object?> get props => [job];
}

class LoadFailure extends JobDetailState {
  final String message;
  final NotifyType notifyType;

  LoadFailure({required this.message, required this.notifyType});

  @override
  List<Object?> get props => [message, notifyType];
}
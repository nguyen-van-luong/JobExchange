part of 'cu_job_bloc.dart';

@immutable
sealed class CUJobEvent extends Equatable {
  const CUJobEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CUJobEvent {

  const LoadEvent();
}

class SaveEvent extends CUJobEvent {
  final JobDto job;
  const SaveEvent({required this.job});
}
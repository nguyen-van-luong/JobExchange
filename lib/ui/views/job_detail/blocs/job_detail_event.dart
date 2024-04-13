part of 'job_detail_bloc.dart';

@immutable
sealed class JobDetailEvent extends Equatable {
  const JobDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends JobDetailEvent {
  final String id;

  const LoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
part of 'cu_cv_bloc.dart';

@immutable
sealed class CUCVEvent extends Equatable {
  const CUCVEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends CUCVEvent {

  const LoadEvent();
}

class SaveEvent extends CUCVEvent {
  final CVDto cv;
  const SaveEvent({required this.cv});

  @override
  List<Object?> get props => [cv];
}
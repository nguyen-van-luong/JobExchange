part of 'job_bloc.dart';

@immutable
sealed class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends JobEvent {
  final String searchContent;
  final String? industry;
  final String? province;
  final String page;

  const LoadEvent({required this.searchContent,
    required this.industry,
    required this.province,
    required this.page});

  @override
  List<Object?> get props => [searchContent, industry, province, page];
}
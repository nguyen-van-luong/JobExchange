import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dtos/notify_type.dart';
import '../../../../models/job.dart';
import '../../../../repositories/job_repository.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final JobRepository _jobRepository = JobRepository();

  JobDetailBloc() : super(JobInitialState()) {
    on<LoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<JobDetailState> emit) async {
    try {
      Response<dynamic> response = await _jobRepository.getById(id: event.id);

      Job job = Job.fromJson(response.data);
      emit(LoadSuccess(job: job));
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}
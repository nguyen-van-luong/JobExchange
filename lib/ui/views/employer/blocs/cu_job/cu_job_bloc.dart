import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_exchange/dtos/job_dto.dart';
import 'package:job_exchange/models/province.dart';
import 'package:job_exchange/repositories/industry_repository.dart';
import 'package:job_exchange/repositories/province_repository.dart';

import '../../../../../dtos/notify_type.dart';
import '../../../../../models/industry.dart';
import '../../../../../repositories/job_repository.dart';
import '../../../../../repositories/specialization_repository.dart';
import '../../../../common/utils/message_from_exception.dart';

part 'cu_job_event.dart';
part 'cu_job_state.dart';

class CUJobBloc extends Bloc<CUJobEvent, CUJobState> {
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  SpecializationRepository specializationRepository = SpecializationRepository();
  JobRepository jobRepository = JobRepository();

  CUJobBloc() : super(CUJobInitialState()) {
    on<LoadEvent>(_onLoad);
    on<SaveEvent>(_onSave);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CUJobState> emit) async {
    JobDto? job = null;
    Response<dynamic> response = await industryRepository.getAll();

    List<Industry> industries = response.data == null ? [] : response.data.map<Industry>((e) => Industry.fromJson(e as Map<String, dynamic>)).toList();

    response = await provinceRepository.getAll();
    List<Province> provinces = response.data == null ? [] : response.data.map<Province>((e) => Province.fromJson(e as Map<String, dynamic>)).toList();

    emit(CuJobStateData(job: job, industries: industries, provinces: provinces));
  }

  Future<void> _onSave(
      SaveEvent event, Emitter<CUJobState> emit) async {
    try {
      var future = jobRepository.save(event.job);

      await future.then((response) {
        emit(SaveSuccess());
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(PostFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(PostFailure(message: message, notifyType: NotifyType.error));
    }
  }
}
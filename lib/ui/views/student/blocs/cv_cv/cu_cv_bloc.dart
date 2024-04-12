import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_exchange/models/specialization.dart';

import '../../../../../dtos/cv_dto.dart';
import '../../../../../dtos/notify_type.dart';
import '../../../../../models/industry.dart';
import '../../../../../models/province.dart';
import '../../../../../repositories/cv_repository.dart';
import '../../../../../repositories/industry_repository.dart';
import '../../../../../repositories/province_repository.dart';
import '../../../../../repositories/specialization_repository.dart';
import '../../../../common/utils/message_from_exception.dart';

part 'cu_cv_event.dart';
part 'cu_cv_state.dart';

class CUCVBloc extends Bloc<CUCVEvent, CUCVState> {
  IndustryRepository industryRepository = IndustryRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  SpecializationRepository specializationRepository = SpecializationRepository();
  CVRepository cvRepository = CVRepository();

  CUCVBloc() : super(CUCVInitialState()) {
    on<LoadEvent>(_onLoad);
    on<SaveEvent>(_onSave);
  }

  Future<void> _onLoad(
      LoadEvent event, Emitter<CUCVState> emit) async {
    CVDto? cv = null;
    Response<dynamic> response = await industryRepository.getAll();

    List<Industry> industries = response.data == null ? [] : response.data.map<Industry>((e) => Industry.fromJson(e as Map<String, dynamic>)).toList();

    response = await provinceRepository.getAll();
    List<Province> provinces = response.data == null ? [] : response.data.map<Province>((e) => Province.fromJson(e as Map<String, dynamic>)).toList();
    List<Specialization> specializations = [];
    emit(CuCVStateData(cv: cv, industries: industries, provinces: provinces, specializations: specializations));
  }

  Future<void> _onSave(
      SaveEvent event, Emitter<CUCVState> emit) async {
    try {
      var future = cvRepository.save(event.cv);

      await future.then((response) {
        emit(SaveSuccess());
      }).catchError((error) {
        String message = getMessageFromException(error);
        emit(LoadFailure(message: message, notifyType: NotifyType.error));
      });
    } catch (error) {
      String message = "Có lỗi xảy ra. Vui lòng thử lại sau!";
      emit(LoadFailure(message: message, notifyType: NotifyType.error));
    }
  }
}
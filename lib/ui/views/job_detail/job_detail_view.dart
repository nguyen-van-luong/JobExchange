import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:job_exchange/models/job.dart';
import 'package:job_exchange/models/specialization.dart';
import 'package:job_exchange/ui/views/job_detail/blocs/job_detail_bloc.dart';
import 'package:job_exchange/ui/views/job_detail/widgets/menu_action.dart';

import '../../common/utils/date_time.dart';
import '../../widgets/notification.dart';
import '../../widgets/user_avatar.dart';

class JobDetailView extends StatefulWidget {
  const JobDetailView({super.key, required this.id});
  final String? id;

  @override
  State<JobDetailView> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetailView> {

  late JobDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = JobDetailBloc()
      ..add(LoadEvent(id: widget.id!));
  }

  @override
  void didUpdateWidget(JobDetailView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(id: widget.id!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<JobDetailBloc, JobDetailState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          }
        },
        child: BlocBuilder<JobDetailBloc, JobDetailState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1280),
                  child: Container(
                    width: 1280,
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Column(
                      children: [
                        header(state.job),
                        body(state.job)
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is LoadFailure) {
              return Container(
                alignment: Alignment.center,
                child:
                Text(state.message, style: const TextStyle(fontSize: 16)),
              );
            }

            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          },
        )
      )
    );
  }

  Widget header(Job job) {
    return Container(
      padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  child: InkWell(
                    onTap: () => null,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: UserAvatar(
                          imageUrl: job.employer!.avatarUrl,
                          size: 124,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => null,
                            child: Text(
                              job.employer.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.indigo[700]),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            getTimeAgo(job.updatedAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 2, bottom: 4),
                        child: Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 4),
                        child: Row(
                          children: [
                            for(var address in job.addresses)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  address.province.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2, bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_sharp,
                              size: 20,
                              color: Colors.grey[700],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              child: Text("Hạn nộp hồ sơ:",
                                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            ),
                            Text(DateFormat('dd/MM/yyyy').format(job.duration),
                                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 2, bottom: 4),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 0, 86, 143),  // This is the button color
                          ),
                          onPressed: () {  },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Nộp hồ sơ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24
                              ),)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  Tooltip(
                    message: "Hiển thị các hành động",
                    child: MenuAction(id: job.id),
                  ),
                  SizedBox(height: 4,),
                  Tooltip(
                    message: "Bookmark",
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark, // Mã Unicode của biểu tượng con mắt
                          color: Color.fromARGB(255, 212, 211, 211),
                          // Màu của biểu tượng,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

  Widget body(Job job) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textHeader("Thông tin chung"),
                  Wrap(
                    children: [
                      commonItem(Icons.timer_sharp, "Hạn nộp hồ sơ", DateFormat('dd/MM/yyyy').format(job.duration)),
                      buildAge(job.ageFrom, job.ageTo),
                      commonItem(Icons.work_outline, "Kinh nghiệm", job.experience),
                      commonItem(Icons.attach_money, "Mức lương", "${job.salaryFrom} - ${job.salaryTo} triệu"),
                      buildSex(job.sex),
                      job.degree != null ?commonItem(Icons.school_outlined, "Bằng cấp", job.degree!):Container(),
                      job.quantity != null ? commonItem(Icons.group_outlined, "Số lượng tuyển", "${job.quantity}"):Container(),
                      commonItem(Icons.business_outlined, "Hình thức làm việc", job.workingForm),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textHeader("Ngành nghề"),
                  Wrap(
                    children: [
                      for(var industrySpecialization in job.industrySpecializations)
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            builIndustry(industrySpecialization.industry.name, industrySpecialization.specialization),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Đại chỉ"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(var address in job.addresses)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              "${address.province.name}: ${address.address}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Mô tả"),
                    Text(job.description, style: TextStyle(fontSize: 16),)
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textHeader("Yêu cầu"),
                    Text(job.requirement, style: TextStyle(fontSize: 16))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  String builIndustry(String industry, Specialization? specialization) {
    String result = industry;
    if(specialization != null)
      result += " - ${specialization.name}";
    return result;
  }

  Widget textHeader(String lable) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Text(lable,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
    );
  }

  Widget buildAge(int? ageFrom, int? ageTo) {
    String text = "";
    if(ageFrom == null && ageTo == null)
      return Container();
    if(ageFrom != null && ageTo == null)
      text = "Từ $ageFrom tuổi trở lên";
    else if(ageFrom == null)
      text = "Dưới $ageTo tuổi";
    else
      text = "Từ $ageFrom đến $ageTo tuổi";
    return commonItem(Icons.cake_outlined, "Độ tuổi", text);
  }

  Widget buildSex(bool? sex) {
    if(sex == null)
      return Container();
    if(sex)
      return commonItem(Icons.male_outlined, "Giới tính", "Nam");
    return commonItem(Icons.female_outlined, "Giới tính", "Nữ");
  }

  Widget commonItem(IconData icon, String lable, String value) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.blueAccent
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lable,
                style: TextStyle(color: Colors.grey[700],),
              ),
              Text(value,
                style: TextStyle(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}

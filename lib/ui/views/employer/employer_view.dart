import 'package:flutter/cupertino.dart';
import 'package:job_exchange/ui/views/employer/widget/cu_job/cu_job_view.dart';
import 'package:job_exchange/ui/views/employer/widget/left_menu.dart';

import '../../common/utils/navigation.dart';

class EmployerView extends StatefulWidget {
  const EmployerView({super.key, this.indexSelected = 0, required this.params});

  final Map<String, String> params;
  final int indexSelected;

  @override
  _EmployerViewState createState() => _EmployerViewState();
}

class _EmployerViewState extends State<EmployerView> {
  late List<Navigation> listNavigation;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listNavigation = getNavigation;
    listNavigation[widget.indexSelected].isSelected = true;
    return Container(
      color: Color.fromARGB(255, 238, 238, 238),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: LeftMenu(listSelectBtn: listNavigation),
          ),
          Expanded(
            child: listNavigation[widget.indexSelected].widget,
          ),
        ],
      ),
    );
  }

  List<Navigation> get getNavigation => [
    Navigation(
      index: 0,
      text: "Tài khoản",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 1,
      text: "Tạo bài vết",
      path: "/",
      widget: CUJobView(),
    ),
    Navigation(
      index: 2,
      text: "Quản lý bài vết",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 3,
      text: "Hồ sơ ứng tuyển",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 4,
      text: "Tìm kiếm ứng viên",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 5,
      text: "Thông báo",
      path: "/",
      widget: Container(),
    ),
  ];
}
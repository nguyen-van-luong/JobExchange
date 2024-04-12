
import 'package:flutter/cupertino.dart';
import 'package:job_exchange/ui/views/student/widget/cu_cv/cu_cv_view.dart';

import '../../common/utils/navigation.dart';
import '../employer/widget/left_menu.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key, this.indexSelected = 0, required this.params});

  final Map<String, String> params;
  final int indexSelected;

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
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
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LeftMenu(listSelectBtn: listNavigation),
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
      text: "Hồ sơ",
      path: "/student/cv",
      widget: CUCVView(),
    ),
    Navigation(
      index: 2,
      text: "Bài đăng quan tâm",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 3,
      text: "Theo dõi",
      path: "/",
      widget: Container(),
    ),
    Navigation(
      index: 4,
      text: "Thông báo",
      path: "/",
      widget: Container(),
    ),
  ];
}
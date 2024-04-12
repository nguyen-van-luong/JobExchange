import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_exchange/ui/views/CV/blocs/cv_bloc.dart';

import '../../../models/cv.dart';
import '../../common/utils/widget.dart';
import '../../router.dart';
import '../../widgets/cv_feed_item.dart';
import '../../widgets/industry_drop_down.dart';
import '../../widgets/notification.dart';
import '../../widgets/pagination.dart';

class CVView extends StatefulWidget {
  const CVView({super.key, required this.params});

  final Map<String, String> params;

  @override
  State<CVView> createState() => _CVViewState();
}

class _CVViewState extends State<CVView> {

  late CVBloc _bloc;

  final searchController = TextEditingController();
  final industryController = TextEditingController();
  final provinceController = TextEditingController();
  late int page;

  @override
  void initState() {
    super.initState();
    _bloc = CVBloc()
      ..add(LoadEvent(
          page: widget.params['page'] ?? '1',
          searchContent: widget.params['q'] ?? '',
          province: widget.params['province'],
          industry: widget.params['industry']
      ));
  }

  @override
  void didUpdateWidget(CVView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _bloc.add(LoadEvent(
        page: widget.params['page'] ?? '1',
        searchContent: widget.params['q'] ?? '',
        province: widget.params['province'],
        industry: widget.params['industry']
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<CVBloc, CVState>(
        listener: (context, state) {
          if (state is LoadFailure) {
            showTopRightSnackBar(context, state.message, state.notifyType);
          } else if(state is LoadSuccess) {
            page = int.parse(widget.params['page'] ?? "1");
            searchController.text = widget.params['q'] ?? "";
            industryController.text = widget.params['industry'] ?? "";
            provinceController.text = widget.params['province'] ?? "";
          }
        },
        child: BlocBuilder<CVBloc, CVState>(
          builder: (context, state) {
            if(state is LoadSuccess) {
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1280),
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Column(
                      children: [
                        buildSearch(state),
                        buildContent(state)
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
        ),
      ),
    );
  }

  Widget buildSearch(LoadSuccess state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 36,
              child: TextField(
                style: const TextStyle(
                    fontSize: 16.0, color: Colors.black),
                controller: searchController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    hintText: 'Nhập từ khóa tìm kiếm...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(4)))),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: proviceDropDown(state.provinces, provinceController, "Lọc theo tỉnh/thành phố", (p0) => null),
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: industryDropDown(state.industries, industryController, "Lọc theo ngành", (p0) async {}),
          ),
          Container(
            margin: EdgeInsets.only(left: 40),
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            constraints: const BoxConstraints(minWidth: 120),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,// Màu chữ của nút
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                appRouter.go(getSearchQuery(
                    path: "/cv/viewsearch",
                    searchStr: searchController.text,
                    industry: industryController.text,
                    province: provinceController.text,
                    page: page
                ));
              },
              child: const Text("Tìm kiếm",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  softWrap: false,
                  maxLines: 1),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContent(LoadSuccess state) {
    List<CV> cvs = state.result.resultList;

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            for(int i = 0 ;i < cvs.length;i = i + 2)
              buildItemRow(cvs[i], i + 1 < cvs.length ? cvs[i + 1] : null),
            Pagination(
              path: '/viewsearch',
              totalItem: state.result.count,
              params: widget.params,
              selectedPage: int.parse(widget.params['page'] ?? "1"),
            )
          ],
        )
    );
  }

  Widget buildItemRow(CV itemOne, CV? itemTow) {
    return Row(
      children: [
        Expanded(
          child: CVFeedItem(cv: itemOne),
        ),
        Expanded(
          child: itemTow != null ? CVFeedItem(cv: itemOne) : Container(),
        )
      ],
    );
  }

  String getSearchQuery({
    required path,
    required String searchStr,
    required String industry,
    required String province,
    required page}) {
    return path + "/q=$searchStr&industry=$industry&province=$province&page=$page";
  }
}
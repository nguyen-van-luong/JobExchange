import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_exchange/ui/views/cv_detail/blocs/cv_detail_bloc.dart';

import '../../widgets/notification.dart';

class CVDetailView extends StatefulWidget {
  const CVDetailView({super.key, required this.id});
  final String? id;

  @override
  State<CVDetailView> createState() => _CVDetailView();
}

class _CVDetailView extends State<CVDetailView> {
  late CVDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CVDetailBloc()
      ..add(LoadEvent(id: widget.id!));
  }

  @override
  void didUpdateWidget(CVDetailView oldWidget) {
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
        child: BlocListener<CVDetailBloc, CVDetailState>(
            listener: (context, state) {
              if (state is LoadFailure) {
                showTopRightSnackBar(context, state.message, state.notifyType);
              }
            },
            child: BlocBuilder<CVDetailBloc, CVDetailState>(
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
                            //Code view
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
}
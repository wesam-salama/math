import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/components/models/video.dart';
import 'package:pythagoras/features/users/providers/user_provider.dart';
import 'package:pythagoras/features/users/repo/api_user_repo.dart';
import 'package:pythagoras/features/users/ui/screens/live_screen.dart';
import 'package:pythagoras/features/users/ui/screens/watch_classes2.dart';
import 'package:pythagoras/features/users/ui/widgets/card_watch.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';

class WatchClasses extends StatefulWidget {
  var level;
  var term;
  var unitId;
  Color color;
  var price;
  var mathType;
  WatchClasses(
      {this.level,
      this.term,
      this.unitId,
      this.color,
      this.price,
      this.mathType});
  @override
  _WatchClassesState createState() => _WatchClassesState();
}

class _WatchClassesState extends State<WatchClasses> {
  Future<void> futureController;
  bool isVideo = false;

  setIsVideo(bool val) {
    isVideo = val;
    setState(() {});
  }

  String video1;

  isBob(BuildContext context) {
    if (widget.level == "7" || widget.level == "8") {
      BlocProvider.of<UserBloc>(context)
          .add(UnitTwilvEvent(widget.level, widget.mathType, widget.term));
    } else {
      BlocProvider.of<UserBloc>(context)
          .add(UnitEvent(widget.term, widget.level));
    }

    return true;
  }

  static const _pageSize = 20;

  final PagingController<int, VideoData> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ApiRepositoryUser.apiRepositoryUser
          .videoUserPage(widget.level, widget.unitId.toString());
      final newItems1 = newItems.reversed.toList();
      final isLastPage = newItems1.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems1);
      } else {
        final nextPageKey = pageKey + newItems1.length;
        _pagingController.appendPage(newItems1, nextPageKey);
      }
    } catch (error) {
      print(
          "ssssssssssssssshhjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj ${error.toString()}");
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.color,
        title: Column(
          children: [
            Text(
              widget.level == "1"
                  ? "الصف الخامس الإبتدائي"
                  : widget.level == "2"
                      ? "الصف السادس الإبتدائي"
                      : widget.level == "3"
                          ? "الصف السابع "
                          : widget.level == "4"
                              ? "الصف الثامن "
                              : widget.level == "5"
                                  ? "الصف التاسع "
                                  : widget.level == "6"
                                      ? "الصف العاشر "
                                      : widget.level == "7"
                                          ? "الصف الحادي عشر "
                                          : widget.level == "8"
                                              ? "الصف الثاني عشر "
                                              : "",
              style: styleTitleAppBarYears,
            ),
            Text(
                widget.term == "1"
                    ? "الفصل الدراسي الأول "
                    : widget.term == "2"
                        ? "الفصل الدراسي الثاني "
                        : "",
                style: styleTitleAppBarYears.copyWith(fontSize: 10)),
          ],
        ),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return isBob(context);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              Container(
                  height: ScreenUtil().setHeight(725),
                  child: PagedListView<int, VideoData>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<VideoData>(
                        itemBuilder: (context, item, index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: InkWell(
                                onTap: () {
                                  print(
                                      "ssssssssssssssssttttttttttttttttt ${widget.unitId}");

                                  if (item.type == "OFFLINE") {
                                    BlocProvider.of<UserBloc>(this.context)
                                        .add(IsAccessVideoEvent(
                                            item.id.toString(),
                                            this.context,
                                            WatchClasses2(
                                              unitId: widget.unitId,
                                              level: widget.level,
                                              term: widget.term,
                                              videoUrl:
                                                  "${item.videoAccessUrl}",
                                              color: widget.color,
                                              title: "الدرس ${index + 1}",
                                              desTitle: item.title,
                                              price: widget.price,
                                              mathh: widget.mathType,
                                            ),
                                            widget.unitId,
                                            widget.level,
                                            widget.price,
                                            mathType: widget.mathType,
                                            term: widget.term));
                                  } else {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .getVideoAccess(item.id.toString());
                                    Future.delayed(Duration(seconds: 1), () {
                                      return BlocProvider.of<UserBloc>(
                                              this.context)
                                          .add(IsAccessVideoEvent(
                                              item.id.toString(),
                                              this.context,
                                              LiveScreen(
                                                linkLive:
                                                    Provider.of<UserProvider>(
                                                            context,
                                                            listen: false)
                                                        .link,
                                                level: widget.level,
                                                term: widget.term,
                                                color: widget.color,
                                              ),
                                              widget.unitId,
                                              widget.level,
                                              widget.price,
                                              mathType: widget.mathType,
                                              term: widget.term));
                                    });
                                  }
                                },
                                child: CardWatch(
                                  videoData: item,
                                  index: index,
                                ),
                              ));
                          //                                   )));
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

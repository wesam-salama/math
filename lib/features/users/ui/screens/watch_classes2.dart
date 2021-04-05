import 'package:chewie/chewie.dart';
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
import 'package:pythagoras/features/users/ui/widgets/card_watch.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/styles.dart';
import 'package:video_player/video_player.dart';

class WatchClasses2 extends StatefulWidget {
  var level;
  var term;
  var videoUrl;
  var unitId;
  Color color;
  var title;
  var desTitle;
  var price;
  var mathh;
  WatchClasses2(
      {this.level,
      this.term,
      this.videoUrl,
      this.unitId,
      this.color,
      this.title,
      this.desTitle,
      this.price,
      this.mathh});
  @override
  _WatchClasses2State createState() => _WatchClasses2State();
}

class _WatchClasses2State extends State<WatchClasses2> {
  VideoPlayerController videoPlayerCont;
  Future<void> futureCont;
  ChewieController chewieController;

  static const _pageSize = 20;

  final PagingController<int, VideoData> _pagingController =
      PagingController(firstPageKey: 0);

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
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(VideoEvent());
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    videoPlayerCont = VideoPlayerController.network(widget.videoUrl);
    futureCont = videoPlayerCont.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerCont,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerCont.dispose();
    chewieController.dispose();
    _pagingController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("sssssssssssssssssssssssssssssssss ${widget.videoUrl}");
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: ScreenUtil().setHeight(250),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                  ),
                  child: FutureBuilder(
                    future: futureCont,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Chewie(
                          controller: chewieController,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(5),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: styleTitleDetails.copyWith(fontSize: 12),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.desTitle,
                style: styleTitleAppBarYears.copyWith(color: deepGreenColor),
              ),
            ),
            Container(
              height: ScreenUtil().setHeight(500),
              child: PagedListView<int, VideoData>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<VideoData>(
                    itemBuilder: (context, item, index) {
                      return Container(
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                        child: InkWell(
                          onTap: () {
                            videoPlayerCont.pause();

                            if (item.type == "OFFLINE") {
                              BlocProvider.of<UserBloc>(this.context)
                                  .add(IsAccessVideoEvent(
                                      item.id.toString(),
                                      this.context,
                                      WatchClasses2(
                                        unitId: widget.unitId,
                                        level: widget.level,
                                        term: widget.term,
                                        videoUrl: "${item.videoAccessUrl}",
                                        color: widget.color,
                                        title: "الدرس ${index + 1}",
                                        desTitle: item.title,
                                        price: widget.price,
                                      ),
                                      widget.unitId,
                                      widget.level,
                                      widget.price,
                                      mathType: widget.mathh,
                                      term: widget.term));
                            } else {
                              Provider.of<UserProvider>(context, listen: false)
                                  .getVideoAccess(item.id.toString());
                              Future.delayed(Duration(seconds: 1), () {
                                return BlocProvider.of<UserBloc>(this.context)
                                    .add(IsAccessVideoEvent(
                                        item.id.toString(),
                                        this.context,
                                        LiveScreen(
                                          linkLive: Provider.of<UserProvider>(
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
                                        mathType: widget.mathh,
                                        term: widget.term));
                              });
                            }
                          },
                          child: CardWatch(
                            videoData: item,
                            index: index,
                          ),
                        ),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}

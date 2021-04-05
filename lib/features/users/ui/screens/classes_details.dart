import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pythagoras/animate_do.dart';
import 'package:pythagoras/bloc/bloc_class.dart';
import 'package:pythagoras/bloc/bloc_events.dart';
import 'package:pythagoras/bloc/bloc_states.dart';
import 'package:pythagoras/components/models/unit.dart';
import 'package:pythagoras/components/models/unit_twilv_elvent.dart';
import 'package:pythagoras/features/users/ui/screens/watch_classes.dart';
import 'package:pythagoras/features/users/ui/widgets/card_details.dart';
import 'package:pythagoras/values/colors.dart';
import 'package:pythagoras/values/constants.dart';
import 'package:pythagoras/values/styles.dart';

class ClassesDetails extends StatefulWidget {
  String level;
  String term;
  Color color;
  String mathType;
  ClassesDetails({this.level, this.term, this.color , this.mathType});

  @override
  _ClassesDetailsState createState() => _ClassesDetailsState();
}

class _ClassesDetailsState extends State<ClassesDetails> {


  isBob(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(SettingsEvent());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
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
                width: double.infinity,
                child: BlocBuilder<UserBloc, BlocStates>(
                  builder: (context, state) {
                    if (state is TasksLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is EmptyTasksState) {
                      return Center(
                        child: Text('Empty Tasks'),
                      );
                    } else if (state is TasksErrorState) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is UnitState) {
                      List<UnitData> unitdata = state.data;
                      print("objectdddddddddddddd ${unitdata.length}");

                      return Container(
                        child: ListView.builder(
                          itemCount: unitdata.length,
                          itemBuilder: (context, index) {
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<UserBloc>(context)
                                          .add(VideoEvent());
                                      push(
                                          context,
                                          WatchClasses(
                                            level: widget.level,
                                            term: widget.term,
                                            unitId: unitdata[index].id,
                                            color: widget.color,
                                            price: unitdata[index].price,
                                            
                                          ));
                                    },
                                    child: SlideInUp(
                                        animate: true,
                                        duration: Duration(
                                            milliseconds: 1000 + (300 * index)),
                                        child: CardDetails(
                                            unitdata: unitdata[index],
                                            color: widget.color,
                                            index: index))));
                          },
                        ),
                      );
                    } else if (state is UnitTwilvState) {
                      List<UnitTwilvAliventData> unitdata = state.data;
                      print("objectdddddddddddddd ${unitdata.length}");

                      return Container(
                        child: ListView.builder(
                          itemCount: unitdata.length,
                          itemBuilder: (context, index) {
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<UserBloc>(context)
                                          .add(VideoEvent());
                                      push(
                                          context,
                                          WatchClasses(
                                            level: widget.level,
                                            term: widget.term,
                                            unitId: unitdata[index].id,
                                            color: widget.color,
                                            price: double.parse("${unitdata[index].price}"),
                                            mathType: widget.mathType,
                                          ));
                                    },
                                    child: SlideInUp(
                                        animate: true,
                                        duration: Duration(
                                            milliseconds: 1000 + (300 * index)),
                                        child: CardDetails(
                                            unitdata: unitdata[index],
                                            color: widget.color,
                                            index: index))));
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

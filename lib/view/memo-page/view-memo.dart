import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:book_task/model/memo-model.dart';
import 'package:book_task/model/person-model.dart';
import 'package:book_task/view/Home/home-controller.dart';
import 'package:book_task/view/Home/view-home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/toastt.dart';
import 'memo-controller.dart';

// ignore: must_be_immutable
class Memopage extends StatelessWidget {
  final Person person;
  Widget doneToast(BuildContext context, String msg) {
    showToastWidget(
        IconToastWidget.success(
          msg: msg,
        ),
        context: context,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.slideToRight,
        reverseAnimation: StyledToastAnimation.sizeFade,
        duration: Duration(seconds: 2),
        animDuration: Duration(seconds: 1),
        curve: Curves.ease,
        reverseCurve: Curves.easeOutQuart);
  }

  Widget failToast(BuildContext context, String msg) {
    showToastWidget(
        IconToastWidget.fail(
          msg: msg,
        ),
        context: context,
        position: StyledToastPosition.top,
        animation: StyledToastAnimation.slideToRight,
        reverseAnimation: StyledToastAnimation.sizeFade,
        duration: Duration(seconds: 2),
        animDuration: Duration(seconds: 1),
        curve: Curves.ease,
        reverseCurve: Curves.easeOutQuart);
  }

  Memopage(this.person);
  String filterCondition;
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: MemoProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              String Memodis = "", Memotital = "";
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        backgroundColor: Colors.white,
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              child: ListBody(
                                children: <Widget>[
                                  TextFormField(
                                    style: GoogleFonts.almarai(),

                                    decoration: InputDecoration(
                                     // hintText: "Memo title",
                                      labelText: "Memo title",
                                      hintStyle: GoogleFonts.almarai(),
                                      contentPadding: EdgeInsets.all(10),
                                      // suffixIcon:Icon(Icons.search,size: 25,),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onChanged: (val) {
                                      Memotital = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  TextFormField(
                                    expands: false,
                                    minLines: null,
                                    maxLines: null,
                                    style: GoogleFonts.almarai(),
                                    //  textDirection: TextDirection.rtl,
                                    // textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      labelText: "Your memo with this friend ",
                                      hintStyle: GoogleFonts.almarai(),
                                      contentPadding: EdgeInsets.all(10),
                                      // suffixIcon:Icon(Icons.search,size: 25,),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pinkAccent,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.pinkAccent,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onChanged: (val) {
                                      Memodis = val;
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                        title: Center(
                          child: Text(
                            ' Add Memo',
                            style: GoogleFonts.almarai(
                                color: Colors.pinkAccent,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        actions: <Widget>[
                          Center(
                            child: Container(
                              //  height: .120.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.pinkAccent[200],
                                        spreadRadius: .75,
                                        blurRadius: 2,
                                        offset: Offset(1, 1))
                                  ],
                                  border: Border.all(color: Colors.pinkAccent),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextButton(
                                child: Text(
                                  'اضافه',
                                  style: GoogleFonts.almarai(
                                      fontSize: 17.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.right,
                                ),
                                onPressed: () {
                                  if (Memodis != "" && Memotital != "") {
                                    MemoProvider().addMemo(Memo(
                                        titel: Memotital,
                                        discription: Memodis,
                                        pirsonName: this.person.name));
                                    doneToast(context, "Added");
                                    this.person.memoNum++;
                                    PersonProvider().updatePerson(this.person);
                                    Navigator.of(context).pop();
                                  } else {
                                    failToast(context, "Empty field !");
                                    // Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ));
            }),
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.ERROR,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    title: "تحذير",
                    desc: 'هل تريد حذف الحساب',
                    btnOkOnPress: () {
                      MemoProvider().deletePersonMemo(this.person.name);
                      PersonProvider().deletePerson(this.person.name);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BookPage()));
                    },
                    btnCancelOnPress: () {
                      Navigator.pop;
                    }).show();
              },
            )
          ],
          backgroundColor: Colors.pink,
          title: Center(child: Text(this.person.name)),
        ),
        body: SafeArea(
            child: Selector<MemoProvider, List>(selector: (context, getMemo) {
          getMemo.fetchMemoList(this.person.name);
          return getMemo.getMemoList;
        }, builder: (ctx, MemoList, widget) {
          return MemoList == null
              ? SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                )
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(80),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(2, 2))
                            ],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35),
                                bottomLeft: Radius.circular(35))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Switch(
                                    value: true,
                                    activeColor: Colors.limeAccent,
                                    onChanged: (val) {}),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever_rounded,
                                    size: ScreenUtil().setWidth(40),
                                  ),
                                  onPressed: () {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        headerAnimationLoop: false,
                                        animType: AnimType.TOPSLIDE,
                                        title: "تحذير",
                                        desc: 'هل تريد حذف جميع الذكريات',
                                        btnOkOnPress: () {
                                          MemoProvider().deletePersonMemo(
                                              this.person.name);
                                          this.person.memoNum = 0;
                                          PersonProvider()
                                              .updatePerson(this.person);
                                          //  Navigator.pop;
                                        },
                                        btnCancelOnPress: () {
                                          Navigator.pop;
                                        }).show();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            itemCount: MemoList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              margin: EdgeInsets.only(top: 6.h),
                              // height: ScreenUtil().setHeight(100),
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                        color: Colors.cyan[200],
                                        spreadRadius: .75,
                                        blurRadius: 1,
                                        offset: Offset(1, 1)),],
                                  border: Border.all(color: Colors.cyan),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              //color: Colors.white,
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      decoration: BoxDecoration(
                                          //border: Border.all(color: Colors.black),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black54,
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(1, 1))
                                          ],
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.create,
                                            ),
                                            onPressed: () {
                                              String Memodis = MemoList[index].discription, Memotital = MemoList[index].titel;
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) => AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                            bottomLeft: Radius.circular(40),
                                                            topRight: Radius.circular(40))),
                                                    backgroundColor: Colors.white,
                                                    content: StatefulBuilder(builder:
                                                        (BuildContext context, StateSetter setState) {
                                                      return SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
                                                        child: Container(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              TextFormField(
                                                                style: GoogleFonts.almarai(),
                                                                initialValue: Memotital,
                                                                decoration: InputDecoration(
                                                                  labelText: "Memo title",
                                                                  hintStyle: GoogleFonts.almarai(),
                                                                  contentPadding: EdgeInsets.all(10),
                                                                  // suffixIcon:Icon(Icons.search,size: 25,),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors.pinkAccent,
                                                                          width: 2),
                                                                      borderRadius:
                                                                      BorderRadius.circular(15)),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.pinkAccent,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(15)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.pinkAccent,
                                                                        width: 3,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(15)),
                                                                ),
                                                                onChanged: (val) {
                                                                  Memotital = val;
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 20.h,
                                                              ),
                                                              TextFormField(
                                                                initialValue: Memodis,
                                                                expands: false,
                                                                minLines: null,
                                                                maxLines: null,
                                                                style: GoogleFonts.almarai(),
                                                                 decoration: InputDecoration(
                                                                   labelText: "Your memo with this friend ",
                                                                  hintStyle: GoogleFonts.almarai(),
                                                                  contentPadding: EdgeInsets.all(10),
                                                                  // suffixIcon:Icon(Icons.search,size: 25,),
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors.pinkAccent,
                                                                          width: 2),
                                                                      borderRadius: BorderRadius.circular(15),),
                                                                  enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.pinkAccent,
                                                                        width: 2,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(15),),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: Colors.pinkAccent,
                                                                        width: 3,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius.circular(15),),
                                                                ),
                                                                onChanged: (val) {
                                                                  Memodis = val;
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                    title: Center(
                                                      child: Text(
                                                        ' Update Memo',
                                                        style: GoogleFonts.almarai(
                                                            color: Colors.pinkAccent,
                                                            fontSize: 20.sp,
                                                            fontWeight: FontWeight.w500),
                                                        textAlign: TextAlign.right,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      Center(
                                                        child: Container(
                                                          //  height: .120.h,
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.pinkAccent[200],
                                                                    spreadRadius: .75,
                                                                    blurRadius: 2,
                                                                    offset: Offset(1, 1))
                                                              ],
                                                              border: Border.all(color: Colors.pinkAccent),
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(20)),
                                                          child: TextButton(
                                                            child: Text(
                                                              'اضافه',
                                                              style: GoogleFonts.almarai(
                                                                  fontSize: 17.sp,
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w500),
                                                              textAlign: TextAlign.right,
                                                            ),
                                                            onPressed: () {
                                                              if (Memodis != "" && Memotital != "") {
                                                                MemoProvider().addMemo(Memo(
                                                                    titel: Memotital,
                                                                    discription: Memodis,
                                                                    pirsonName: this.person.name));
                                                                doneToast(context, "Update");
                                                                PersonProvider().updatePerson(this.person);
                                                                Navigator.of(context).pop();
                                                              } else {
                                                                failToast(context, "Empty field !");
                                                                // Navigator.of(context).pop();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                            },
                                          ),
                                          SizedBox(
                                            width: .25,
                                          ),
                                          Text(MemoList[index].titel),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                            ),
                                            onPressed: () {
                                              AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.ERROR,
                                                  headerAnimationLoop: false,
                                                  animType: AnimType.TOPSLIDE,
                                                  title: "تحذير",
                                                  desc: 'هل تريد حذف الذكرى؟',
                                                  btnOkOnPress: () {
                                                    MemoProvider().deleteMemo(
                                                        MemoList[index].titel);
                                                    this.person.memoNum--;
                                                    PersonProvider()
                                                        .updatePerson(
                                                            this.person);
                                                    Navigator.pop;
                                                  },
                                                  btnCancelOnPress: () {
                                                    Navigator.pop;
                                                  }).show();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      textDirection: MemoList[index]
                                                  .discription
                                                  .codeUnitAt(0) >
                                              126
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                          text: MemoList[index].discription),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(1),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        })),
      ),
    );
  }
}

 import 'package:book_task/model/person-model.dart';
import 'package:book_task/view/memo-page/view-memo.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
 import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widget/toastt.dart';
import 'home-controller.dart';

// ignore: must_be_immutable
class BookPage extends StatelessWidget {
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

  BookPage();
  String filterCondition;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PersonProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              String bookname="";
              DateTime birthdate=DateTime.now();
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
                                      labelText: "friend name",
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
                                      bookname = val;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CupertinoDateTextBox(
                                    color: Colors.pinkAccent,
                                    initialValue: DateTime.now(),
                                    onDateChange: (val) {
                                      birthdate = val;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        title: Center(
                          child: Text(
                            'Add Friend',
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
                                  'Add',
                                  style: GoogleFonts.almarai(
                                      fontSize: 17.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.right,
                                ),
                                onPressed: () {
                                  if (bookname != "") {
                                    print(PersonProvider().addPerson(Person(
                                        name: bookname,
                                        birthDate: birthdate.toString(),
                                        memoNum: 0)));
                                    doneToast(context, "Added");
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
          backgroundColor: Colors.pink,
          title: Center(child: Text("Friends list")),
        ),
        body: SafeArea(
            child: Selector<PersonProvider, List>(selector: (context, getBook) {
          getBook.fetchPersonList();
          return getBook.getPersonList;
        }, builder: (ctx, BookList, widget) {
          return BookList == null
              ? SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                )
              : AnimationLimiter(
                  child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(BookList.length, (index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: Duration(milliseconds: index * 400),
                          columnCount: 2,
                          child: SlideAnimation(
                            child: FlipAnimation(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Memopage(BookList[index])));
                                },
                                child: Container(
                                    width: 0.12.sh,
                                    height: 0.12.sh,
                                    margin: EdgeInsets.symmetric(

                                        horizontal: 7.sp, vertical: 0.03.sh),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(20.r),
                                      //   boxShadow: [myBoxShadow]
                                    ),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            BookList[index].name,
                                            style: GoogleFonts.almarai(
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            BookList[index].birthDate,
                                            style: GoogleFonts.almarai(
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            BookList[index].memoNum.toString(),
                                            style: GoogleFonts.almarai(
                                                fontSize: 16.sp),
                                          ),
                                          IconButton(
                                            onPressed: (){
                                              String name="",birth=""; DateTime birthdate;
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius.circular(40),
                                                                topRight: Radius.circular(40),
                                                            ),),
                                                        backgroundColor: Colors.white,
                                                        content: StatefulBuilder(
                                                            builder: (BuildContext
                                                            context,
                                                                StateSetter setState) {
                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                Axis.vertical,
                                                                child: Container(
                                                                  child: ListBody(
                                                                    children: <Widget>[
                                                                      TextFormField(
                                                                        style: GoogleFonts.almarai(
                                                                            fontSize:
                                                                            18.sp),
                                                                        decoration: InputDecoration(
                                                                          labelText: "book title",
                                                                          hintStyle: GoogleFonts.almarai(fontSize: 17.sp),
                                                                          contentPadding: EdgeInsets.all(10),
                                                                          border: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: Colors
                                                                                      .pinkAccent,
                                                                                  width: 2),
                                                                              borderRadius:
                                                                              BorderRadius
                                                                                  .circular(
                                                                                  15)),
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide:
                                                                              BorderSide(
                                                                                color: Colors
                                                                                    .pinkAccent,
                                                                                width:
                                                                                2,
                                                                              ),
                                                                              borderRadius:
                                                                              BorderRadius.circular(
                                                                                  15)),
                                                                          focusedBorder:
                                                                          OutlineInputBorder(
                                                                              borderSide:
                                                                              BorderSide(
                                                                                color: Colors
                                                                                    .pinkAccent,
                                                                                width:
                                                                                3,
                                                                              ),
                                                                              borderRadius:
                                                                              BorderRadius.circular(
                                                                                  15)),
                                                                        ),
                                                                        onChanged: (val) {
                                                                          name = val;
                                                                        },
                                                                      ),
                                                                      CupertinoDateTextBox(
                                                                        color: Colors.pinkAccent,
                                                                        initialValue: DateTime.parse(BookList[index].birthDate),
                                                                        onDateChange: (val) {
                                                                          birthdate = val;
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                        title: Center(
                                                          child: Text(
                                                            'change ${BookList[index].name} data ',
                                                            style: GoogleFonts.almarai(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                FontWeight.w500),
                                                            textAlign: TextAlign.right,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          Center(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .pinkAccent[
                                                                        200],
                                                                        spreadRadius:
                                                                        .75,
                                                                        blurRadius: 2,
                                                                        offset: Offset(
                                                                            1, 1))
                                                                  ],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .pinkAccent),
                                                                  color: Colors.white,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      20)),
                                                              child: TextButton(
                                                                child: Text(
                                                                  'save changes',
                                                                  style: GoogleFonts
                                                                      .almarai(
                                                                      fontSize:
                                                                      17.sp,
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                                  textAlign:
                                                                  TextAlign.right,
                                                                ),
                                                                onPressed: () {
                                                                  print(name);
                                                                  print(birthdate);
                                                                  if ((BookList[index].name != name || BookList[index].birthDate != birthdate.toString()
                                                                  ) && (name!="" || birthdate!=null)){
                                                                    PersonProvider().updatePerson(Person(
                                                                        memoNum: BookList[index].memoNum,
                                                                      birthDate: birthdate==null?BookList[index].birthDate:birthdate.toString(),
                                                                      name:name==""? BookList[index].name:name
                                                                    ),last:BookList[index].name);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                    doneToast(context,
                                                                        "Done");
                                                                  } else {
                                                                    failToast(context, "No change");
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                            },
                                            icon: Icon(Icons.edit),
                                          )
                                        ],
                                      ),
                                    )

                                    ),
                              ),
                            ),
                          ),
                        );
                      })),
                );
          /* StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                )),
           staggeredTileBuilder: (int index) => new StaggeredTile.fit(index%2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );*/
        })),
      ),
    );
  }
}

 import 'package:book_task/model/person-model.dart';
import 'package:book_task/service/memo-Database.dart';
import 'package:flutter/cupertino.dart';

class PersonProvider extends ChangeNotifier{
  List<Person> PersonList = [];
  get getPersonList => PersonList;

  fetchPersonList()async{
    PersonList=await Memos_service_database().getPerson();
    notifyListeners();
  }

  addPerson(Person obj ){
    Memos_service_database().addPerson(obj);
    notifyListeners();
  }

  updatePerson(Person obj,{String last=""}){

    Memos_service_database().updatePerson(obj,last: last);
    print(obj.memoNum);
    print("4444444444444444444444444444444444444444444444");
    notifyListeners();
  }

  deletePerson(String bname){
    Memos_service_database().DeletePerson(bname);
    notifyListeners();
  }

}
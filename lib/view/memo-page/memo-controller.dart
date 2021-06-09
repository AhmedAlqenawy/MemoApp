import 'package:book_task/model/memo-model.dart';
import 'package:book_task/service/memo-Database.dart';
 import 'package:flutter/cupertino.dart';

class MemoProvider extends ChangeNotifier{
  List<Memo> MemoList = [];
  get getMemoList => MemoList;

  fetchMemoList(String pirsonName)async{
    MemoList=await Memos_service_database().find(pirsonName);
    notifyListeners();
  }

  addMemo(Memo obj ){
    Memos_service_database().add(obj);
    notifyListeners();
  }

  updateMemo(Memo obj){
    Memos_service_database().update(obj);
    notifyListeners();
  }

  deletePersonMemo(String PersonName){
    Memos_service_database().deletePersonMemo( PersonName);
    notifyListeners();
  }
  deleteMemo(String title){
    Memos_service_database().deleteMemo(title);
    notifyListeners();
  }
}
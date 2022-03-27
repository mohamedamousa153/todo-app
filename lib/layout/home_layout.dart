import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/archived_task/archivedtask.dart';
import '../modules/done_task/donetask.dart';
import '../modules/new_task/newtask.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

// 1- create database
// 2- create database
// 3- open database
// 4- insert to database
// 5- get from database
// 6- update to database
// 7- delete from database

class _HomeLayoutState extends State<HomeLayout> {
  var currentIndexPage = 0;
  var pageScreens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List appBarText = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  Database? database;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${appBarText[currentIndexPage]}'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // try {
          //   var getname = await getName();
          //   print(getname);
          //   throw ('some erorr');
          // } catch (error) {
          //   print('error ${error.toString()}');
          // }
          // getName().then((value) {
          //   print(value);
          //   print('mohamed ayman ');
          //   // throw ('some erorr');
          // }).catchError((error) {
          //   print('error ${error.toString()}');
          // });
          inserToDatabase();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexPage,
        onTap: (index) {
          setState(() {
            currentIndexPage = index;
          });
        },
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'archive'),
        ],
      ),
      body: pageScreens[currentIndexPage],
    );
  }

  // Future<String> getName() async {
  //   String Name = 'moaahmed';
  //   return Name;
  // }

  void createDatabase() async {
    database = await openDatabase('todoapp.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when database created${error.toString()}');
      });
    }, onOpen: (database) {
      print('open database');
    });
  }

  void inserToDatabase() {
    database?.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status) VALUES("first task","0222","12","new")')
          .then((value) {
        print('${value}inserted successfully');
      }).catchError((error) {
        print('Error when inserted new record ${error.toString()}');
      });
      return null;
    });
  }
}

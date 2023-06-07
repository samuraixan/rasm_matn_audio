import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Dars.dart';
import 'Dars1.dart';
import 'LessonPage.dart';
import 'MemoriezPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool ready = false;

  Widget? widget1, widget2, widget3;

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  loadAll() async {
    widget1 = await generateListViewForTab(0);
    widget2 = await generateListViewForTab(1);
    widget3 = await generateListViewForTab(2);
    ready = true;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.green,
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: const Text("MUALLIMI SONIY"),
              bottom: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                tabs: const [
                  Tab(child: Text("HARFLAR",style: TextStyle(color: Colors.black),),),
                  Tab(child: Text("QOIDALAR", style: TextStyle(color: Colors.black),),),
                  Tab(child: Text("YODLASH", style: TextStyle(color: Colors.black),),),
                ],
              ),
            ),
            body: ! ready
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : TabBarView(
                children: [widget1!,widget2!,widget3!]
            )
        ),
      ),
    );
  }
  Future<Widget> generateListViewForTab(int index) async {
    String content = "assets/harflar.json";
    String title = "HARFI";
    switch (index) {
      case 1:
        content = "assets/qoidalar.json";
        String title = "HARFLAR";
        final String jsonContent = await rootBundle.loadString(content);
        final group = Dars.fromJson(json.decode(jsonContent));
        return ListView.builder(
            itemCount: group.group?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Center(child: Text("${group.group?[index].name}")),
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>
                            LessonPage(group: group.group?[index], title: title,)));
                  },
                ),
              );
            }
        );
      case 2:
        content = "assets/yodlash.json";
        final String jsonContent = await rootBundle.loadString(content);
        final res = Dars1.fromJson(json.decode(jsonContent));
        return ListView.builder(
            itemCount: res.res?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Center(child: Text("${res.res?[index].heading}")),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MemoriezPage(res: res.res?[index])));
                  },
                ),
              );
            }
        );
      default:
        break;
    }
    final String jsonContent = await rootBundle.loadString(content);
    final group = Dars.fromJson(json.decode(jsonContent));
    return ListView.builder(
        itemCount: group.group?.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Center(child: Text("${group.group?[index].name} harfi")),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>
                        LessonPage(group: group.group?[index], title: title)));
              },
            ),
          );
        }
    );
  }
}




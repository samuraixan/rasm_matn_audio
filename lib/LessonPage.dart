import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'Group.dart';


class LessonPage extends StatefulWidget {
  Group? group;
  String? title;

  LessonPage({Key? key, this.group, this.title,}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  String author = "Jahongir qori Ne`matov";
  late AudioPlayer player;
  bool playerStarted = false, isPlaying = false;


  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        playerStarted = false;
      }
    });
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = "${widget.group?.name} ${widget.title}".toLowerCase();
    title = "${title.substring(0,1).toUpperCase()}${title.substring(1)}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("${widget.group?.name?.toString()} ${widget.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  IconButton(onPressed: () async {
                    if (!playerStarted) {
                      await player.setAsset("${widget.group?.musi}");
                      player.play();
                      isPlaying = true;
                      playerStarted = true;
                    } else if (!isPlaying) {
                      player.play();
                      isPlaying = true;
                    } else {
                      player.pause();
                      isPlaying = false;
                    }
                    setState(() {});
                  },
                      icon: !isPlaying
                      ?const Icon(Icons.play_arrow)
                          :const Icon(Icons.pause)
                  ),
                  SizedBox(width: 20,),
                  Text("$title  -  ${author}")
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: widget.group?.id?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 120,
                    padding: EdgeInsets.all(2),
                    child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                      onPressed: () async {
                        await player.setAsset("${widget.group?.mus?[index]}");
                        player.play();
                      },
                      child: Text(
                        "${widget.group?.id?[index].toString()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

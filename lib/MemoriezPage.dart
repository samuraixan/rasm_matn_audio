import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'Res.dart';

class MemoriezPage extends StatefulWidget {
  Res? res;
  MemoriezPage({Key? key, this.res}) : super(key: key);


  @override
  State<MemoriezPage> createState() => _MemoriezPageState();
}

class _MemoriezPageState extends State<MemoriezPage> {
  late AudioPlayer player;
  String author = "Jahongir qori ne`matov";
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
    String title = "${widget.res?.heading}".toLowerCase();
    title = "${title.substring(0,1).toUpperCase()}${title.substring(1)}";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.res?.heading}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        if (!playerStarted) {
                          await player.setAsset("${widget.res?.musi}");
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
                      },iconSize: 33,
                      color: Colors.green,
                      icon: !isPlaying
                          ? const Icon(
                        Icons.play_circle_fill,
                      )
                          : const Icon(
                        Icons.pause_circle,
                      )),
                  SizedBox(width: 20,),
                  Text("$title  -  ${author}")
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text("${widget.res?.heading}"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text("${widget.res?.ready}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Card(
                  child: InkWell(child: Text("${widget.res?.voice}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      onTap: () async {
                    await player.setAsset("${widget.res?.mus}");
                    player.play();
                      }
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("${widget.res?.translate}"),
            )
          ],
        ),
      ),
    );
  }
}

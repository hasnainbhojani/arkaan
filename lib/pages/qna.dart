// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class qna extends StatefulWidget {
  final String title;
  final String question;
  final bool isGenderBased;
  const qna(
      {super.key,
      required this.title,
      this.question = "Query?",
      required this.isGenderBased});

  @override
  State<qna> createState() => _qnaState();
}

class _qnaState extends State<qna> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                // Title
                Text(
                  widget.question,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(
                  height: 25,
                ),
                // Tawaf and Safa Marwah Tab
                widget.isGenderBased ? gender() : nogender()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class gender extends StatefulWidget {
  const gender({super.key});

  @override
  State<gender> createState() => _genderState();
}

class _genderState extends State<gender> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Color(0xff88704e),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      controller: tabController,
                      tabs: [
                        Tab(
                          text: 'Brothers',
                        ),
                        Tab(
                          text: 'Sisters',
                        )
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: ScrollableTabViewWithController(
                controller: tabController,
                children: [
                  genderBasedPlayer(videolink: "assets/video/example.mp4"),
                  genderBasedPlayer(videolink: "assets/video/example.mp4")
                ]),
          )
        ],
      ),
    );
  }
}

class genderBasedPlayer extends StatefulWidget {
  final String videolink;
  const genderBasedPlayer({super.key, required this.videolink});

  @override
  State<genderBasedPlayer> createState() => _genderBasedPlayerState();
}

class _genderBasedPlayerState extends State<genderBasedPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videolink);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      allowMuting: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 440,
      decoration: BoxDecoration(
        color: Color(0xff2d2b2b),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(children: [
        Center(
          child: Container(
            height: 400,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Chewie(controller: _chewieController),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

class nogender extends StatefulWidget {
  const nogender({super.key});

  @override
  State<nogender> createState() => _nogenderState();
}

class _nogenderState extends State<nogender> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset("assets/video/example.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      allowMuting: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 512,
      decoration: BoxDecoration(
        color: Color(0xff2d2b2b),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(children: [
        Center(
          child: Container(
            height: 480,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Chewie(controller: _chewieController),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}

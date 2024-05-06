// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class VoiceMessage {
//   final int playerId;
//   final String audioUrl;
//   final bool isPlay;
//   VoiceMessage(
//       {required this.playerId, required this.audioUrl, required this.isPlay});
// }

// class AudioFile {
//   final String title;
//   final String description;
//   final String url;
//   int playingstatus;
//   AudioFile(
//       {required this.title,
//       required this.description,
//       required this.url,
//       this.playingstatus = 0});
// }

// class VoiceMessageScreen extends StatefulWidget {
//   const VoiceMessageScreen({super.key});

//   @override
//   State<VoiceMessageScreen> createState() => _VoiceMessageScreenState();
// }

// class _VoiceMessageScreenState extends State<VoiceMessageScreen> {
//   final List<VoiceMessage> voiceMessages = [
//     VoiceMessage(
//       isPlay: false,
//       playerId: 1,
//       audioUrl: 'https://ts.pretteka.com/storage/33-20240401031019-0.m4a',
//     ),
//     VoiceMessage(
//         isPlay: false,
//         playerId: 2,
//         audioUrl: 'https://ts.pretteka.com/storage/33-20240401031024-0.m4a'),
//     VoiceMessage(
//         isPlay: false,
//         playerId: 3,
//         audioUrl: 'https://ts.pretteka.com/storage/5-20240402102436-0.m4a'),
//     VoiceMessage(
//         isPlay: false,
//         playerId: 4,
//         audioUrl: 'https://ts.pretteka.com/storage/5-20240402102449-0.m4a'),
//   ];
//   List<String> listVoice = [
//     'https://ts.pretteka.com/storage/33-20240401031019-0.m4a',
//     'https://ts.pretteka.com/storage/33-20240401031024-0.m4a',
//     'https://ts.pretteka.com/storage/5-20240402102436-0.m4a',
//     'https://ts.pretteka.com/storage/5-20240402102449-0.m4a'
//   ];
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   Duration durationUI = Duration.zero;
//   Duration positionUI = Duration.zero;
//   bool isClick = false;
//   bool isPass = false;

//   String urlVoice = '';
//   int id = 0;
//   Future setUrl(url) async {
//     await audioPlayer.play(UrlSource(url));
//     await audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
//     await audioPlayer.setReleaseMode(ReleaseMode.stop);
//   }

//   Future stop(url) async {
//     await audioPlayer.setSourceUrl(url);
//     await audioPlayer.stop();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     audioPlayer.onPlayerStateChanged.listen((state) async {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//         debugPrint("isPlaying:$isPlaying");
//       });
//     });
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//       debugPrint("Duration :$duration");
//     });
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//       //  debugPrint("Position :$position");
//     });
//     super.initState();
//   }

//   int _selectedIndex = 0;

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(':');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Voice Messages'),
//       ),
//       body: ListView.builder(
//         itemCount: voiceMessages.length,
//         itemBuilder: (context, index) {
//           return Column(children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.grey,
//               ),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 30,
//                       child: GestureDetector(
//                         onTap: () async {
//                           setState(() {
//                             _selectedIndex = index;
//                           });

//                           if (isPlaying == true) {
//                             audioPlayer.pause();
//                           }
//                           setUrl(voiceMessages[index].audioUrl);

//                           debugPrint("Index:$_selectedIndex");
//                         },
//                         child: CircleAvatar(
//                           child:
//                               Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     SizedBox(
//                       width: 100,
//                       child: SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           thumbShape: const RoundSliderThumbShape(
//                               enabledThumbRadius: 8),
//                           overlayShape: const RoundSliderOverlayShape(
//                               overlayRadius: 10.0),
//                         ),
//                         child: Slider(
//                           autofocus: true,
//                           activeColor: Colors.black,
//                           inactiveColor: Colors.green,
//                           min: 0.0,
//                           max: duration.inSeconds.toDouble(),
//                           value: position.inSeconds.toDouble(),
//                           onChanged: (value) async {
//                             final position = Duration(seconds: value.toInt());
//                             await audioPlayer.seek(position);
//                             await audioPlayer.resume();
//                           },
//                         ),
//                       ),
//                     ),
//                     Text(
//                       formatTime(duration - position),
//                       style: const TextStyle(
//                         fontSize: 10,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ]);
//         },
//       ),
//     );
//   }
// }

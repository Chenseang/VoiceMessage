import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VoiceAudioPlayer extends StatefulWidget {
  final String url;
  final bool isSender;
  const VoiceAudioPlayer({
    super.key,
    required this.url,
    required this.isSender,
  });

  @override
  State<VoiceAudioPlayer> createState() => _VoiceAudioPlayerState();
}

class VoiceModel {
  String? id;
  String? url;
  VoiceModel({this.id, this.url});
}

class _VoiceAudioPlayerState extends State<VoiceAudioPlayer> {
  String id = '';
  late AudioPlayer audioPlayer1 = AudioPlayer();
  bool isPlaying = false;
  bool isPlay1 = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Duration seconds = Duration.zero;
  String urlVoice = '';
  bool isLoading = false;
  List<VoiceModel> voiceList = [];

  PlayerState? _playerState;
  bool get _isPlaying => _playerState == PlayerState.playing;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer1.dispose();
  }

  @override
  void initState() {
    super.initState();

    _playerState = audioPlayer1.state;

    audioPlayer1.onPlayerStateChanged.listen((state) async {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer1.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer1.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    setAudio();
  }

  Future<void> setAudioPlayer1(url) async {
    audioPlayer1.setReleaseMode(ReleaseMode.stop);
    await audioPlayer1.play(UrlSource(url));
  }

  Future setAudio() async {
    audioPlayer1.setReleaseMode(ReleaseMode.stop);
    await audioPlayer1.setSourceUrl(widget.url);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.blue),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.1,
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: widget.isSender ? Colors.white : Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () async {
                    if (!isPlaying) {
                      await setAudioPlayer1(widget.url);
                    }
                    else{
                      await audioPlayer1.pause();
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 100,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 10.0),
                  ),
                  child: Slider(
                    autofocus: true,
                    activeColor: widget.isSender ? Colors.white : Colors.black,
                    inactiveColor: Colors.grey,
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer1.seek(position);
                      await audioPlayer1.resume();
                    },
                  ),
                ),
              ),
              Text(formatTime(duration - position),
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.isSender ? Colors.white : Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

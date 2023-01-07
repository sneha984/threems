import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final ap.AudioSource source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;
  final bool message;

  const AudioPlayer({
    required this.source,
    required this.onDelete,
    required this.message,
  });

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));
    _init();

    super.initState();
    print(widget.source);
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(widget.source);
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
   bool _isPlaying=false;
   bool _isPaused=true;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;

  Widget _buildText() {
    if (_isPlaying || _isPaused) {
      return _buildTimer();
    }
    return Container();
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.black),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }
    return numberStr;
  }

  Future<void> _start() async {
    try {


        setState(() {
          _isPlaying = true;
          _recordDuration = 0;
        });
        _startTimer();

    } catch (e) {}
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();

    setState(() => _isPaused = true);
  }
  Future<void> _resume() async {
    _startTimer();

    setState(() => _isPaused = false);
  }
  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(width: 30, child: _buildControl()),
            ),
            SizedBox(
              width: 5,
            ),
            _buildSlider(constraints.maxWidth),
            widget.message
                ? Container()
                : InkWell(
                    onTap: () {
                      _audioPlayer.stop().then((value) => widget.onDelete());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.delete, color: Colors.red, size: 25),
                    ),
                  ),


          ],
        );
      },
    );
  }

  Widget _buildControl() {
    Icon icon;

    if (_audioPlayer.playerState.playing) {
      icon = Icon(Icons.pause, color: Colors.blue, size: 34);
    } else {
      icon = Icon(Icons.play_arrow, color: Colors.green, size: 39);
    }

    return InkWell(
      child: SizedBox(width: 40, child: icon),
      onTap: () {
        if (_audioPlayer.playerState.playing) {
          pause();
        } else {
          play();
        }
      },
    );
  }

  Widget _buildSlider(double widgetWidth) {
    final position = _audioPlayer.position;
    final duration = _audioPlayer.duration;
    bool canSetValue = false;
    if (duration != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }

    return Expanded(
      child: SizedBox(
        child: Row(
          children: [
            Slider(
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              onChanged: (v) {
                if (duration != null) {
                  final position = v * duration.inMilliseconds;
                  _audioPlayer.seek(Duration(milliseconds: position.round()));
                }
              },
              value: canSetValue && duration != null
                  ? position.inMilliseconds / duration.inMilliseconds
                  : 0.0,
            ),

          ],
        ),
      ),
    );
  }

  Future<void> play() {
    try {
      setState(() {
        _isPlaying = true;
        _recordDuration = 0;
      });
      _startTimer();

    } catch (e) {}

    return _audioPlayer.play();
  }

  Future<void> pause() {
    _timer?.cancel();
    _ampTimer?.cancel();

    setState(() => _isPaused = true);

    return _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
}

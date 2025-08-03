import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: VoiceBot());
}

class VoiceBot extends StatefulWidget {
  @override
  _VoiceBotState createState() => _VoiceBotState();
}

class _VoiceBotState extends State<VoiceBot> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Click to talk ';
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() => _text = result.recognizedWords);
          if (result.finalResult) {
            _respond(_text);
            setState(() => _isListening = false);
          }
        });
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  void _respond(String input) async {
    String response = 'أنت قلت: $input';
    await _tts.speak(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice Chatbot')),
      body: Center(child: Text(_text)),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}

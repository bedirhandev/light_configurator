import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String _currentLocale = '';
  String transcription = '';

  Color currentColor = Colors.amber;

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  void initState() {
    super.initState();
    initSpeechRecognition();
  }

  String seekCommando() {
    List<String> singleDigits = [
      'één',
      'twee',
      'drie',
      'vier',
      'vijf',
      'zes',
      'zeven',
      'acht',
      'negen'
    ];

    var words = transcription.split(' ');
    for (num i = 0; i < words.length; i++) {
      if (words[i] == 'Kleur' || words[i] == 'kleur') {
        if (words[i++].isNotEmpty) {
          var value = words[i];
          if (singleDigits.contains(value)) {
            value = (singleDigits.indexOf(value) + 1).toString();
          }
          return value;
        }
      }
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void initSpeechRecognition() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setCurrentLocaleHandler(
        (String locale) => setState(() => _currentLocale = locale));

    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition
        .setRecognitionResultHandler((String speech) => setState(() {
              transcription = speech;
            }));

    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );

    /*_speechRecognition.listen(locale:_currentLocale).then((result)=> print('result : $result'));

    _speechRecognition.cancel();

    _speechRecognition.stop();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Licht configurator"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                colorPickerWidth: MediaQuery.of(context).size.width,
                pickerAreaHeightPercent: 0.69,
                enableAlpha: false,
                displayThumbColor: true,
                enableLabel: true,
                paletteType: PaletteType.hsv,
              ),
              FlatButton(
                  onPressed: () {},
                  color: Colors.red,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Aanpassen ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                      Icon(Icons.adjust, color: Colors.white),
                    ],
                  )),
              /*FlatButton.icon(
                onPressed: () {},
                color: Colors.red,
                
                icon: Icon(Icons.send, color: Colors.white),
                label: Text(
                  "Verstuur",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
              ),*/
              /*Center(
                child: RaisedButton(
                  elevation: 3.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0.0),
                          contentPadding: const EdgeInsets.all(0.0),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                              colorPickerWidth: 300.0,
                              pickerAreaHeightPercent: 0.7,
                              enableAlpha: false,
                              displayThumbColor: true,
                              enableLabel: true,
                              paletteType: PaletteType.hsv,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Klik op mij',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                    ),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ),*/
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1.0, color: Colors.red[900]),
                )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: Text(transcription,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18.0)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red[600],
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.5,
                        child: FloatingActionButton(
                          child: Icon(Icons.cancel),
                          mini: true,
                          backgroundColor: Colors.red[500],
                          onPressed: () {
                            if (_isListening) {
                              _speechRecognition.cancel().then(
                                    (result) => setState(() {
                                          _isListening = result;
                                          transcription = '';
                                        }),
                                  );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Transform.scale(
                        scale: 1.5,
                        child: FloatingActionButton(
                          child: Icon(Icons.mic),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            if (_isAvailable && !_isListening) {
                              print('Started speech recognition');
                              _speechRecognition
                                  .listen(locale: 'nl_NL')
                                  .then((result) => print('$result'));
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Transform.scale(
                        scale: 1.5,
                        child: FloatingActionButton(
                          child: Icon(Icons.stop),
                          mini: true,
                          backgroundColor: Colors.red[500],
                          onPressed: () {
                            if (_isListening) {
                              _speechRecognition.stop().then((result) =>
                                  setState(() => _isListening = result));

                              var value = seekCommando();

                              if (isNumeric(value)) {
                                print('Value: $value');
                              }
                            }
                          },
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ));
  }
}

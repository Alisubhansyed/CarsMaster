// iimport 'dart:io';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({Key? key}) : super(key: key);

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  var _multiPick = true;
  String? _extension = "jpeg,jpg,png";

  List<PlatformFile>? _paths;

  var _directoryPath;

  var _pickingType = FileType.image;

  String? _fileName = "";
  String? _saveAsFileName = "";

  bool _userAborted = false;

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    print("Start");
    if (!mounted) return;
    setState(() {
      _fileName =
          _paths != null ? _paths!.map((e) => e.path).toString() : '...';
      _userAborted = _paths == null;
      print(_fileName);
    });
    print("END");
  }

  void _logException(String message) {
    print(message);
    // _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    // _scaffoldMessengerKey.currentState?.showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("File Upload"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _pickFiles();
                },
                child: Text("File Upload"),
              ),
              Text(_fileName ?? ""),
              SizedBox(
                height: 10,
              ),

              // Image.file(File(_fileName??"")),

              MaterialButton(
                child: const Text("Submit"),
                onPressed: () => {upload()},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> upload() async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath =
        _fileName ?? ""; //'${appDocDir.absolute}/file-to-upload.png';

    try {
      // for a file
      // print(File(filePath).path);
      await File(filePath).exists();
      File(filePath).existsSync();
      File file = File(filePath);
      // print(await file.exists());
    } catch (e) {
      print(e);
    }
  }
}

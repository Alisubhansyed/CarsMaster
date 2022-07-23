// import 'dart:io';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class Cropped extends StatefulWidget {
//   @override
//   _CroppedState createState() => _CroppedState();
// }

// class _CroppedState extends State<Cropped> {
//   XFile? _pickedFile;
//   CroppedFile? _croppedFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: !kIsWeb ? AppBar(title: Text("data")) : null,
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (kIsWeb)
//             Padding(
//               padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
//               child: Text(
//                 "data",
//                 style: Theme.of(context)
//                     .textTheme
//                     .displayMedium!
//                     .copyWith(color: Theme.of(context).highlightColor),
//               ),
//             ),
//           Expanded(child: _body()),
//         ],
//       ),
//     );
//   }

//   Widget _body() {
//     if (_croppedFile != null || _pickedFile != null) {
//       return _imageCard();
//     } else {
//       return _uploaderCard();
//     }
//   }

//   Widget _imageCard() {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
//             child: Card(
//               elevation: 4.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
//                 child: _image(),
//               ),
//             ),
//           ),
//           const SizedBox(height: 24.0),
//           _menu(),
//         ],
//       ),
//     );
//   }

//   Widget _image() {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     if (_croppedFile != null) {
//       final path = _croppedFile!.path;
//       return ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: 0.8 * screenWidth,
//           maxHeight: 0.7 * screenHeight,
//         ),
//         child: kIsWeb ? Image.network(path) : Image.file(File(path)),
//       );
//     } else if (_pickedFile != null) {
//       final path = _pickedFile!.path;
//       return ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: 0.8 * screenWidth,
//           maxHeight: 0.7 * screenHeight,
//         ),
//         child: kIsWeb ? Image.network(path) : Image.file(File(path)),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }

//   Widget _menu() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton(
//           onPressed: () {
//             _clear();
//           },
//           backgroundColor: Colors.redAccent,
//           tooltip: 'Delete',
//           child: const Icon(Icons.delete),
//         ),
//         if (_croppedFile == null)
//           Padding(
//             padding: const EdgeInsets.only(left: 32.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 _cropImage();
//               },
//               backgroundColor: const Color(0xFFBC764A),
//               tooltip: 'Crop',
//               child: const Icon(Icons.crop),
//             ),
//           )
//       ],
//     );
//   }

//   Widget _uploaderCard() {
//     return Center(
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: SizedBox(
//           width: kIsWeb ? 380.0 : 320.0,
//           height: 300.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: DottedBorder(
//                     radius: const Radius.circular(12.0),
//                     borderType: BorderType.RRect,
//                     dashPattern: const [8, 4],
//                     color: Theme.of(context).highlightColor.withOpacity(0.4),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.image,
//                             color: Theme.of(context).highlightColor,
//                             size: 80.0,
//                           ),
//                           const SizedBox(height: 24.0),
//                           Text(
//                             'Upload an image to start',
//                             style: kIsWeb
//                                 ? Theme.of(context)
//                                     .textTheme
//                                     .headline5!
//                                     .copyWith(
//                                         color: Theme.of(context).highlightColor)
//                                 : Theme.of(context)
//                                     .textTheme
//                                     .bodyText2!
//                                     .copyWith(
//                                         color:
//                                             Theme.of(context).highlightColor),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 24.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _uploadImage();
//                   },
//                   child: const Text('Upload'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _cropImage() async {
//     if (_pickedFile != null) {
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: _pickedFile!.path,
//         compressFormat: ImageCompressFormat.jpg,
//         compressQuality: 100,
//         // uiSettings: buildUiSettings(context),
//       );
//       if (croppedFile != null) {
//         setState(() {
//           _croppedFile = croppedFile;
//         });
//       }
//     }
//   }

//   Future<void> _uploadImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _pickedFile = pickedFile;
//       });
//     }
//   }

//   void _clear() {
//     setState(() {
//       _pickedFile = null;
//       _croppedFile = null;
//     });
//   }
// }
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarBrightness: Brightness.dark,
//     statusBarIconBrightness: Brightness.light,
//     systemNavigationBarIconBrightness: Brightness.light,
//   ));

//   runApp(new MyApp());
// }

class Cropped extends StatefulWidget {
  @override
  _CroppedState createState() => new _CroppedState();
}

class _CroppedState extends State<Cropped> {
  final cropKey = GlobalKey<CropState>();

  File? _file;
  File? _sample;
  File? _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample!, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return TextButton(
      child: Text(
        'Open Image',
        style:
            Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(),
    );
  }

  Future<void> _openImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file!,
      preferredHeight: 200,
      preferredWidth: 200,
      // preferredSize: (2000 / 2000).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    debugPrint('$file');
  }
}

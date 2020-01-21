import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sih_test/utils/picture_bottom_modal.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({this.camera});
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraDescription camera;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: ProgressHUD(
        backgroundColor: Colors.blue.withOpacity(0.8),
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            final progressContext = context;
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CameraPreview(_controller),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 60),
                      child: RawMaterialButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;
                            final path = join(
                                (await getTemporaryDirectory()).path,
                                '${DateTime.now()}.png');
                            await _controller.takePicture(path);
                            showModalBottomSheet(
                                isDismissible: false,
                                isScrollControlled: false,
                                context: context,
                                builder: (context) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25.0),
                                          topLeft: Radius.circular(25.0),
                                        ),
                                      ),
                                      child: PictureBottomModal(
                                        imagePath: path,
                                        progressContext: progressContext,
                                      ));
                                });
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) =>
//                                    DisplayPictureScreen(imagePath: path)),
//                          );
                          } catch (e) {
                            print(e);
                          }
                        },
                        fillColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          'Take Picture',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

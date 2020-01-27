import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/auth.dart';
import 'package:sih_test/services/firebase_storage_service.dart';
import 'package:sih_test/utils/upload_bottom_modal.dart';

class PictureBottomModal extends StatefulWidget {
  final String imagePath;
  final BuildContext progressContext;

  PictureBottomModal({this.imagePath, this.progressContext});

  @override
  _PictureBottomModalState createState() => _PictureBottomModalState();
}

class _PictureBottomModalState extends State<PictureBottomModal> {
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'REVIEW',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.file(
                File(widget.imagePath),
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.green,
                      onPressed: () async {
                        setState(() {
                          _uploading = true;
                        });
                        final user = await getCurrentUser();
                        var imageRef;
                        Provider.of<FirebaseStorageService>(context,
                                listen: false)
                            .uploadFile(user.uid, widget.imagePath)
                            .then((value) {
                          imageRef = value;
                          print(imageRef);
                          setState(() {
                            _uploading = false;
                          });
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25.0),
                                          topLeft: Radius.circular(25.0),
                                        ),
                                      ),
                                      child: UploadBottomModal(
                                        imageRef: imageRef,
                                        uid: user.uid,
                                        progressContext: widget.progressContext,
                                        imagePath: widget.imagePath,
                                      )),
                                );
                              });
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check,
                            size: 25.0,
                          ),
                          Text(
                            'OK, Continue.',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {
                        File(widget.imagePath).delete();
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.clear,
                            size: 25.0,
                          ),
                          Text(
                            'Retake the picture',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/firestore_service.dart';
import 'package:sih_test/utils/leader_box.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width / 4.5,
          padding: EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 40.0,
              ),
              Text(
                'LEADERBOARD',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.exit_to_app,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<FirestoreService>(context).getLeaderboard(),
            builder: (context, snapshot) {
              final _loader = FutureBuilder(
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print('Done');
                      return Center(
                        child: Text(
                          'No users found.',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 50.0,
                          maxHeight: 50.0,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  });
              if (snapshot.data != null) {
                if (snapshot.data.documents.isEmpty) {
                  return _loader;
                }
                var docs = snapshot.data.documents;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: LeaderBox(
                        index: index + 1,
                        name: docs[index].data['displayName'],
                        points: docs[index].data['points'],
                      ),
                    );
                  },
                );
              }
              return _loader;
            },
          ),
        )
      ],
    );
  }
}

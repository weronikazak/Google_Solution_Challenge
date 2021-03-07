import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc_project/Services/auth.dart';

import '../../constants.dart';
import 'arguments.dart';

class ShelterMainPage extends StatelessWidget {
  const ShelterMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArgsSettings args = ModalRoute.of(context).settings.arguments;
    print("SENT ARGUMENTS " + args.toString());

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kPrimaryColor),
          title: Text("Go back"),
          foregroundColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                    icon: Icon(Icons.logout));
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: kPrimaryColor,
                    child: (args.image != null)
                        ? ClipOval(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              // TODO: pass arguments from the Shelter Details page
                              // child: Image.file(
                              //   args.image,
                              //   fit: BoxFit.fill,
                              // ),
                              child: Image.asset(
                                "assets/icons/house.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : ClipRect(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                "assets/icons/house.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                  Text(
                    args.name,
                    style: TextStyle(color: kPrimaryColor, fontSize: 30),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

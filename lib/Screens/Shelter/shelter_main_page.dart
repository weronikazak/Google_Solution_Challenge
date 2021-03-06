import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'arguments.dart';

class ShelterMainPage extends StatelessWidget {
  const ShelterMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final ArgsSettings args = ModalRoute.of(context).settings.arguments;
    ArgsSettings args;

    return Scaffold(
        body: Container(
      child: ListView(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundColor: kPrimaryColor,
                  child: (args.image != null)
                      ? ClipOval(
                          child: SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.file(
                              args.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : ClipRect(
                          child: SizedBox(
                            width: 90,
                            height: 90,
                            child: Image.asset(
                              "assets/icons/house.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

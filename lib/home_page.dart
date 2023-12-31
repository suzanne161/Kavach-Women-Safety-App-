import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kavach2/add_contact.dart';
import 'package:kavach2/articles.dart';
import 'package:kavach2/services/auth.dart';
import 'package:kavach2/settings.dart';
import 'package:kavach2/signin.dart';
import 'package:kavach2/video_library.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userName, userEmail, imageURL;
  bool notificationsAllowed = false;
  @override
  // void initState() {
  //   super.initState();
  //
  //   // Prepare elements for drawer widget
  //   SharedPreferenceHelper.getUserNameKey()
  //       .then((value) => setState(() => {userName = value!}));
  //   SharedPreferenceHelper.getUserEmail()
  //       .then((value) => setState(() => {userEmail = value!}));
  //   SharedPreferenceHelper.getUserProfilePicKey()
  //       .then((value) => setState(() => {imageURL = value!}));
  //
  //   // Ensure Notifications are Allowed
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //     setState(() {
  //       notificationsAllowed = isAllowed;
  //     });
  //
  //     if (!isAllowed) {
  //       requestUserPermission(isAllowed);
  //     } else {
  //       // log('Notifications are allowed');
  //     }
  //   });
  //
  //   NotificationMethods.createNullProgressNotification(1337);
  //   ListenToNotificationStream.createdStream();
  //   ListenToNotificationStream.displayedStream();
  //   ListenToNotificationStream.actionStream();
  //
  //   // Update SOS Shared Prefs
  //   SharedPreferenceHelper.getMessageHead().then((value) async {
  //     if (value != null) {
  //       print('MessageHead is $value');
  //     } else {
  //       print('MessageHead is $value');
  //       value = "I'm in trouble, plz help me. Reach this location:";
  //       SharedPreferenceHelper.saveMessageHead(value);
  //     }
  //   });
  //
  //   SharedPreferenceHelper.getSOSdelayTime().then((value) async {
  //     if (value != null) {
  //       print('SOSdelayTime is $value');
  //     } else {
  //       print('SOSdelayTime is $value');
  //       value = 10;
  //       SharedPreferenceHelper.saveSOSdelayTime(value);
  //     }
  //   });
  //
  //   SharedPreferenceHelper.getSOSrepeatInterval().then((value) async {
  //     if (value != null) {
  //       print('SOS repeat interval is $value');
  //     } else {
  //       print('SOS repeat interval is $value');
  //       value = 120;
  //       SharedPreferenceHelper.saveSOSrepeatInterval(value);
  //     }
  //   });
  // }

  // void requestUserPermission(bool isAllowed) async {
  //   showDialog(
  //     context: context,
  //     builder: (_) => NetworkGiffDialog(
  //       buttonOkText: Text(
  //         'Allow',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       buttonCancelText: Text(
  //         'Later',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       buttonCancelColor: Colors.grey,
  //       buttonOkColor: Colors.deepPurple,
  //       buttonRadius: 0.0,
  //       image:
  //           Image.asset("assets/images/animated-bell.gif", fit: BoxFit.cover),
  //       title: Text(
  //         'Get Notified!',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
  //       ),
  //       description: Text(
  //         'Allow Awesome Notifications to send you beautiful notifications!',
  //         textAlign: TextAlign.center,
  //       ),
  //       entryAnimation: EntryAnimation.normal,
  //       onCancelButtonPressed: () async {
  //         Navigator.of(context).pop();
  //         notificationsAllowed =
  //             await AwesomeNotifications().isNotificationAllowed();
  //         setState(
  //           () {
  //             notificationsAllowed = notificationsAllowed;
  //           },
  //         );
  //       },
  //       onOkButtonPressed: () async {
  //         Navigator.of(context).pop();
  //         await AwesomeNotifications().requestPermissionToSendNotifications();
  //         notificationsAllowed =
  //             await AwesomeNotifications().isNotificationAllowed();
  //         setState(
  //           () {
  //             notificationsAllowed = notificationsAllowed;
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          " Kavach ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // new UserAccountsDrawerHeader(
            //   accountName: new Text(userName == null ? "" : userName),
            //   accountEmail: new Text(userEmail == null ? "" : userEmail),
            //   currentAccountPicture: imageURL == null
            //       ? Icon(Icons.account_circle_rounded, size: 55)
            //       : new CircleAvatar(backgroundImage: NetworkImage(imageURL)),
            // ),
            new ListTile(
              title: Text("Settings"),
              subtitle: Text("SOS delay, Edit SOS message..."),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              trailing: FittedBox(
                child: Icon(Icons.settings, size: 35),
              ),
            ),
            new ListTile(
              title: Text("Logout"),
              tileColor: Colors.grey[300],
              onTap: () {
                AuthMethods().signOut();
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              trailing: SvgPicture.asset(
                "assets/icons/log-out.svg",
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            color: Colors.transparent,
            child: Center(
              child: Wrap(
                spacing: 20, // to apply margin in the main axis of the wrap
                runSpacing: 20, // to apply margin in the cross axis of the wrap
                children: [
                  ButtonTheme(
                    buttonColor: Colors.white,
                    height: 200,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Articles()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                "assets/icons/law.svg",
                                height: size.height * 0.1,
                              ),
                            ),
                            Text(
                              "Women Safety Laws",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: Colors.white,
                    height: 200,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoLib()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/icons/self.svg",
                                height: size.height * 0.1,
                              ),
                            ),
                            Text(
                              "Crime Detection and Self Defence Tips",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
                  child: Column(
                    children: [
                      Text(
                        "Send Emergency",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 21,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
                        child: Text(
                          "SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: SvgPicture.asset(
                      "assets/icons/alert.svg",
                      height: size.height * 0.1,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // _triggerSendSOS();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, right: 60, left: 60),
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 8, bottom: 8, right: 8),
                          child: SvgPicture.asset(
                            "assets/icons/add_alert.svg",
                            height: size.height * 0.05,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Add Contacts",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddContacts()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  // void _triggerSendSOS() async {
  //   int? count = await databaseHelper.getCount();
  //
  //   if (count == 0) {
  //     Fluttertoast.showToast(msg: 'Please Add Trusted contacts to send SOS.');
  //   } else {
  //     Fluttertoast.showToast(msg: 'Sending SOS...');
  //     NotificationMethods.showProgressNotification(1337);
  //   }
  // }
}

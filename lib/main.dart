import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor/provider/detail_provider.dart';
import 'package:platform_convertor/screen/addcontactscreen.dart';
import 'package:platform_convertor/screen/addcontactscreenIOS.dart';
import 'package:platform_convertor/screen/call_screen.dart';
import 'package:platform_convertor/screen/call_screen_ios.dart';
import 'package:platform_convertor/screen/chatScreen.dart';
import 'package:platform_convertor/screen/chatsScreen_ios.dart';
import 'package:platform_convertor/screen/settings_screen.dart';
import 'package:platform_convertor/screen/settings_screen_ios.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => detailprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 1;
  List pageList = [
    const addcontactscreenIOS(),
    const chatScreenIOS(),
    const callScreenIOS(),
    const settingsScreenIOS(),
  ];
  void onTap(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (Provider.of<detailprovider>(context, listen: false).isDarkView)
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),
      home: Consumer<detailprovider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 4,
          initialIndex: currentIndex,
          child: Scaffold(
            appBar: AppBar(
              bottom: (!provider.isIOS)
                  ? TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: (provider.isDarkView) ? Colors.white : null,
                          ),
                        ),
                        Tab(
                          child: Text(
                            "CHATS",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  (provider.isDarkView) ? Colors.white : null,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "CALLS",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  (provider.isDarkView) ? Colors.white : null,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "SETTINGS",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  (provider.isDarkView) ? Colors.white : null,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  : null,
              toolbarHeight: 70,
              actions: [
                (Provider.of<detailprovider>(context, listen: false).isIOS)
                    ? CupertinoSwitch(
                        onChanged: (val) {
                          Provider.of<detailprovider>(context, listen: false)
                              .changePlatform();
                        },
                        value: Provider.of<detailprovider>(context).isIOS,
                      )
                    : Switch(
                        inactiveThumbColor:
                            (provider.isDarkView) ? Colors.white : null,
                        value: Provider.of<detailprovider>(context, listen: false)
                            .isIOS,
                        onChanged: (val) {
                          Provider.of<detailprovider>(context, listen: false)
                              .changePlatform();
                        },
                      ),
              ],
              title: const Text("Platform Converter"),
            ),
            body: (!provider.isIOS)
                ? TabBarView(
                    children: [
                      (Provider.of<detailprovider>(context, listen: false).isIOS)
                          ? const addcontactscreenIOS()
                          : const addcontactscreen(),
                      (Provider.of<detailprovider>(context, listen: false).isIOS)
                          ? const chatScreenIOS()
                          : const chatScreen(),
                      (Provider.of<detailprovider>(context, listen: false).isIOS)
                          ? const callScreenIOS()
                          : const callScreen(),
                      (Provider.of<detailprovider>(context, listen: false).isIOS)
                          ? const settingsScreenIOS()
                          : const settingsScreen(),
                    ],
                  )
                : pageList[currentIndex],
            bottomNavigationBar: (provider.isIOS)
                ? BottomNavigationBar(
                    currentIndex: currentIndex,
                    enableFeedback: true,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.person_add,
                          color: Colors.blue,
                        ),
                        label: "Add",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: Colors.blue,
                        ),
                        label: "Chats",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.phone_circle,
                          color: Colors.blue,
                        ),
                        label: "Add",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.settings,
                          color: Colors.blue,
                        ),
                        label: "Add",
                      ),
                    ],
                    onTap: onTap,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertor/globals/utils.dart';
import 'package:platform_convertor/provider/detail_provider.dart';
import 'package:provider/provider.dart';

class chatScreenIOS extends StatefulWidget {
  const chatScreenIOS({super.key});

  @override
  State<chatScreenIOS> createState() => _chatScreenIOSState();
}

class _chatScreenIOSState extends State<chatScreenIOS> {
  @override
  Widget build(BuildContext context) {
    return Consumer<detailprovider>(
      builder: (context, provider, child) => Scaffold(
        body: (Global.allContacts.isEmpty)
            ? Center(
                child: Text(
                  'No any chats yet...',
                  style: TextStyle(
                    color: (provider.isDarkView) ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Column(
                children: Global.allContacts
                    .map((e) => GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: Text(
                                        "${e.name![0].toUpperCase()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    ),
                                    Text(
                                      "${e.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CupertinoButton(
                                          child: Icon(
                                            CupertinoIcons.pencil,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {},
                                        ),
                                        CupertinoButton(
                                          child: Icon(
                                            CupertinoIcons.delete,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.15),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        e.name![0].toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e.name}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${e.chat}",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          (provider.selectedDate == "Pick Date")
                                              ? provider.selectedDate
                                                  .substring(0, 9)
                                              : provider.selectedDate
                                                  .substring(0, 10),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          (provider.selectedTime == "Pick Time")
                                              ? provider.selectedTime
                                                  .substring(0, 9)
                                              : provider.selectedTime
                                                  .substring(10, 15),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}

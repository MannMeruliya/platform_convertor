import 'package:flutter/material.dart';
import 'package:platform_convertor/globals/utils.dart';
import 'package:platform_convertor/provider/detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class callScreen extends StatefulWidget {
  const callScreen({super.key});

  @override
  State<callScreen> createState() => _callScreenState();
}

class _callScreenState extends State<callScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<detailprovider>(
      builder: (context, provider, child) => Scaffold(
        body: (Global.allContacts.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No any calls yet...',
                      style: TextStyle(
                        color:
                            (provider.isDarkView) ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            : Column(
                children: Global.allContacts
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${e.name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "+91 ${e.num}",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() async {
                                    final Uri launchUri = Uri(
                                      scheme: 'tel',
                                      path: e.num,
                                    );
                                    await launchUrl(launchUri);
                                  });
                                },
                                icon: Icon(
                                  Icons.call,
                                  color: (provider.isDarkView)
                                      ? Colors.white
                                      : Colors.green,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

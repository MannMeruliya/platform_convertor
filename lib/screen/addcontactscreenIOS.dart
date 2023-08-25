import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/globals/models.dart';
import 'package:platform_convertor/globals/utils.dart';
import 'package:platform_convertor/provider/detail_provider.dart';
import 'package:platform_convertor/screen/addcontactscreen.dart';
import 'package:provider/provider.dart';

class addcontactscreenIOS extends StatefulWidget {
  const addcontactscreenIOS({Key? key}) : super(key: key);

  @override
  State<addcontactscreenIOS> createState() => _addcontactscreenIOSState();
}

ImagePicker picker = ImagePicker();

class _addcontactscreenIOSState extends State<addcontactscreenIOS> {
  @override
  Widget build(BuildContext context) {
    return Consumer<detailprovider>(
      builder: (context, provider, child) => CupertinoPageScaffold(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.white,
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                child: Text(
                                  "Camera",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  XFile? img = await picker.pickImage(
                                    source: ImageSource.camera,
                                  );

                                  setState(() {
                                    Global.image = File(img!.path as String);
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoButton(
                                child: Text(
                                  "Photos",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  XFile? img = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  setState(() {
                                    Global.image = File(img!.path as String);
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoButton(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                alignment: AlignmentDirectional.topEnd,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 60,
                      foregroundImage: (Global.image != null)
                          ? FileImage(Global.image as File)
                          : null,
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: adddetailkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter First Name",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        controller: namecontroller,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: (provider.isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        onSaved: (val) {
                          Global.name = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter First Name First....";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Enter Phone Number",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        onSaved: (val) {
                          Global.num = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Phone Number First....";
                          }
                          if (val.length != 10) {
                            return "Enter Correct Phone Number....";
                          }
                          return null;
                        },
                        controller: numcontroller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: (provider.isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Enter Chat Conversation",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      CupertinoTextFormFieldRow(
                        onSaved: (val) {
                          Global.chat = val;
                        },
                        controller: chatscontroller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: (provider.isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.calendar),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 300,
                          width: double.infinity,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            minimumYear: 1900,
                            maximumYear: 3000,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (val) {
                              setState(
                                () {
                                  provider.selectedDate = val.toString();
                                },
                              );
                              // print(provider.selectedDate);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      (provider.selectedDate == "Pick Date")
                          ? provider.selectedDate.substring(0, 9)
                          : provider.selectedDate.substring(0, 10),
                      style: TextStyle(
                        color:
                            (Provider.of<detailprovider>(context, listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.clock),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          height: 300,
                          width: double.infinity,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            use24hFormat: false,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (time) => setState(
                              () {
                                provider.selectedTime = time.toString();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      // provider.selectedTime,
                      (provider.selectedTime == "Pick Time")
                          ? provider.selectedTime.substring(0, 9)
                          : provider.selectedTime.substring(11, 16),
                      style: TextStyle(
                        color:
                            (Provider.of<detailprovider>(context, listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                color: (provider.isDarkView) ? Colors.blue : Colors.blue,
                onPressed: () {
                  if (adddetailkey.currentState!.validate()) {
                    adddetailkey.currentState!.save();

                    detail d1 = detail(
                      name: Global.name,
                      num: Global.num,
                      chat: Global.chat,
                      image: Global.image,
                    );
                    Global.allContacts.add(d1);
                  }
                  print(Global.name);
                  print(Global.num);
                  print(Global.chat);

                  setState(
                    () {
                      adddetailkey.currentState!.reset();

                      namecontroller.clear();
                      numcontroller.clear();
                      chatscontroller.clear();
                    },
                  );
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

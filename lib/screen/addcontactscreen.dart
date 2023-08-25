import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convertor/globals/models.dart';
import 'package:platform_convertor/globals/utils.dart';
import 'package:platform_convertor/provider/detail_provider.dart';
import 'package:provider/provider.dart';

class addcontactscreen extends StatefulWidget {
  const addcontactscreen({Key? key}) : super(key: key);

  @override
  State<addcontactscreen> createState() => _addcontactscreenState();
}

ImagePicker picker = ImagePicker();

GlobalKey<FormState> adddetailkey = GlobalKey<FormState>();

TextEditingController namecontroller = TextEditingController();
TextEditingController numcontroller = TextEditingController();
TextEditingController chatscontroller = TextEditingController();

class _addcontactscreenState extends State<addcontactscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<detailprovider>(
        builder: (context, provider, child) =>
            SingleChildScrollView(
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
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Align(
                              alignment: Alignment.topLeft,
                              child: Text("Options"),
                            ),
                            content: const Text(
                              "Choose an option to add photo",
                            ),
                            icon: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.clear),
                              ),
                            ),
                            actions: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        child: const Text(
                                          "Camera",
                                        ),
                                        onPressed: () async {
                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.camera,
                                          );

                                          setState(() {
                                            Global.image =
                                                File(img!.path as String);
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text("Gallery"),
                                        onPressed: () async {
                                          XFile? img = await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );

                                          setState(() {
                                            Global.image =
                                                File(img!.path as String);
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color(0xffeadeff),
                      radius: 60,
                      foregroundImage: (Global.image != null)
                          ? FileImage(Global.image as File)
                          : null,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color:
                            (Provider.of<detailprovider>(context, listen: false)
                                    .isDarkView)
                                ? Colors.purple.shade900
                                : null,
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
                      TextFormField(
                        onSaved: (val) {
                          Global.name = val;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter First Name First....";
                          }
                          return null;
                        },
                        controller: namecontroller,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Full Name",
                          icon: Icon(
                            Icons.person,
                            color: (Provider.of<detailprovider>(context,
                                        listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: (Provider.of<detailprovider>(context,
                                        listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                          border: const OutlineInputBorder(),
                          hintText: "Phone Number",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          Global.chat = val;
                        },
                        controller: chatscontroller,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Chat Conversation",
                          icon: Icon(
                            Icons.chat_outlined,
                            color: (Provider.of<detailprovider>(context,
                                        listen: false)
                                    .isDarkView)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: (Provider.of<detailprovider>(context, listen: false)
                              .isDarkView)
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(3000),
                      ).then(
                        (value) => provider.setSelectedDate(value!),
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
                    width: 5,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: (Provider.of<detailprovider>(context, listen: false)
                              .isDarkView)
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) => provider.setSelectedTime(value!));
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      // provider.selectedTime,
                      (provider.selectedTime == "Pick Time")
                          ? provider.selectedTime.substring(0, 9)
                          : provider.selectedTime.substring(10, 15),
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
              ElevatedButton(
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

                  setState(
                    () {
                      adddetailkey.currentState!.reset();

                      namecontroller.clear();
                      numcontroller.clear();
                      chatscontroller.clear();
                    },
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

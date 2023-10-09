// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_proj/screens/home_page.dart';
import 'package:flutter_proj/utils/colors.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  List<String> items = ['Text Widget', 'Image Widget', 'Button Widget'];
  bool helo = false;

  @override
  void initState() {
    if (!mounted) {
      Home.btn.value = false;
      Home.img.value = false;
      Home.text.value = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.green.shade100,
        body: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * .4,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Checkbox(
                            value: Home.text.value,
                            onChanged: (value) {
                              setState(() {
                                Home.text.value = value!;
                              });
                            }),
                        Text(items[0])
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * .4,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Checkbox(
                            value: Home.img.value,
                            onChanged: (value) {
                              setState(() {
                                Home.img.value = value!;
                              });
                            }),
                        Text(items[1])
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * .4,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        Checkbox(
                            value: Home.btn.value,
                            onChanged: (value) {
                              setState(() {
                                Home.btn.value = value!;
                              });
                            }),
                        Text(items[2])
                      ],
                    ),
                  )
                ],
              ),
              Spacer(
                flex: 4,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)
                ),
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: Text("Import Widget",style: TextStyle(color: baseColor),),
              ),
              Spacer()
            ],
          ),
        ));
  }
}

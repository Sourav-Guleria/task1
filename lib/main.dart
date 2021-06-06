import 'package:first_app/DummyData.dart';
import 'package:first_app/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:readmore/readmore.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataCollection loadedData;
  bool isloading = false;
  Future fetchData() async {
    setState(() {
      isloading = !isloading;
    });
    http.Client _httpClient = new http.Client();
    var response = await _httpClient
        .get(Uri.parse('http://nexever.in/demo/api.php?dummy_info'));

    if (response.statusCode == 200) {
      setState(() {
        isloading = !isloading;
        loadedData = DataCollection.fromJson(json.decode(response.body));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void deleteData(int index) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          loadedData.dummyDetails.dummyData.removeAt(index);
        });
      },
    );
    Widget continueButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fetch Data'),
        backgroundColor: Colors.teal[200],
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  margin: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute<List<DummyData>>(
                                builder: (BuildContext context) => DetailScreen(
                                    loadedData.dummyDetails.dummyData, index),
                              ),
                            )
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  loadedData.dummyDetails.dummyData = value;
                                });
                              }
                            });
                          },
                          child: Image.network(
                            loadedData.dummyDetails.dummyData[index].image,
                            errorBuilder: (a, b, c) => Icon(Icons.broken_image),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              color: Colors.red,
                              onPressed: () => deleteData(index),
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        )
                      ]),
                      Row(
                        children: [
                          Expanded(
                            child: Text(loadedData
                                    ?.dummyDetails?.dummyData[index]?.title ??
                                ""),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(loadedData
                                      ?.dummyDetails?.dummyData[index]?.time ??
                                  ""),
                              Text(loadedData
                                      ?.dummyDetails?.dummyData[index]?.date ??
                                  ""),
                            ],
                          ),
                        ],
                      ),
                      ReadMoreText(
                        loadedData
                                ?.dummyDetails?.dummyData[index]?.description ??
                            "",
                        trimLines: 3,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
              itemCount: loadedData?.dummyDetails?.dummyData?.length ?? 0,
            ),
    );
  }
}

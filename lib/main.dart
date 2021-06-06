import 'package:first_app/DummyData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        print(json.decode(response.body));
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
 void deleteData() {

       setState(() {
                
              });
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
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        
                        Image.network(loadedData.dummyDetails.dummyData[index].image),
            

                        Text(loadedData
                                  ?.dummyDetails?.dummyData[index]?.title ??
                              ""),

                        Text(loadedData
                                  ?.dummyDetails?.dummyData[index]?.description ??
                              ""),
                      
                          Text(loadedData
                                  ?.dummyDetails?.dummyData[index]?.time ??
                              ""),
                          Text(loadedData
                                  ?.dummyDetails?.dummyData[index]?.date ??
                              ""),
                        ],
                      ),
                    )));
              },
              itemCount: loadedData?.dummyDetails?.dummyData?.length ?? 0,
              
               
            ), 
    );
  }
}

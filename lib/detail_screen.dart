import 'package:first_app/DummyData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailScreen extends StatelessWidget {
  final List<DummyData> dummyData;
  final int index;
  DetailScreen(this.dummyData, this.index);
  
  void deleteData(int index, context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        dummyData.removeAt(index);
        Navigator.of(context).pop();
        Navigator.pop(context, dummyData);
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
          centerTitle: true,
          title: Text(dummyData[index].title),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              child: PhotoView(
                imageProvider: NetworkImage(dummyData[index].image),
              ),
            ),
            Text("Title"),
            Text(dummyData[index].title),
            Text("Description"),
            Text(dummyData[index].description),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: () => deleteData(index, context),
                    child: Text("Delete")),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

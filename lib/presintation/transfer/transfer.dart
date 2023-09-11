import 'package:flutter/material.dart';

import '../card/add_card.dart';

List<List<String>> data = [["Ipak Yo'li", "Uzcard", "2222 3333 6666 4444", "11/25"]];
class Transfer extends StatefulWidget {
  String name;
  String type;
  String code;
  String date;

  Transfer(
      {required this.name,
        required this.type,
        required this.code,
        required this.date});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    print(data);
    list.add(widget.name);
    list.add(widget.type);
    list.add(widget.date);
    list.add(widget.code);
    data.add(list);
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Text("Clear"),
            onPressed: () {
              setState(() {
                data.clear();
              });
            },
          ),
        ],
        centerTitle: true,
        title: Text("Transfer"),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: 200,
              width: 300,
              child: Center(
                child: Card(
                  color: Colors.blueAccent,
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 6, bottom: 5),
                  elevation: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${data[index][0]}",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "${data[index][1]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Center(
                          child: Text(
                            "${data[index][2]}",
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "${data[index][3]}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KartaAdd(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}

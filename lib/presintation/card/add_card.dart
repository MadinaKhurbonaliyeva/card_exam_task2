

import 'package:flutter/material.dart';

import '../transfer/transfer.dart';


class KartaAdd extends StatefulWidget {
  const KartaAdd({Key? key}) : super(key: key);
  @override
  State<KartaAdd> createState() => _KartaAddState();
}
class _KartaAddState extends State<KartaAdd> {

  TextEditingController textEditingController0 = TextEditingController();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  getData() {
    setState(() {
      if (textEditingController0.text.isNotEmpty &&
          textEditingController1.text.isNotEmpty &&
          textEditingController2.text.isNotEmpty &&
          textEditingController3.text.isNotEmpty)
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Transfer(
                name: textEditingController0.text,
                type: textEditingController1.text,
                code: textEditingController2.text,
                date: textEditingController3.text,
              ),
            ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card add"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: textEditingController0,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Card name",
                hintText: "Card Name",
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            TextFormField(
              controller: textEditingController1,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelText: "Card name",
                hintText: "Card Name",
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            TextFormField(
              controller: textEditingController2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Card Number",
                hintText: "Card Number",
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            TextFormField(
              controller: textEditingController3,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: "Card date",
                hintText: "Card date",
              ),
            ),
            const SizedBox(
              width: 10,
              height: 20,
            ),
            TextButton(
              onPressed: () {
                getData();
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

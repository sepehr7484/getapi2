import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class GetApi extends StatefulWidget {
  @override
  _GetApi createState() => _GetApi();
}

class _GetApi extends State<GetApi> {
  late Map data;
  late List userdata;
  Future getdata() async {
    var url = Uri.parse('https://reqres.in/api/users?page=2');
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      userdata = data["data"];
    });
    print(response.statusCode);
    print(userdata.toString());
    print(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: userdata == null ? 0 : userdata.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 70,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: ListTile(
                  focusColor: Colors.red,
                  onTap: () {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(userdata[index]['email'])));
                  },
                  title: Text(userdata[index]['first_name']),
                  subtitle: Text(userdata[index]['last_name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userdata[index]['avatar']),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

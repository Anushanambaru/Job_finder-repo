
import 'package:flutter/material.dart';

class SearchPage extends State<StatefulWidget> {

  final String photo;
  final String text;
  final String role;
  final String job;
  final String vacancy;
  final String email;
  final String phone;
  final String requirement;



  SearchPage({
    required this.photo,
    required this.text,
    required this.role,
    required this.job,
    required this.vacancy,
    required this.email,
    required this.phone,
    required this.requirement,

  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children:[
      //       Row(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Image(image: NetworkImage('Photo url'),height: 100,width: 200,),
      //           Column(
      //             children: [ Padding(padding: EdgeInsets.all(0.0)),
      //               Text(
      //                 widget.text,
      //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //             ],
      //           ),
      //           Column(children: [
      //             Padding(padding: EdgeInsets.all(0.0)),
      //             Text(
      //               widget.vacancy,
      //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //
      //           ),
      //           Column(
      //             children: [
      //               Padding(padding: EdgeInsets.all(0.0)),
      //               Text(
      //                 widget.vacancy,
      //                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //             ],
      //           ),
      //
      //         ],
      //       ),
      //       Column(crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Padding(padding: EdgeInsets.all(0.0)),
      //           Text(
      //             widget.vacancy,
      //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //           ),
      //           const SizedBox(height: 25,),
      //           Padding(padding: EdgeInsets.all(0.0)),
      //           Text(
      //             widget.vacancy,
      //             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //           ),
      //         ],
      //       ),
      //       Padding(padding: EdgeInsets.all(0.0)),
      //       FloatingActionButton(onPressed:
      //           () {
      //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyFormPage()));
      //       }
      //
      //       ),
      //     ],
      //   ),
      // ),
    ),
    );
  }
}





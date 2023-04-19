import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';



class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
// saving the userdata
  Future savingUserData(String fullName, String email)
  async { final now = DateTime.now();
  final String createdAt = '${now.year}-${now.month}-${now.day}';
  final String? token = await FirebaseMessaging.instance.getToken();
  if (token == null) return false;
  return await userCollection.doc(uid).set({
    "fullName": fullName,
    "email": email,
    "groups": [],
    "profilePic": "",
    "uid": uid,
    "createdAt": createdAt,
    "platform": Platform.operatingSystem,
    "token": token, });
  }
}
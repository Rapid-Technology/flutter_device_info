import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Device Info"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Platform.isAndroid
          ? showAndroidInfo()
          : Platform.isIOS
              ? showIOSInfo()
              : Container(),
    );
  }

  showAndroidInfo() {
    return FutureBuilder(
      future: deviceInfoPlugin.androidInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          AndroidDeviceInfo info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                item('Android Model', info.model),
                item('Android Brand', info.brand),
                item('Android Device', info.device),
                item('Android Hardware', info.hardware),
                item('Android Host', info.host),
                item('Android ID', info.id),
                item('Android Is Physical', info.isPhysicalDevice.toString()),
                item('Android SDK Int', info.version.sdkInt.toString()),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  showIOSInfo() {
    return FutureBuilder(
      future: deviceInfoPlugin.iosInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          IosDeviceInfo info = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                item('Device Model', info.model),
                item('Device Name', info.name),
                item('System Name', info.systemName),
                item('System Version', info.systemVersion),
                item('Device Is Physical', info.isPhysicalDevice.toString()),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

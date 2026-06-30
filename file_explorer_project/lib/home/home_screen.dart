import 'package:flutter/material.dart';

import '../file services/file_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FileServices _fileServices = FileServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Create New Folder",
            onPressed: () async {
              await _fileServices.createFolder("tpm folder");
            },
            icon: Icon(Icons.create_new_folder_outlined),
          ),
          IconButton(
            tooltip: "Create New File",
            onPressed: () async {
              await _fileServices.writeFile("tpm file", "");
            },
            icon: Icon(Icons.upload_file_outlined),
          ),
        ],
      ),
    );
  }
}

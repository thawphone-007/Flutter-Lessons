import 'dart:io';
import 'package:flutter/material.dart';
import '../file services/file_services.dart';
import 'create_new_file_dialog_widget.dart';
import 'create_new_folder_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FileServices _fileServices = FileServices();
  List<Directory> _currentFolderList = [];
  List<File> _currentFileList = [];

  String _currentLocation = "";

  @override
  void initState() {
    super.initState();
    _loadFileAndFolder(_currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Create New Folder",
            onPressed: () {
              // async မလိုအပ်
              _createNewFolder("");
            },
            icon: Icon(Icons.create_new_folder_sharp),
          ),
          IconButton(
            tooltip: "Create New File",
            onPressed: () {
              // async မလိုအပ်
              _createNewFile("");
            },
            icon: Icon(Icons.note_add_sharp),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ListTile(
              dense: true,
              title: Text(_currentLocation.isEmpty ? "/" : _currentLocation),
            ),
          ),
          SliverList.builder(
            itemCount: _currentFolderList.length,
            itemBuilder: (context, index) {
              Directory directory = _currentFolderList[index];

              String folderName = directory.path.split("/").last;
              return ListTile(
                onTap: () {
                  String folderLocation = "$_currentLocation/$folderName";
                  _currentLocation = folderLocation;
                  _loadFileAndFolder(folderLocation);
                },
                leading: Icon(Icons.folder),
                title: Text(directory.path.split("/").last),
                subtitle: Text(directory.statSync().changed.toString()),
              );
            },
          ),
          SliverList.builder(
            itemCount: _currentFileList.length,
            itemBuilder: (context, index) {
              File file = _currentFileList[index];
              return ListTile(
                leading: Icon(Icons.insert_drive_file_outlined),
                title: Text(file.path.split("/").last),
                subtitle: Text(file.statSync().changed.toString()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _loadFileAndFolder(String path) async {
    _currentFolderList = await _fileServices.getFolderList(path);
    _currentFileList = await _fileServices.getFileList(path);
    setState(() {});
  }

  void _createNewFolder(String path) async {
    bool isOK = await showDialog(
      context: context,
      builder: (context) {
        return CreateNewFolderDialogWidget(
          currentLocation: "$_currentLocation/",
        );
      },
    );
    if (isOK) {
      _loadFileAndFolder(_currentLocation);
    }
  }

  void _createNewFile(String path) async {
    bool isOK = await showDialog(
      context: context,
      builder: (context) {
        return CreateNewFileDialogWidget(currentLocation: "$_currentLocation/");
      },
    );
    if (isOK) {
      _loadFileAndFolder("");
    }
  }
}

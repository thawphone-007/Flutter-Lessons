import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileServices {
  Future<Directory> getRootDirectory() {
    return getApplicationDocumentsDirectory();
  }

  Future<Directory> createFolder(
    String folderName, {
    Function(String status)? status,
  }) async {
    Directory root = await getRootDirectory();
    Directory myFolder = Directory("${root.path}/$folderName");
    bool isExist = await myFolder.exists();

    if (!isExist) {
      await myFolder.create(recursive: true);
      status?.call("Successfully Created");
    } else {
      status?.call("Folder already Exist");
    }
    return myFolder;
  }

  Future<File> writeFile(
    String fileName,
    String content, {
    Function(String status)? status,
  }) async {
    Directory root = await getRootDirectory();
    File myFile = File("${root.path}/$fileName");
    bool isExist = await myFile.exists();

    if (!isExist) {
      await myFile.create(recursive: true);
      status?.call("Successfully Created");
    } else {
      status?.call("File already Exist");
    }
    myFile.writeAsString(content);
    return myFile;
  }

  Future<List<Directory>> getFolderList(String path) async {
    Directory root = await getRootDirectory();
    Directory currentFolder = Directory("${root.path}/$path");

    final list = currentFolder.list();

    return list
        .where((entity) => entity is Directory)
        .cast<Directory>()
        .toList();
  }

  Future<List<File>> getFileList(String path) async {
    Directory root = await getRootDirectory();
    Directory currentFolder = Directory("${root.path}/$path");

    final list = currentFolder.list();

    return list.where((entity) => entity is File).cast<File>().toList();
  }
}

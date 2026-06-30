import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileServices {
  Future<Directory> getRootDirectory() {
    return getApplicationDocumentsDirectory();
  }

  Future<Directory> createFolder(String folderName) async {
    Directory root = await getRootDirectory();
    Directory myFolder = Directory("${root.path} / $folderName");
    bool isExist = await myFolder.exists();

    if (!isExist) {
      await myFolder.create(recursive: true);
    }
    return myFolder;
  }

  Future<File> writeFile(String fileName, String content) async {
    Directory root = await getRootDirectory();
    File myFile = File("${root.path} / $fileName");
    bool isExist = await myFile.exists();

    if (!isExist) {
      await myFile.create(recursive: true);
    }
    myFile.writeAsString(content);
    return myFile;
  }
}

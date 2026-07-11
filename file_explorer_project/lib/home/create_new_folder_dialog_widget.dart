import 'package:flutter/material.dart';
import '../file services/file_services.dart';

class CreateNewFolderDialogWidget extends StatefulWidget {
  const CreateNewFolderDialogWidget({super.key, required this.currentLocation});

  final String currentLocation;

  @override
  State<CreateNewFolderDialogWidget> createState() =>
      _CreateNewFolderDialogWidgetState();
}

class _CreateNewFolderDialogWidgetState
    extends State<CreateNewFolderDialogWidget> {
  final FileServices _fileServices = FileServices();
  TextEditingController newFolder = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create New Folder"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Your Folder Name"),
          SizedBox(height: 8),
          TextField(
            onChanged: (String str) {
              setState(() {});
            },
            controller: newFolder,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Folder Name",
            ),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        FilledButton(
          onPressed: newFolder.text.trim().isEmpty
              ? null
              : () async {
                  await _fileServices.createFolder(
                    "${widget.currentLocation}${newFolder.text}",
                    status: (String status) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(status)));
                    },
                  );
                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
          child: Text("OK"),
        ),
      ],
    );
  }
}

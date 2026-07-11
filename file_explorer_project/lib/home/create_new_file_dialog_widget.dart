import 'package:flutter/material.dart';
import '../file services/file_services.dart';

class CreateNewFileDialogWidget extends StatefulWidget {
  const CreateNewFileDialogWidget({super.key, required this.currentLocation});
  final String currentLocation;

  @override
  State<CreateNewFileDialogWidget> createState() =>
      _CreateNewFileDialogWidgetState();
}

class _CreateNewFileDialogWidgetState extends State<CreateNewFileDialogWidget> {
  final FileServices _fileServices = FileServices();
  TextEditingController newFile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create New File"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter Your File Name"),
          SizedBox(height: 8),
          TextField(
            onChanged: (String str) {
              setState(() {});
            },
            controller: newFile,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter File Name",
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
          onPressed: newFile.text.trim().isEmpty
              ? null
              : () async {
                  await _fileServices.writeFile(
                    "${widget.currentLocation}${newFile.text}",
                    "",
                    status: (String status) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(status)));
                    },
                  );
                  if(context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
          child: Text("OK"),
        ),
      ],
    );
  }
}

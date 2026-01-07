import 'package:flutter/material.dart';
import '../services/record_service.dart';
import '../models/academic_record.dart';

class AddEditScreen extends StatefulWidget {
  final AcademicRecord? record;

  const AddEditScreen({super.key, this.record});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String type = 'Assignment';

  final service = RecordService();

  @override
  void initState() {
    if (widget.record != null) {
      titleController.text = widget.record!.title;
      descController.text = widget.record!.description;
      type = widget.record!.type;
    }
    super.initState();
  }

  Future<void> save() async {
    try {
      if (widget.record == null) {
        await service.addRecord(
          title: titleController.text,
          description: descController.text,
          type: type,
        );
      } else {
        await service.updateRecord(
          id: widget.record!.id,
          title: titleController.text,
          description: descController.text,
          type: type,
        );
      }

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.record == null ? 'Add Record' : 'Edit Record')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: type,
              items: ['Assignment', 'Note', 'Schedule']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => type = value!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}

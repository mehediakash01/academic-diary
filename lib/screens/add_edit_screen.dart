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
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String type = 'Assignment';

  final service = RecordService();

  @override
  void initState() {
    if (widget.record != null) {
      _titleController.text = widget.record!.title;
      _descController.text = widget.record!.description;
      type = widget.record!.type;
    }
    super.initState();
  }

  void save() async {
    if (widget.record == null) {
      await service.addRecord(
        title: _titleController.text,
        description: _descController.text,
        type: type,
      );
    } else {
      await service.updateRecord(
        id: widget.record!.id,
        title: _titleController.text,
        description: _descController.text,
        type: type,
      );
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'Add Record' : 'Edit Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: type,
              items: ['Assignment', 'Note', 'Schedule']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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

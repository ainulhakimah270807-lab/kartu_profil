import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({
    super.key,
    this.project,
  });

  final Project? project;

  @override
  State<ProjectFormPage> createState() =>
      _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _techStack;

  bool get _isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();

    _title = TextEditingController(
      text: widget.project?.title ?? '',
    );

    _description = TextEditingController(
      text: widget.project?.description ?? '',
    );

    _techStack = TextEditingController(
      text: widget.project?.techStack ?? '',
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _techStack.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bagian ini wajib diisi';
    }

    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final project = Project(
      id: widget.project?.id,
      title: _title.text.trim(),
      description: _description.text.trim(),
      techStack: _techStack.text.trim(),
      createdAt:
          widget.project?.createdAt ?? DateTime.now(),
    );

    Navigator.pop(context, project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Proyek' : 'Tambah Proyek',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Nama Proyek',
                border: OutlineInputBorder(),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _description,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Proyek',
                border: OutlineInputBorder(),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _techStack,
              decoration: const InputDecoration(
                labelText: 'Teknologi yang Digunakan',
                hintText: 'Flutter, Dart, SQLite',
                border: OutlineInputBorder(),
              ),
              validator: _validate,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(
                _isEditing ? 'Simpan Perubahan' : 'Simpan Proyek',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
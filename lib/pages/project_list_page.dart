import 'package:flutter/material.dart';

import '../data/project_repository.dart';
import '../models/project.dart';
import 'project_form_page.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() =>
      _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  final _repo = ProjectRepository();

  List<Project> _projects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);

    final data = await _repo.getAll();

    if (!mounted) return;

    setState(() {
      _projects = data;
      _loading = false;
    });
  }

  Future<void> _addProject() async {
    final result = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (_) => const ProjectFormPage(),
      ),
    );

    if (result == null) return;

    await _repo.insert(result);
    await _reload();
  }

  Future<void> _editProject(Project project) async {
    final result = await Navigator.push<Project>(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectFormPage(
          project: project,
        ),
      ),
    );

    if (result == null) return;

    await _repo.update(result);
    await _reload();
  }

  Future<void> _confirmDelete(Project project) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Proyek?'),
        content: Text(
          'Yakin ingin menghapus "${project.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm != true || project.id == null) return;

    await _repo.delete(project.id!);
    await _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _projects.isEmpty
              ? const Center(
                  child: Text('Belum ada proyek.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    final project = _projects[index];

                    return Card(
                      child: ListTile(
                        title: Text(project.title),
                        subtitle: Text(
                          '${project.description}\n'
                          'Teknologi: ${project.techStack}',
                        ),
                        isThreeLine: true,
                        onTap: () => _editProject(project),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () =>
                              _confirmDelete(project),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
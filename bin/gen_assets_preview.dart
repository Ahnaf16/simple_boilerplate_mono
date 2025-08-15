// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:path/path.dart' show join;
import 'package:yaml/yaml.dart';

void log(Object? o) => stdout.writeln(o);

const String _start = '  /// File path: ';
const String _end = '.svg';

bool _startsAndEndWith(String line) => line.startsWith(_start) && line.endsWith(_end);

void main(List<String> args) async {
  String path = 'lib/_core/strings/assets.gen.dart';

  if (isWorkSpace()) {
    log('Workspaces detected\n');
    final dirs = await appsDirs();
    for (final dir in dirs) {
      await _runGen(dir);
      path = join(dir, path);

      await _run(path);
    }
  } else {
    await _runGen(null);

    await _run(path);
  }
}

Future<void> _runGen(String? pubPath) async {
  log('Generating assets: ${pubPath ?? 'global'}\n');
  final cmd = pubPath == null ? <String>[] : ['-c', '$pubPath/pubspec.yaml'];
  final res = await Process.run('fluttergen', cmd);
  if (res.exitCode != 0) {
    log(res.stderr);
  } else {
    log(res.stdout);
  }
}

Future<void> _run(String path) async {
  log('Processing: $path\n');

  final assetsFile = File(path);

  if (!assetsFile.existsSync()) return log('assets file not found');

  final content = await assetsFile.readAsString();
  final lines = content.split('\n');
  int count = 0;
  for (var line in lines) {
    if (_startsAndEndWith(line)) {
      final path = line.substring(_start.length);
      final absolutePath = join(Directory.current.path, path);
      final htmlDartDoc = _toHtml(absolutePath);
      lines[lines.indexOf(line)] = htmlDartDoc;
      count++;
    }
  }

  await assetsFile.writeAsString(lines.join('\n'));

  log('Replaced $count docs');
}

String _toHtml(String path) => '/// <img src="$path" width="50" height="50"/>';

bool isWorkSpace() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return false;
  final content = pubspec.readAsStringSync();
  return content.contains('workspace:');
}

Future<List<String>> appsDirs() async {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return [];
  final content = await pubspec.readAsString();
  final doc = loadYaml(content);

  final dirs = <String>[];

  if (doc case final YamlMap map) {
    final workspaces = map['workspace'];
    if (workspaces case final YamlList list) {
      for (final dir in list) {
        if (dir.toString().startsWith('apps/')) dirs.add(dir.toString());
      }
    }
  }

  return dirs;
}

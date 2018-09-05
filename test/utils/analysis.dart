import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

Future<LibraryReader> resolveCompilationUnit(String sourceDirectory) async {
  var files = Directory(sourceDirectory).listSync().whereType<File>().toList();

  // Sort files to ensure the "first" one is first
  files.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  var fileMap = Map<String, String>.fromEntries(files.map(
      (f) => MapEntry('a|lib/${p.basename(f.path)}', f.readAsStringSync())));

  var library = await resolveSources(fileMap, (item) async {
    var assetId = AssetId.parse(fileMap.keys.first);
    return await item.libraryFor(assetId);
  });

  return LibraryReader(library);
}

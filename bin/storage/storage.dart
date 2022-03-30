import 'dart:convert';
import 'dart:io';

import '../models/block.dart';

class BlockStorage {
  bool _fileExists = false;
  File? _filePath;

  // First initialization of _json (if there is no json in the file)
  List<Block> savedBlocks = [];
  late String _jsonString;

  List<Block> blocks = [];

  Future<File> get _localFile async {
    return File('bin\\storage\\json_data.json');
  }

  Future<List<Block>> readJson() async {
    // Initialize _filePath
    _filePath = await _localFile;

    // 0. Check whether the _file exists
    _fileExists = await _filePath!.exists();

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        String _jsonString = await _filePath!.readAsString();

        savedBlocks = (json.decode(_jsonString) as List)
            .map((i) => Block.fromJSON(i))
            .toList();
        return savedBlocks;
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
    return [];
  }

  void writeJson(Block block) async {
    final _filePath = await _localFile;
    savedBlocks.add(block);
    _jsonString = jsonEncode(savedBlocks.map((e) => e.toJSON()).toList());
    _filePath.writeAsString(_jsonString);
  }
}

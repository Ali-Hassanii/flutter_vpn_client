import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';


class StoreServers {
  // initial file path
  Future<File> file() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return File(directory.path + '/servers.json');
  }

  // to load data from file
  Future<List> loadServers() async {
    try {
      final File _file = await file();
      final List data = jsonDecode(await _file.readAsString());
      return data;
    } catch (e) {
      return [];
    }
  }

  // add data
  Future<File> addServer(Map info) async {
    final String formatInfo = jsonEncode(info);
    final File _file = await file();
    final List data = await loadServers();
    data.add(formatInfo);
    return _file.writeAsString(jsonEncode(data));
  }

  // TODO: remove data
}

class TextFieldProperties {
  String label;
  double padding = 5;
  bool isPassword;
  TextFieldProperties(this.label, this.isPassword);
}

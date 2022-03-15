import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class ServerInfo {
  String name;
  String address;
  String username;
  String password;

  ServerInfo(this.name, this.address, this.password, this.username);
}

class Servers {
  Future<File> get _serversListPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return File(directory.path + '/servers.json');
  }

  Future<Map?> loadServers() async {
    try {
      final serverList = await _serversListPath;
      return json.decode(await serverList.readAsString());
    } catch (e) {
      return null;
    }
  }

  Future<File> addServers(ServerInfo serverInfo) async {
    File file = await _serversListPath;

    Map<String, dynamic> info = {
      'name': serverInfo.name,
      'address': serverInfo.address,
      'username': serverInfo.username,
      'password': serverInfo.password,
    };
    Map? data = await loadServers();
    data?.addAll(info);
    return file.writeAsString(data.toString());
  }
}

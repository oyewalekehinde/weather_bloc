import 'dart:io';

String weather(String name) => File('test/$name').readAsStringSync();

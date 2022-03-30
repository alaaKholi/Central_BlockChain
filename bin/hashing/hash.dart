import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';

class SHA256{
  static String hash(String s) {
    List<int> bytes = utf8.encode(s); // all inner block data being hashed
    return HEX.encode(sha256
        .convert(sha256.convert(bytes).bytes)
        .bytes); // hashing sha256 twice to guard against the length-extension property of the hash
  }
}
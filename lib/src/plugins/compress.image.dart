import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CompressImagePlugin {

 static Future<File> getImage(File file,[int minHeight = 500,int minWidth = 500]) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      '${directory.path}/${Uuid().v4()}.jpg',
      quality: 95,
      minHeight: minHeight,
      minWidth:  minWidth
    );
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }
}

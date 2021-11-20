import 'dart:convert';

import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'BaseApi.dart';

class ImageClient extends BaseApi {
  late String _cloudName;
  late String _apiKey;
  late String _apiSecret;

  ImageClient(String apiKey, String apiSecret, String cloudName) {
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
    this._cloudName = cloudName;
  }

  Future<CloudinaryResponse> uploadImage(String imagePath,
      {String? imageFilename, String? folder}) async {
    int timeStamp = new DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> params = new Map();

    params["api_key"] = _apiKey;

    String publicId = imagePath.split('/').last;
    publicId = publicId.split('.')[0];

    if (imageFilename != null) {
      publicId = imageFilename.split('.')[0] + "_" + timeStamp.toString();
    } else {
      imageFilename = publicId;
    }

    if (folder != null) {
      params["folder"] = folder;
    }

    params["public_id"] = publicId;

    params["file"] =
        await MultipartFile.fromFile(imagePath, filename: imageFilename);
    params["timestamp"] = timeStamp;
    params["signature"] = getSignature(folder!, publicId, timeStamp);

    FormData formData = new FormData.fromMap(params);

    Dio dio = await getApiClient();
    Response response =
        await dio.post(_cloudName + "/image/upload", data: formData);
    try {
      return CloudinaryResponse.fromJsonMap(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CloudinaryResponse.fromError("$error");
    }
  }

  String getSignature(String folder, String publicId, int timeStamp) {
    var buffer = new StringBuffer();

    buffer.write("folder=" + folder + "&");

    buffer.write("public_id=" + publicId + "&");

    buffer.write("timestamp=" + timeStamp.toString() + _apiSecret);

    var bytes = utf8.encode(buffer.toString().trim()); // data being hashed

    return sha1.convert(bytes).toString();
  }
}

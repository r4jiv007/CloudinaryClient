import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'BaseApi.dart';

class ImageClient extends BaseApi {
  String _cloudName;
  String _apiKey;
  String _apiSecret;

  ImageClient(String apiKey, String apiSecret, String cloudName) {
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
    this._cloudName = cloudName;
  }

  Future<Response> uploadImage(String imagePath,
      {String filename, String folder}) async {
    int timeStamp = new DateTime.now().millisecondsSinceEpoch;

    String publicId = imagePath.split('/').last;

    if (filename != null) {
      publicId = filename + "_" + timeStamp.toString();
    }

    Map<String, dynamic> params = new Map();

    if (imagePath == null) {
      throw Exception("imagePath must not be null");
    }

    if (_apiSecret == null || _apiKey == null) {
      throw Exception("apiKey and apiSecret must not be null");
    }
    params["api_key"] = _apiKey;

    if (folder != null) {
      params["folder"] = folder;
    }

    if (publicId != null) {
      params["public_id"] = publicId;
    }

    params["file"] = new UploadFileInfo(new File(imagePath), filename);
    params["timestamp"] = timeStamp;
    params["signature"] = getSignature(folder, publicId, timeStamp);

    FormData formData = new FormData.from(params);

    Dio dio = await getApiClient();
    Response response =
        await dio.post(_cloudName + "/image/upload", data: formData);
    return response;
  }

  String getSignature(String folder, String publicId, int timeStamp) {
    // ignore: avoid_init_to_null
    String toSign="";
    if (folder != null) {
      toSign = toSign + "folder=" + folder + "&";
    }
    if (publicId != null) {
      toSign = toSign + "public_id=" + publicId + "&";
    }
    toSign = toSign + "timestamp=" + timeStamp.toString() + _apiSecret;

    var bytes = utf8.encode(toSign); // data being hashed

    return sha1.convert(bytes).toString();
  }
}

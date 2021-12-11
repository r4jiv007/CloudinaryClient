
import 'dart:convert';

import 'package:cloudinary_client/models/CloudinaryResponse.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'BaseApi.dart';

class VideoClient extends BaseApi{

  late String _cloudName;
  late String _apiKey;
  late String _apiSecret;

  VideoClient(String apiKey, String apiSecret, String cloudName) {
    this._apiKey = apiKey;
    this._apiSecret = apiSecret;
    this._cloudName = cloudName;
  }

Future<CloudinaryResponse> uploadVideo(String videoPath,
      {String? videoFileName, String? folder}) async {
    int timeStamp = new DateTime.now().millisecondsSinceEpoch;

    Map<String, dynamic> params = new Map();
    params["api_key"] = _apiKey;

    String? publicId = videoPath.split('/').last;
    publicId = publicId.split('.')[0];

    if (videoFileName != null) {
      publicId = videoFileName.split('.')[0] + "_" + timeStamp.toString();
    } else {
      videoFileName = publicId;
    }

    if (folder != null) {
      params["folder"] = folder;
    }

    params["public_id"] = publicId;

    params["file"] =
        await MultipartFile.fromFile(videoPath, filename: videoFileName);
    params["timestamp"] = timeStamp;
    params["signature"] = getSignature(folder!, publicId, timeStamp);

    FormData formData = new FormData.fromMap(params);

    Dio dio = await getApiClient();
    Response response =
        await dio.post(_cloudName + "/video/upload", data: formData);
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


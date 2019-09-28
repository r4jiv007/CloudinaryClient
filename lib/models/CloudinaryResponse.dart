class CloudinaryResponse {
  String public_id;
  int version;
  int width;
  int height;
  String format;
  String created_at;
  String resource_type;
  List<Object> tags;
  int bytes;
  String type;
  String etag;
  String url;
  String secure_url;
  String signature;
  String original_filename;
  String error;

  CloudinaryResponse.fromJsonMap(Map<String, dynamic> map)
      : public_id = map["public_id"],
        version = map["version"],
        width = map["width"],
        height = map["height"],
        format = map["format"],
        created_at = map["created_at"],
        resource_type = map["resource_type"],
        tags = map["tags"],
        bytes = map["bytes"],
        type = map["type"],
        etag = map["etag"],
        url = map["url"],
        secure_url = map["secure_url"],
        signature = map["signature"],
        original_filename = map["original_filename"];

  CloudinaryResponse.fromError(this.error);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = public_id;
    data['version'] = version;
    data['width'] = width;
    data['height'] = height;
    data['format'] = format;
    data['created_at'] = created_at;
    data['resource_type'] = resource_type;
    data['tags'] = tags;
    data['bytes'] = bytes;
    data['type'] = type;
    data['etag'] = etag;
    data['url'] = url;
    data['secure_url'] = secure_url;
    data['signature'] = signature;
    data['original_filename'] = original_filename;
    return data;
  }
}

# cloudinary_client

Dart wrapper for cloudinary apis.

## usage 

## initialization
```
CloudinaryClient client = new CloudinaryClient(<API_KEY, <API_SECRET>, <cloud_name>);
```

## Uploading images

### Single Image upload
```
 
  CloudinaryResponse response = await client.uploadImage(<path>,filename:<optional>, folder:<optional>);
  // response object will contain image url.
  
```


### Multiple image upload
```
_path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);

List<String> result = await client.uploadImagesStringResp([_path]);
// will return list of url of images uploaded
```

##  Uploading video
###  Single Video upload
```
 
  CloudinaryResponse response = await client.uploadVideo(<path>,filename:<optional>, folder:<optional>);
  // response object will contain video url.
  
```

## with cloudinary standard response 

```
  List<CloudinaryResponse> result = await client.uploadImages([_path]);
```


## cloudinary response classs
```
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
 }
```

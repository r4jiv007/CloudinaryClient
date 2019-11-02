# cloudinary_client

Dart wrapper for cloudinary apis.

## usage 

## initialization
```
CloudinaryClient client = new CloudinaryClient(<API_KEY, <API_SECRET>, <cloud_name>);
```

## uploading images

## Single Image upload
```
 
  CloudinaryResponse response = await client.uploadImage(<path>,filename:<optional>, folder:<optional>);
  // response object will contain image url.
  
```


## multiple image upload
```
_path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);

List<String> result = await client.uploadImagesStringResp([_path]);
// will return list of url of images uploaded
```

## with cloudinary standard response 

```
  List<CloudinaryResponse> result = await client.uploadImages([_path]);
```

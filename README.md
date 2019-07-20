# cloudinary_client

Dart wrapper for cloudinary apis.

## usage 

```

CloudinaryClient client = new CloudinaryClient(<API_KEY, <API_SECRET>, <cloud_name>);
Response response = await client.uploadImage(<imagepath>, <filename>);
print(response);

```


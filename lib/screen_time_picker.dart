import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:azblob/azblob.dart';
import 'package:mime/mime.dart';
import 'package:myapp/complete_answer.dart';
import 'package:path/path.dart';

class ScreenTimePicker extends StatefulWidget {
  @override
  _ScreenTimePickerState createState() => _ScreenTimePickerState();
}

class _ScreenTimePickerState extends State<ScreenTimePicker> {
  File _image;
  final picker = ImagePicker();
  var pickedFileGlobal;

  var devicename = '';
  void getDeviceName() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(this.context).platform == TargetPlatform.android) {
      deviceInfo.androidInfo.then((AndroidDeviceInfo info) {
        devicename = "${info.manufacturer}_${info.model}_${info.product}";
      });
    } else {
      deviceInfo.iosInfo.then((IosDeviceInfo info) {
        devicename = info.name;
      });
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    getDeviceName();
    print(devicename);
    setState(() {
      _image = File(pickedFile.path);
      pickedFileGlobal = pickedFile;
    });
  }

  Future uploadImageToAzure(BuildContext context) async {
    try {
      String fileName = basename(pickedFileGlobal.path);
      // read file as Uint8List
      Uint8List content = await pickedFileGlobal.readAsBytes();
      var storage = AzureStorage.parse(
          'DefaultEndpointsProtocol=https;AccountName=usagestorageforapp;AccountKey=Gdx/hbTcyCd0bpyeWFd613E/TF+BWpjh7yWf+ei5C6vC4ilaIXcFXzVMRctkJPWM8+J0Jx168blXgS7MgOIaig==;EndpointSuffix=core.windows.net');
      String container = "usage-storage";
      // get the mine type of the file
      String contentType = lookupMimeType(fileName);
      fileName = devicename + '_' + fileName;
      print('fileName : $fileName');
      await storage.putBlob('/$container/$fileName',
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.BlockBlob);
      print("done");
    } on AzureStorageException catch (ex) {
      print('ex.message');
      print(ex.message);
    } catch (err) {
      print('image is not selected.');
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Usage Stats'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      // width: 300,
                      child: _image == null
                          ? Text(
                              '画像を選択してください',
                              style: TextStyle(fontSize: 18),
                            )
                          : Image.file(_image, width: 300)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      getImageFromGallery();
                    },
                    tooltip: 'スクリーンショットを選択',
                    child: Icon(Icons.photo_library),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    onPressed: () {
                      // send to Azure Storage endpoint
                      uploadImageToAzure(context);
                      if (_image == null) {
                        // stay
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteAnswer(),
                          ),
                        );
                      }
                    },
                    color: Colors.red,
                    child: Text(
                      '送信',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

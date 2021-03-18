 import 'package:firebase_storage/firebase_storage.dart';

Future<String> getPhotoUrl(String url) async {
    if(url == null){
      return 'https://img.icons8.com/pastel-glyph/2x/person-male.png';

    }
    else if(url.startsWith("http")) {
      return url;
    }
    else {
        return FirebaseStorage.instance.ref().child(url)
        .getDownloadURL().then((value) => value.toString());
        
      
    }
   
  }

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'api_const.dart';

class ApiCallers{

  int timeOutSecond = 20;

  Future<http.Response> login(String itsNumber, String password) async {
    var uri = "${API.baseUrl}/login?its_number=$itsNumber&password=$password";
    var url = Uri.parse(uri);
    return await http.post(url).timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> signUp(
     String itsNumber,
     String password,
     String type,
     String name, String cPassword,
    XFile? photo, // Pass the image file
  ) async {
    try {
      var uri = "${API.baseUrl}/register/user";
      var url = Uri.parse(uri);

      // Create a MultipartRequest
      var request = http.MultipartRequest("POST", url);

      // Add form fields
      request.fields['its_number'] = itsNumber;
      request.fields['password'] = password;
      request.fields['password_confirmation'] = cPassword;
      request.fields['type'] = type;
      request.fields['name'] = name;
      request.fields['username'] = itsNumber;

      // Add the image file if it exists
      if (photo != null) {
        var fileName = photo.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath('photo', photo.path, filename: fileName));
        log("Image file added: ${photo.path}, fileName: $fileName");
      }

      // Add headers
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Accept": "application/json",
      });

      // Send the request
      var streamedResponse = await request.send();

      // Convert streamed response to HTTP response
      var response = await http.Response.fromStream(streamedResponse);

      log("Sign Up Response: ${response.statusCode} - ${response.body}");
      return response;
    } catch (e) {
      log("Error during sign-up: $e");
      rethrow; // Re-throw the error to handle it outside
    }
  }


  Future<http.Response> getEventListForUser(String token) async {
    var uri = "${API.baseUrl}/event/list";
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log('TOKEN ::: $token===');
    log('url ::: $url');
    return await http
        .get(url, headers: headers)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> getFamilyMemberList(String token) async {
    var uri = "${API.baseUrl}/family/member/list";
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log('TOKEN ::: $token===');
    log('url ::: $url');
    return await http
        .get(url, headers: headers)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> getFamilyMemberAttendanceList(String token, int eventId) async {
    var uri = "${API.baseUrl}/family/member/list";
    var url = Uri.parse(uri);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add this header to specify JSON body
    };

    var jsonBody = jsonEncode({
      'event_id': eventId,
    });

    log('TOKEN ::: $token');
    log('URL ::: $url');
    log('BODY ::: $jsonBody');

    return await http
        .post(url, headers: headers, body: jsonBody)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> manageAttendance(String token, int eventId,List<int> ids) async {
    var uri = "${API.baseUrl}/manage/attendance";
    var url = Uri.parse(uri);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add this header to specify JSON body
    };

    var jsonBody = jsonEncode({
      'event_id': eventId,
      'member_ids': ids.join(","),
    });

    log('TOKEN ::: $token');
    log('URL ::: $url');
    log('BODY ::: $jsonBody');

    return await http
        .post(url, headers: headers, body: jsonBody)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> editProfile(
      String token,
      String name,
      File? photo, // Pass the image file
      ) async {
    try {
      var uri = "${API.baseUrl}/update/user/profile";
      var url = Uri.parse(uri);

      // Create a MultipartRequest
      var request = http.MultipartRequest("POST", url);

      // Add form fields
      request.fields['name'] = name;

      // Add the image file if it exists
      if (photo != null) {
        var fileName = photo.path.split('/').last;
        request.files.add(await http.MultipartFile.fromPath('photo', photo.path, filename: fileName));
        log("Image file added: ${photo.path}, fileName: $fileName");
      }

      // Add headers
      request.headers.addAll({
        "Accept": "application/json",
        'Authorization': 'Bearer $token',
      });

      // Send the request
      var streamedResponse = await request.send();

      // Convert streamed response to HTTP response
      var response = await http.Response.fromStream(streamedResponse);

      log("Edit Profile Res ${response.statusCode} - ${response.body}");
      return response;
    } catch (e) {
      log("Error during Edit Profile: $e");
      rethrow; // Re-throw the error to handle it outside
    }
  }


  ///======================ADMIN===============================================

  Future<http.Response> getEventList (String token) async {
    var uri = "${API.baseUrl}/event/list";
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    log('TOKEN ::: $token===');
    log('url ::: $url');
    return await http
        .get(url, headers: headers)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> addEvent (String token,
      String name,String location, String date,String lastEditDate, String des) async {
    var uri = "${API.baseUrl}/event/add";
    var url = Uri.parse(uri);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add this header to specify JSON body
    };

    var jsonBody = jsonEncode({
      'name': name,
      'location': location,
      'date': date,
      'last_edit_date': lastEditDate,
      'code': "16Mi-24",
      'description': des,
    });

    log('TOKEN ::: $token');
    log('URL ::: $url');
    log('BODY ::: $jsonBody');

    return await http
        .post(url, headers: headers, body: jsonBody)
        .timeout(Duration(seconds: timeOutSecond));
  }

  Future<http.Response> deleteEvent(String token, int eventId) async {
    var uri = "${API.baseUrl}/event/delete";
    var url = Uri.parse(uri);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Add this header to specify JSON body
    };

    var jsonBody = jsonEncode({
      'event_id': eventId,
    });

    log('TOKEN ::: $token');
    log('URL ::: $url');
    log('BODY ::: $jsonBody');

    return await http
        .post(url, headers: headers, body: jsonBody)
        .timeout(Duration(seconds: timeOutSecond));
  }



}
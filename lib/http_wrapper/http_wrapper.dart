// // ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings
//
// import 'dart:convert';
// import 'dart:io';
//
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http/io_client.dart';
// import 'package:vin_sweep/http_wrapper/progress_hud.dart';
//
// import 'current_session.dart';
//
// class HttpWrapper {
//   final String url;
//   final bool showLoading;
//   final dynamic body;
//   final Map<String, String>? files;
//   final Map<String, List<String?>>? filesList;
//   final Duration defaultTimeout = const Duration(seconds: 120);
//   final BuildContext? context;
//   final String? token;
//   final String currentLanguage;
//   Map<String, String>? headers;
//   final bool useAuthorization;
//   final bool unFocusPrimary;
//
//   HttpWrapper({
//     this.headers,
//     required this.url,
//     this.useAuthorization = true,
//     this.body,
//     this.files,
//     this.filesList,
//     this.context,
//     this.token,
//     this.currentLanguage = 'ar',
//     this.showLoading = false,
//     this.unFocusPrimary = true,
//   }) {
//     if (unFocusPrimary) {
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//     headers ??= {
//       'Content-Type': 'application/json',
//       'accept': 'application/json',
//       // 'Accept-Language': AppLocale().isArabic() ? '1' : '2',
//     };
//
//     if (CurrentSession().getApiUser() != null
//         ) {
//       headers = {
//         'Content-Type': 'application/json',
//         'accept': 'application/json',
//         // 'Accept-Language': AppLocale().isArabic() ? '1' : '2',
//       };
//     }
//   }
//
//   bool _validateUrl(HttpWrapper wrapper) {
//     // final validateUrl = Uri.tryParse(wrapper.url);
//     // if (!GeneralConfigurations().isDebug && validateUrl!.scheme != 'https') {
//     //   DialogUtils.showErrorDialog(
//     //       button: S.of(context!).okButton,
//     //       message: S.of(context!).generalError,
//     //       context: wrapper.context!,
//     //       completionHandler: () {
//     //         exit(0); // close the app
//     //       });
//     //   return false;
//     // }
//
//     return true;
//   }
//
//   Future<HttpClient> _createClient(HttpWrapper wrapper) async {
//     // pinning certificate
//     final clientContext = SecurityContext(withTrustedRoots: false);
//     // if (wrapper.useAuthorization &&
//     //     CurrentSession().currentModel?.data.token != null) {
//     //   wrapper.headers!.putIfAbsent("Authorization", () => "Bearer " + CurrentSession().currentModel!.data.token);
//     // }
//     HttpClient client = HttpClient(context: clientContext)
//       ..badCertificateCallback =
//       ((X509Certificate cert, String host, int port) {
//         // if (appCertificate == cert.pem) {
//         //   return true;
//         // }
//         return true;
//       });
//
//     return client;
//   }
//
//   Future<ApiResponse?> put({required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//
//     try {
//       final bool validUrl = _validateUrl(wrapper);
//
//       if (!validUrl) return apiResponse;
//
//       bool isTimeout = false;
//
//       HttpClient client = await _createClient(wrapper);
//
//       IOClient ioClient = IOClient(client);
//
//       final response = await ioClient
//           .put(
//         Uri.parse(wrapper.url),
//         headers: wrapper.headers,
//         body: wrapper.body,
//         encoding: utf8,
//       )
//           .timeout(defaultTimeout, onTimeout: () {
//         if (!isTimeout) {
//           isTimeout = true;
//           if (wrapper.showLoading) {
//             ProgressHud.shared.stopLoading();
//           }
//
//           _printLog('Time out', wrapper);
//         }
//
//         return Response("Time Out", 504);
//       }).catchError((error) {
//         if (wrapper.showLoading) {
//           ProgressHud.shared.stopLoading();
//         }
//         _printLog('HTTP Exception', wrapper);
//
//         return Response(S.current.generalError, 500);
//       });
//
//       ioClient.close();
//
//       if (!isTimeout) {
//         apiResponse = await _finalResponse(wrapper, response);
//       }
//     } catch (error) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//     }
//     _printLog('PUT Request', wrapper);
//
//     return apiResponse;
//   }
//
//   Future<ApiResponse?> post() async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400; // error
//
//     try {
//       if (showLoading) {
//         ProgressHud.shared.startLoading(context!);
//       }
//       final bool validUrl = _validateUrl(this);
//
//       if (!validUrl) return apiResponse;
//
//       bool isTimeout = false;
//
//       HttpClient client = await _createClient(this);
//
//       IOClient ioClient = IOClient(client); // session mobile Api
//
//       final response = await ioClient
//           .post(
//         Uri.parse(url),
//         headers: headers,
//         body: json.encode(body),
//         encoding: utf8,
//       )
//           .timeout(defaultTimeout, onTimeout: () {
//         if (!isTimeout) {
//           isTimeout = true;
//           if (showLoading) {
//             ProgressHud.shared.stopLoading();
//           }
//
//           _printLog('Time out', this);
//         }
//
//         return Response("Time Out", 504);
//       }).catchError((error) {
//         if (showLoading) {
//           ProgressHud.shared.stopLoading();
//         }
//         if (kDebugMode) {
//           debugPrint('HTTP Exception $error');
//         }
//
//         return Response(S.current.generalError, 500);
//       });
//       ioClient.close(); // close
//
//       if (!isTimeout) {
//         apiResponse = await _finalResponse(this, response);
//       }
//     } catch (error) {
//       if (showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       _printLog('POST Request', this);
//     }
//     _printLog('POST Request', this);
//
//     return apiResponse;
//   }
//
//   Future<ApiResponse> startMultiPartPost({required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//     try {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.startLoading(wrapper.context!);
//       }
//       final bool validUrl = _validateUrl(wrapper);
//
//       if (!validUrl) return apiResponse;
//
//       var headers = {
//         'Content-Type': 'multipart/form-data',
//         // 'Accept-Language': AppLocale().isArabic() ? '1' : '2',
//         "Authorization": "Bearer ${CurrentSession().getUser()!.token!}"
//       };
//       var request = MultipartRequest('POST', Uri.parse(wrapper.url));
//       request.fields.addAll(wrapper.body);
//       for (var key in wrapper.files!.keys) {
//         // request.files.add(MultipartFile.fromBytes('file', await File.fromUri(Uri(path: wrapper.files![value]!)).readAsBytes(), contentType: MediaType('image', 'jpeg')));
//         request.files.add(await MultipartFile.fromPath(
//           key,
//           wrapper.files![key]!,
//         ));
//         // request.files.add(MultipartFile.fromBytes(
//         //     'picture', File(wrapper.files![key]!).readAsBytesSync(),
//         //     filename: wrapper.files![key]!.split("/").last));
//       }
//
//       request.headers.addAll(headers);
//
//       StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         apiResponse.statusCode = 200;
//         String resp = await response.stream.bytesToString();
//         apiResponse.body = utf8.encode(resp) as Uint8List?;
//       } else {
//         apiResponse.statusCode = response.statusCode;
//       }
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       return apiResponse;
//     } catch (_) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       return apiResponse;
//     }
//   }
//
//   Future<ApiResponse> startMultiPartListPost(
//       {required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//     try {
//       final bool validUrl = _validateUrl(wrapper);
//
//       if (!validUrl) return apiResponse;
//
//       var headers = {
//         'Content-Type': 'multipart/form-data',
//         // 'Accept-Language': AppLocale().isArabic() ? '1' : '2',
//         "Authorization": "Bearer ${CurrentSession().getUser()!.token!}"
//       };
//       var request = MultipartRequest('POST', Uri.parse(wrapper.url));
//       request.fields.addAll(wrapper.body);
//       for (var key in wrapper.filesList!.keys) {
//         // request.files.add(MultipartFile.fromBytes('file', await File.fromUri(Uri(path: wrapper.files![value]!)).readAsBytes(), contentType: MediaType('image', 'jpeg')));
//         for (var element in wrapper.filesList![key]!) {
//           request.files.add(await MultipartFile.fromPath(
//             key,
//             element!,
//           ));
//         }
//         // request.files.add(MultipartFile.fromBytes(
//         //     'picture', File(wrapper.files![key]!).readAsBytesSync(),
//         //     filename: wrapper.files![key]!.split("/").last));
//       }
//
//       request.headers.addAll(headers);
//
//       StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         apiResponse.statusCode = 200;
//         String resp = await response.stream.bytesToString();
//         apiResponse.body = utf8.encode(resp) as Uint8List?;
//       } else {
//         apiResponse.statusCode = response.statusCode;
//       }
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       return apiResponse;
//     } catch (_) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       return apiResponse;
//     }
//   }
//
//   Future<ApiResponse?> delete({required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//
//     try {
//       final bool validUrl = _validateUrl(wrapper);
//
//       if (!validUrl) return apiResponse;
//
//       bool isTimeout = false;
//
//       HttpClient client = await _createClient(wrapper);
//
//       IOClient ioClient = IOClient(client);
//
//       final response = await ioClient
//           .delete(
//         Uri.parse(wrapper.url),
//         headers: wrapper.headers,
//         body: wrapper.body,
//         encoding: utf8,
//       )
//           .timeout(defaultTimeout, onTimeout: () {
//         if (!isTimeout) {
//           isTimeout = true;
//           if (wrapper.showLoading) {
//             ProgressHud.shared.stopLoading();
//           }
//
//           _printLog('Time out', wrapper);
//         }
//
//         return Response("Time Out", 504);
//       }).catchError((error) {
//         if (wrapper.showLoading) {
//           ProgressHud.shared.stopLoading();
//         }
//         if (kDebugMode) {
//           debugPrint('HTTP Exception $error');
//         }
//
//         return Response(S.current.generalError, 500);
//       });
//       ioClient.close();
//
//       if (!isTimeout) {
//         apiResponse = await _finalResponse(wrapper, response);
//       }
//     } catch (error) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       _printLog('POST Request', wrapper);
//     }
//
//     return apiResponse;
//   }
//
//   Future<ApiResponse?> get({required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//
//     try {
//       // final bool _validUrl = _validateUrl(wrapper);
//       //
//       // if (!_validUrl) return _apiResponse;
//
//       bool isTimeout = false;
//
//       HttpClient client = await _createClient(wrapper);
//
//       IOClient ioClient = IOClient(client);
//
//       final response = await ioClient
//           .get(Uri.parse(wrapper.url), headers: wrapper.headers)
//           .timeout(defaultTimeout, onTimeout: () {
//         if (!isTimeout) {
//           isTimeout = true;
//           if (wrapper.showLoading) {
//             ProgressHud.shared.stopLoading();
//           }
//
//           _printLog('Time out', wrapper);
//         }
//
//         return Response("Time Out", 504);
//       }).catchError((error) {
//         if (wrapper.showLoading) {
//           ProgressHud.shared.stopLoading();
//         }
//         _printLog('HTTP Exception', wrapper);
//
//         return Response(S.current.generalError, 500);
//       });
//
//       ioClient.close();
//
//       if (!isTimeout) {
//         apiResponse = await _finalResponse(wrapper, response);
//       }
//     } catch (error) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       _printLog('POST Request', wrapper);
//     }
//
//     return apiResponse;
//   }
//
//   Future<ApiResponse?> getFile({required HttpWrapper wrapper}) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//
//     try {
//       final bool validUrl = _validateUrl(wrapper);
//
//       if (!validUrl) return apiResponse;
//
//       HttpClient client = await _createClient(wrapper);
//
//       IOClient ioClient = IOClient(client);
//
//       final response = await ioClient.get(Uri.parse(wrapper.url));
//
//       ioClient.close();
//
//       apiResponse = ApiResponse();
//       apiResponse.statusCode = response.statusCode;
//       apiResponse.body = response.bodyBytes;
//     } catch (error) {
//       if (wrapper.showLoading) {
//         ProgressHud.shared.stopLoading();
//       }
//       _printLog('POST Request', wrapper);
//     }
//
//     return apiResponse;
//   }
//
//   Future<ApiResponse> _finalResponse(
//       HttpWrapper wrapper, Response response) async {
//     ApiResponse apiResponse = ApiResponse();
//     apiResponse.statusCode = 400;
//
//     if (wrapper.showLoading) ProgressHud.shared.stopLoading();
//
//     final connectivityResult =
//     await (Connectivity().checkConnectivity()); // connected to the internet
//
//     try {
//       _printLogWithResponse(response, wrapper);
//     } catch (e) {
//       if (kDebugMode) {
//         debugPrint(e.toString());
//       }
//     }
//
//     if (connectivityResult == ConnectivityResult //.none
//     ) {
//       // disable
//       return apiResponse;
//     } else {
//       apiResponse.statusCode = response.statusCode;
//       apiResponse.body = response.bodyBytes;
//
//       return apiResponse;
//     }
//   }
//
//   void _printLogWithResponse(Response response, HttpWrapper wrapper) {
//     try {
//       if (kDebugMode) {
//         if (kDebugMode) {
//           print(
//               '${'==============================================\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url}\n\npostBody = ' + wrapper.body}\n\nresponse body = ${response.body}');
//         }
//         if (kDebugMode) {
//           print('\n==============================================');
//         }
//       }
//     } catch (_) {}
//   }
//
//   void _printLog(String from, HttpWrapper wrapper) {
//     try {
//       if (kDebugMode) {
//         print(
//             '==============================================\nFrom : $from\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url}\n\npostBody = ${wrapper.body}\n\n');
//       }
//       if (kDebugMode) {
//         print('\n==============================================');
//       }
//     } catch (_) {}
//   }
// }
//
// class Connectivity {
//   checkConnectivity() {}
// }
//
// class ConnectivityResult {
//
// }
//
// class S {
//   static var current;
// }
//
// class ApiResponse {
//   Uint8List? body;
//   Map<String, List<String>>? headers;
//   int? statusCode;
//
//   ApiResponse();
//
//   ApiResponse.fromApiResponse(this.body, this.headers, this.statusCode);
//   ApiResponse.fromDemo(this.statusCode);
//
//   ApiResponse.clone(ApiResponse response)
//       : this.fromApiResponse(
//       response.body, response.headers, response.statusCode);
// }

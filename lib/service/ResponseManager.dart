import 'dart:convert';

import 'package:betsbi/model/response.dart';
import 'package:betsbi/widget/FlushBarMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ResponseManager {
  final dynamic elementToReturn;
  final BuildContext context;
  final http.Response response;
  final Function onSuccess;
  final Widget destination;
  final Function onFailure;
  final String successMessage;
  final Function functionFromJsonToReturn;
  final Function functionListToReturn;

  ResponseManager(
      {@required this.response,
      this.elementToReturn,
      this.context,
      this.successMessage,
      this.onSuccess,
      this.onFailure,
      this.destination,
      this.functionFromJsonToReturn,
      this.functionListToReturn});

  checkResponseAndPrintIt() {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      FlushBarMessage.goodMessage(content: this.successMessage)
          .showFlushBar(context);
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
          content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
    }
  }

  checkResponseAndShowIt() {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      FlushBarMessage.goodMessage(content: this.successMessage)
          .showFlushBarAndNavigateAndRemove(context, this.destination);
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
    }
  }

  checkResponseAndRetrieveInformation() {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      return elementToReturn;
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(context);
      return elementToReturn;
    }
  }

  checkResponseAndRetrieveInformationFromJson() {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      return this.functionFromJsonToReturn();
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
              content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(this.context);
      return elementToReturn;
    }
  }

  checkResponseAndRetrieveListOfInformation() {
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      return functionListToReturn();
    } else {
      if (this.onFailure != null) onFailure();
      return elementToReturn;
    }
  }

  void checkResponseAndExecuteFunctionIfOk(){
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
          content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(this.context);
    }
  }

  bool checkResponseAndConfirmSuccess(){
    if (response.statusCode >= 100 && response.statusCode < 400) {
      if (this.onSuccess != null) onSuccess();
      return true;
    } else {
      if (this.onFailure != null) onFailure();
      FlushBarMessage.errorMessage(
          content: Response.fromJson(json.decode(response.body)).content)
          .showFlushBar(this.context);
      return false;
    }
  }
}

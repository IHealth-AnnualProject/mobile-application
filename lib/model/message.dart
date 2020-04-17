class Message{
  String content;
  int idSender;
  int idReceiver;
  bool status;
  DateTime sendDate;

  Message(this.content,this.idSender,this.idReceiver,this.sendDate,{this.status:false});

  void setStatus(bool status)
  {
    this.status = status;
  }
}
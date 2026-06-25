class RequestModel {
  RequestModel({this.model, this.messages, this.stream, this.think});

  RequestModel.fromJson(dynamic json) {
    model = json['model'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
    stream = json['stream'];
    think = json['think'];
  }

  String? model;
  List<Messages>? messages;
  bool? stream;
  bool? think;

  RequestModel copyWith({
    String? model,
    List<Messages>? messages,
    bool? stream,
    bool? think,
  }) => RequestModel(
    model: model ?? this.model,
    messages: messages ?? this.messages,
    stream: stream ?? this.stream,
    think: think ?? this.think,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model'] = model;
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    map['stream'] = stream;
    map['think'] = think;
    return map;
  }
}

class Messages {
  Messages({this.role, this.content});

  Messages.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
  }

  String? role;
  String? content;

  Messages copyWith({String? role, String? content}) =>
      Messages(role: role ?? this.role, content: content ?? this.content);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    return map;
  }
}

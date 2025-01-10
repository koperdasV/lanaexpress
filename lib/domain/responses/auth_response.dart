class AuthResponse {
  // Credentials? credentials;
  // String? id;
  Tokens? tokens;

  AuthResponse();

  AuthResponse.fromJson(Map<String, dynamic> json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    // credentials = json['credentials'] != null
    //     ? Credentials.fromJson(json['credentials'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tokens != null) {
      data['tokens'] = tokens?.toJson();
    }
    // if (credentials != null) {
    //   data['credentials'] = credentials?.toJson();
    // }
    return data;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class Config {
  Functions? functions;
  String? sId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;
  CredentialsConfig? credentials;

  Config({
    this.functions,
    this.sId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.credentials,
    this.iV,
  });

  Config.fromJson(Map<String, dynamic> json) {
    credentials = json['credentials'] != null
        ? CredentialsConfig.fromJson(json['credentials'])
        : null;
    functions = json['functions'] != null
        ? Functions.fromJson(json['functions'])
        : null;
    sId = json['_id'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (credentials != null) {
      data['credentials'] = credentials?.toJson();
    }
    if (functions != null) {
      data['functions'] = functions?.toJson();
    }
    data['_id'] = sId;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Owner {
  String? name;
  String? phone;
  String? email;

  Owner({this.name, this.phone, this.email});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}



class OrderStatuses {
  String? currentStatus;
  String? nextStatus;
  int? priority;
  bool? editable;

  OrderStatuses({
    this.currentStatus,
    this.nextStatus,
    this.priority,
    this.editable,
  });

  OrderStatuses.fromJson(Map<String, dynamic> json) {
    currentStatus = json['currentStatus'];
    nextStatus = json['nextStatus'];
    priority = json['priority'];
    editable = json['editable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentStatus'] = currentStatus;
    data['nextStatus'] = nextStatus;
    data['priority'] = priority;
    data['editable'] = editable;
    return data;
  }
}

class Functions {
  UsersDatabase? usersDatabase;
  bool? offerVideo;
  bool? checkVersion;
  bool? autocomplete;
  bool? qrCodes;
  bool? synchronization;
  bool? franchise;
  bool? sizePrices;
  bool? offerCountInput;
  bool? showOfferCountAlert;
  bool? alwaysAskSubCompany;
  bool? deliveryZones;

  Functions({
    this.usersDatabase,
    this.offerVideo,
    this.checkVersion,
    this.autocomplete,
    this.qrCodes,
    this.sizePrices,
    this.offerCountInput,
    this.showOfferCountAlert,
    this.synchronization,
    this.franchise,
    this.alwaysAskSubCompany,
    this.deliveryZones,
  });

  Functions.fromJson(Map<String, dynamic> json) {
    usersDatabase = json['usersDatabase'] != null
        ? UsersDatabase.fromJson(json['usersDatabase'])
        : null;
    offerVideo = json['offerVideo'];
    checkVersion = json['checkVersion'];
    autocomplete = json['autocomplete'];
    qrCodes = json['qrCodes'];
    sizePrices = json['sizePrices'];
    offerCountInput = json['offerCountInput'];
    synchronization = json['synchronization'];
    showOfferCountAlert = json['showOfferCountAlert'] ?? false;
    alwaysAskSubCompany = json['alwaysAskSubCompany'] ?? false;
    deliveryZones = json['deliveryZones'] ?? false;
    franchise = json['franchise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offerVideo'] = offerVideo;
    data['checkVersion'] = checkVersion;
    data['autocomplete'] = autocomplete;
    data['qrCodes'] = qrCodes;
    data['sizePrices'] = sizePrices;
    data['offerCountInput'] = offerCountInput;
    data['synchronization'] = synchronization;
    data['showOfferCountAlert'] = showOfferCountAlert;
    data['alwaysAskSubCompany'] = alwaysAskSubCompany;
    data['deliveryZones'] = deliveryZones;
    data['franchise'] = franchise;
    data['deliveryZones'] = deliveryZones;
    return data;
  }
}

class UsersDatabase {
  bool? available;
  bool? balanceEditing;

  UsersDatabase({this.available, this.balanceEditing});

  UsersDatabase.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    balanceEditing = json['balanceEditing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = available;
    data['balanceEditing'] = balanceEditing;
    return data;
  }
}

class Credentials {
  String? merchantLogin;
  String? merchantSecret;
  String? crc;
  String? webhook;

  Credentials({this.merchantLogin, this.merchantSecret, this.webhook});

  Credentials.fromJson(Map<String, dynamic> json) {
    merchantLogin = json['merchantLogin'];
    merchantSecret = json['merchantSecret'];
    crc = json['crc'];
    webhook = json['webhook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['merchantLogin'] = merchantLogin;
    data['merchantSecret'] = merchantSecret;
    data['crc'] = crc;
    data['webhook'] = webhook;
    return data;
  }
}

class Client {
  bool? orders;
  bool? products;
  bool? chats;
  bool? more;
  bool? notifications;

  Client(
      {this.orders, this.products, this.chats, this.more, this.notifications});

  Client.fromJson(Map<String, dynamic> json) {
    orders = json['orders'];
    products = json['products'];
    chats = json['chats'];
    more = json['more'];
    notifications = json['notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders;
    data['products'] = products;
    data['chats'] = chats;
    data['more'] = more;
    data['notifications'] = notifications;
    return data;
  }
}

class Admin {
  bool? orders;
  bool? users;
  bool? chats;
  bool? more;
  bool? statistic;

  Admin({this.orders, this.users, this.chats, this.more, this.statistic});

  Admin.fromJson(Map<String, dynamic> json) {
    orders = json['orders'];
    users = json['users'];
    chats = json['chats'];
    more = json['more'];
    statistic = json['statistic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orders'] = orders;
    data['users'] = users;
    data['chats'] = chats;
    data['more'] = more;
    data['statistic'] = statistic;
    return data;
  }
}

class CredentialsConfig {
  String? gOOGLEAPIKEY;

  CredentialsConfig({this.gOOGLEAPIKEY});

  CredentialsConfig.fromJson(Map<String, dynamic> json) {
    gOOGLEAPIKEY = json['GOOGLE_API_KEY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GOOGLE_API_KEY'] = gOOGLEAPIKEY;
    return data;
  }
}

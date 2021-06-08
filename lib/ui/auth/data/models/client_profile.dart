class ClientProfile {
  String? email;

  ClientProfile({
    this.email,
  });

  ClientProfile.fromJson(Map<String, dynamic> json){
    email = json['email'];
  }
}
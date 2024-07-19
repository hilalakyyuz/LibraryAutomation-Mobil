class EntityToken {
  // ignore: non_constant_identifier_names
  String access_token;
  // ignore: non_constant_identifier_names
  String token_type;
  // ignore: non_constant_identifier_names
  int expires_in;

  // ignore: non_constant_identifier_names
  EntityToken({required this.access_token, required this.token_type, required this.expires_in});

  factory EntityToken.fromJson(Map<String, dynamic> json) {
    return EntityToken(
      access_token: json['access_token'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
    );
  }
}

class Agent {
  Agent({
    this.agentId,
    this.email,
    this.phoneNumber,
    this.familyName,
    this.name,
    this.blocked,
  });

  int? agentId;
  String? email;
  String? phoneNumber;
  String? familyName;
  String? name;
  bool? blocked;

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        agentId: json["agent_id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        familyName: json["family_name"],
        name: json["name"],
        blocked: json["blocked"],
      );

  Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "email": email,
        "phone_number": phoneNumber,
        "family_name": familyName,
        "name": name,
        "blocked": blocked,
      };
}

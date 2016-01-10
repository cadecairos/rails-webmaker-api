module WebmakerIdentity
  def WebmakerIdentity.validate_user token, id
    response = HTTP.accept(:json)
      .auth("token #{token}")
      .get("#{Rails.application.config.id_server_connection_string}/user")

    false unless response.status == 200

    body_hash = JSON.parse response.body.to_s

    body_hash["id"] == id ? true : false
  end
end

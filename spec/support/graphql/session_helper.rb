# frozen_string_literal: true

module SessionHelpers
  def generate_token(account_id:)
    payload = { account_id: account_id }

    JWTSessions::Session.new(payload: payload).login[:access]
  end
end

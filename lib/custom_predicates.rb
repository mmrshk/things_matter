# frozen_string_literal: true

module CustomPredicates
  include Dry::Logic::Predicates

  predicate(:uuid_v4?) do |value|
    uuid_v4_format = /^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i
    value.is_a?(String) && format?(uuid_v4_format, value)
  end

  predicate(:movie_exists?) do |value|
    Movie.exists?(id: value)
  end

  predicate(:signed_blob_id?) do |signed_blob_id|
    return false unless signed_blob_id.is_a? String

    ActiveStorage.verifier.verify(signed_blob_id, purpose: :blob_id)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    false
  end
end

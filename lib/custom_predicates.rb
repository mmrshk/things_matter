# frozen_string_literal: true

module CustomPredicates
  include Dry::Logic::Predicates

  predicate(:movie_exists?) do |value|
    Movie.exists?(id: value)
  end
end

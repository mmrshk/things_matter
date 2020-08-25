# frozen_string_literal: true

module User::Movie
  module Contract
    class AddFavorite < Reform::Form
      feature Reform::Form::Dry

      property :user_account_id
      property :movie_id

      validation :default do
        configure do
          option :form

          predicates(::CustomPredicates)

          def movie_in_favorite?
            !FavoriteMovie.exists?(user_account_id: form.user_account_id, movie_id: form.movie_id)
          end
        end

        required(:movie_id).filled(:movie_exists?, :movie_in_favorite?)
      end
    end
  end
end

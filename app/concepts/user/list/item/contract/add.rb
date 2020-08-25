# frozen_string_literal: true

module User::List
  module Item::Contract
    class Add < Reform::Form
      feature Reform::Form::Dry

      property :list_id
      property :movie_id

      validation :default do
        configure do
          option :form

          def list_existence?(list_id)
            ::List.exists?(id: list_id)
          end

          def movie_existence?(movie_id)
            Movie.exists?(id: movie_id)
          end

          def movie_in_list?(_movie_id)
            !ListsMovie.exists?(list_id: form.list_id, movie_id: form.movie_id)
          end
        end

        required(:list_id).filled(:list_existence?)
        required(:movie_id).filled(:movie_existence?, :movie_in_list?)
      end
    end
  end
end

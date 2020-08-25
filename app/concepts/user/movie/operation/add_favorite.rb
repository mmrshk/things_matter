# frozen_string_literal: true

module User::Movie
  module Operation
    class AddFavorite < Trailblazer::Operation
      step Policy::Guard(User::Guard::AddToList.new), fail_fast: true

      step Model(FavoriteMovie, :new)

      step Trailblazer::Operation::Contract::Build(constant: User::Movie::Contract::AddFavorite)
      step Trailblazer::Operation::Contract::Validate(), fail_fast: true
      step Trailblazer::Operation::Contract::Persist()

      step :set_result

      def set_result(ctx, **)
        ctx['result'] = ctx[:model].movie
      end
    end
  end
end

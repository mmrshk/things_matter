# frozen_string_literal: true

module User::List
  module Item::Operation
    class Add < Trailblazer::Operation
      step Model(::ListsMovie, :new)
      step Policy::Guard(User::List::Guard::AddDelete.new), fail_fast: true

      step Trailblazer::Operation::Contract::Build(constant: User::List::Item::Contract::Add)
      step Trailblazer::Operation::Contract::Validate(), fail_fast: true
      step Trailblazer::Operation::Contract::Persist()

      step :set_result

      def set_result(ctx, **)
        ctx['result'] = ctx[:model].list
      end
    end
  end
end

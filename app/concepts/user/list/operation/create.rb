# frozen_string_literal: true

module User::List
  module Operation
    class Create < Trailblazer::Operation
      step :init_model

      step Trailblazer::Operation::Contract::Build(constant: User::List::Contract::Create)
      step Trailblazer::Operation::Contract::Validate(), fail_fast: true
      step Trailblazer::Operation::Contract::Persist()

      step :set_result

      def init_model(ctx, **)
        ctx[:model] = ::List.new(user_account_id: ctx[:current_user].id)
      end

      def set_result(ctx, **)
        ctx['result'] = ctx[:current_user]
      end
    end
  end
end

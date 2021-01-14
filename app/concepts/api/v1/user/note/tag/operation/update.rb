# frozen_string_literal: true

module Api::V1
  module User::Note::Tag
    module Operation
      class Update < Api::V1::ApplicationOperation
        step Model(NoteTag, :find_by),  fail_fast: true

        step Macro::Policy(
          policy: NoteTagPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Note::Tag::Contract::Update)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step :set_result

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

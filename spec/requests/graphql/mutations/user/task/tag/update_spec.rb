# frozen_string_literal: true

describe 'mutation userTaskTagUpdate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:task) { create(:task, user_account: user_account) }
  let(:task_tag) { create(:task_tag, task: task) }
  let(:name) { FFaker::Lorem.word }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        name: name,
        id: task_tag.id
      }
    }
  end

  context 'when success' do
    it 'returns updated task tag of current_user' do
      authorized_graphql_post(
        query: user_task_tag_update_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserTaskTag::UpdateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_tag_update_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(TaskTag).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_tag_update_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when user not authorized' do
      it 'returns error' do
        graphql_post(
          query: user_task_tag_update_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

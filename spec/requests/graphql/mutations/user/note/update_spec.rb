# frozen_string_literal: true

describe 'mutation userNoteUpdate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:project) { create(:project, user_account: user_account, type: 'NoteProject') }
  let(:note) { create(:note, project: project) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        id: note.id,
        name: name,
        description: description
      }
    }
  end

  context 'when success' do
    it 'returns updates note of current_user' do
      authorized_graphql_post(
        query: user_note_update_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserNote::UpdateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      # rubocop:disable RSpec/AnyInstance
      before { allow_any_instance_of(Note).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }
      # rubocop:enable RSpec/AnyInstance

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_update_mutation,
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
          query: user_note_update_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

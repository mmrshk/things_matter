# frozen_string_literal: true

describe 'mutation userNoteTagCreate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:note) { create(:note, user_account: user_account) }
  let(:name) { FFaker::Lorem.word }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        name: name,
        note_id: note.id
      }
    }
  end

  context 'when success' do
    it 'returns created note of current_user' do
      authorized_graphql_post(
        query: user_note_tag_create_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserNoteTag::CreateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange note_id' do
      let(:variables) { { input: { note_id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_tag_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(NoteTag).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_note_tag_create_mutation,
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
          query: user_note_tag_create_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

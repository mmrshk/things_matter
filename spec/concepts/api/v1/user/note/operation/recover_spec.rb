# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Recover, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:token) { generate_token(account_id: current_user.id) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project, is_deleted: true, user_account: current_user) }
  let(:params) { { id: note.id } }

  context 'when recovers note and project exist' do
    it 'updates note' do
      expect do
        execute_operation && note.reload
      end.to change(note, :deleted).from(true).to(false).and(
        change(note, :deleted_date).from(note.deleted_date).to(nil)
      )
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when note id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

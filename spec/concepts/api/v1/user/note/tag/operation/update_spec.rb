# frozen_string_literal: true

describe Api::V1::User::Note::Tag::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:note) { create(:note, user_account: current_user) }
  let(:note_tag) { create(:note_tag, note: note) }
  let(:name) { FFaker::Lorem.word }
  let(:params) { { name: name, id: note_tag.id } }

  context 'when user updates note tag' do
    it 'updates noteTag' do
      expect { execute_operation && note_tag.reload }.to change(note_tag, :name).from(note_tag.name).to(name)
    end

    it 'returns status' do
      expect(execute_operation['result']).to be_truthy
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user not passes id' do
    let(:params) { { name: name } }

    it 'NOT updates noteTag' do
      expect { execute_operation && note_tag.reload }.not_to change(note_tag, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:note_tag) { create(:note_tag) }

    it 'NOT updates noteTag' do
      expect { execute_operation && note_tag.reload }.not_to change(note_tag, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

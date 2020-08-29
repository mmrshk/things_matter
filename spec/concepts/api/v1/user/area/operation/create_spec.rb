# frozen_string_literal: true

describe Api::V1::User::Area::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:params) { { name: name, type: 'note_area' } }
  let(:current_user) { create(:user_account) }
  let(:name) { FFaker::Lorem.word }

  context 'when user creates area' do
    it 'creates NoteArea' do
      expect { execute_operation }.to change(NoteArea, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates area WITHOUT name' do
    let(:params) { { type: 'note_area' } }

    it 'creates NoteArea' do
      expect { execute_operation }.to change(NoteArea, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates area WITH empty name' do
    let(:params) { { name: '', type: 'note_area' } }

    it 'creates NoteArea' do
      expect { execute_operation }.to change(NoteArea, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user not authorized to action' do
    let(:current_user) { nil }

    it 'NOT creates NoteArea' do
      expect { execute_operation }.not_to change(NoteArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

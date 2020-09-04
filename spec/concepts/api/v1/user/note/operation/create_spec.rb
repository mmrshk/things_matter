# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:project, user_account: current_user, type: 'NoteProject') }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:params) do
    {
      name: name,
      description: description,
      default: true,
      project_id: project.id
    }
  end

  context 'when user creates note' do
    it 'creates Note' do
      expect { execute_operation }.to change(Note, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITHOUT name and WITHOUT description' do
    let(:params) { { default: true, project_id: project.id } }

    it 'creates Note' do
      expect { execute_operation }.to change(Note, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITH area that not belongs to user' do
    let(:project) { create(:project) }

    it 'NOT creates Note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not passes project_id' do
    let(:params) { { default: true } }

    it 'NOT creates Note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:project) }
    let(:current_user) { nil }

    it 'NOT creates NoteArea' do
      expect { execute_operation }.not_to change(NoteArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

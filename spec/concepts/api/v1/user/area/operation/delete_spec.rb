# frozen_string_literal: true

describe Api::V1::User::Area::Operation::Delete, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:area) { create(:area, user_account: current_user, type: 'TaskArea') }
  let(:name) { FFaker::Lorem.word }

  let(:params) { { id: area.id } }

  before { area }

  context 'when user deletes area' do
    it 'deletes area' do
      expect { execute_operation }.to change(TaskArea, :count).from(1).to(0)
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to eq(true)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when area id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'NOT deletes area' do
      expect { execute_operation }.not_to change(TaskArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:area) { create(:area, type: 'TaskArea') }

    it 'NOT deletes area' do
      expect { execute_operation }.not_to change(TaskArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

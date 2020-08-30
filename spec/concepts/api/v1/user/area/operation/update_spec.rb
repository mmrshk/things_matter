# frozen_string_literal: true

describe Api::V1::User::Area::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:area) { create(:area, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }

  let(:params) { { id: area.id, name: name } }

  context 'when user updates area' do
    it 'updates area' do
      expect { execute_operation && area.reload }.to change(area, :name).from(area.name).to(name)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when area id NOT exist' do
    let(:params) { { id: SecureRandom.uuid, name: name } }

    it 'NOT updates area' do
      expect { execute_operation && area.reload }.not_to change(area, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:area) { create(:area) }

    it 'NOT updates area' do
      expect { execute_operation && area.reload }.not_to change(area, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

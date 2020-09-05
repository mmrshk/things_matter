# frozen_string_literal: true

describe Api::V1::User::Project::Contract::CreateUpdate, type: :contract do
  subject(:contract) do
    contract = described_class.new(Project.new)
    contract.validate(params)
    contract
  end

  let(:errors) { contract.errors.messages }

  let(:user_account) { create(:user_account) }
  let(:area) { create(:area, user_account: user_account) }

  let(:default_params) do
    {
      name: FFaker::Lorem.word,
      deadline: Time.zone.now + 1.day,
      area_id: area.id,
      user_account_id: user_account.id
    }
  end

  describe 'SUCCESS' do
    context 'when WITH area' do
      let(:params) { default_params }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end

    context 'when WITHOUT area' do
      let(:params) { default_params.except(:area_id) }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end

    context 'when area passed as nil' do
      let(:params) { default_params.merge(area_id: nil) }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end
  end

  describe 'FAILURE' do
    context 'when area not exist' do
      let(:params) { default_params.merge(area_id: SecureRandom.uuid) }
      let(:expected_errors) do
        {
          area_id: [I18n.t('errors.area_existence?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid deadline' do
      let(:params) { default_params.merge(deadline: Time.zone.now) }
      let(:expected_errors) do
        {
          deadline: [I18n.t('errors.valid_deadline?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid user_account' do
      let(:params) { default_params.merge(user_account_id: FFaker::Lorem.word) }

      let(:expected_errors) do
        {
          user_account_id: [I18n.t('errors.uuid_v4?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when area not belongs to user' do
      let(:area) { create(:area) }
      let(:params) { default_params.merge(area_id: area.id) }

      let(:expected_errors) do
        {
          user_account_id: [
            I18n.t('errors.area_belongs_to_user?')
          ]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end
  end
end

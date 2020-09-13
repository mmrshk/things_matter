# frozen_string_literal: true

describe Api::V1::User::Task::Contract::Update, type: :contract do
  subject(:contract) do
    contract = described_class.new(Task.new)
    contract.validate(params)
    contract
  end

  let(:errors) { contract.errors.messages }

  let(:user_account) { create(:user_account) }
  let(:project) { create(:task_project, user_account: user_account) }

  let(:default_params) do
    {
      name: FFaker::Lorem.word,
      description: FFaker::Lorem.sentence,
      done: false,
      deleted: false,
      to_do_day: Date.today,
      deadline: Date.today + 7.days,
      task_project_id: project.id
    }
  end

  describe 'SUCCESS' do
    context 'when correct' do
      let(:params) { default_params }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end
  end

  describe 'FAILURE' do
    context 'when project not exist' do
      let(:params) { default_params.merge(task_project_id: SecureRandom.uuid) }
      let(:expected_errors) do
        {
          task_project_id: [I18n.t('errors.project_existence?')]
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
      let(:params) { default_params.merge(deadline: Date.yesterday) }
      let(:expected_errors) do
        {
          deadline: [I18n.t('errors.valid_date?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid to_do_day' do
      let(:params) { default_params.merge(to_do_day: Date.yesterday) }
      let(:expected_errors) do
        {
          to_do_day: [I18n.t('errors.valid_date?')]
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

# frozen_string_literal: true

describe Api::V1::User::Note::Contract::Update, type: :contract do
  subject(:contract) do
    contract = described_class.new(Note.new)
    contract.validate(params)
    contract
  end

  let(:errors) { contract.errors.messages }

  let(:note) { create(:note) }

  let(:new_project) { create(:project) }

  let(:default_params) do
    {
      name: FFaker::Lorem.word,
      description: FFaker::Lorem.sentence,
      default: true,
      project_id: new_project.id
    }
  end

  describe 'SUCCESS' do
    context 'when WITHOUT name' do
      let(:params) { default_params.except(:name) }

      it 'returns valid' do
        expect(contract).to be_valid
      end

      it 'not changes name' do
        expect { contract && note.reload }.not_to change(note, :name)
      end
    end

    context 'when WITHOUT description' do
      let(:params) { default_params.except(:description) }

      it 'returns valid' do
        expect(contract).to be_valid
      end

      it 'not changes name' do
        expect { contract && note.reload }.not_to change(note, :description)
      end
    end

    context 'when WITH project_id' do
      let(:params) { default_params }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end

    context 'when WITHOUT project_id' do
      let(:params) { default_params.except(:project_id) }

      it 'returns valid' do
        expect(contract).to be_valid
      end

      it 'not changes name' do
        expect { contract && note.reload }.not_to change(note, :project_id)
      end
    end

    context 'when project_id passed as nil' do
      let(:params) { default_params.merge(project_id: nil) }

      it 'returns valid' do
        expect(contract).to be_valid
      end
    end
  end

  describe 'FAILURE' do
    context 'when project not exist' do
      let(:params) { default_params.merge(project_id: SecureRandom.uuid) }
      let(:expected_errors) do
        {
          project_id: [I18n.t('errors.project_existence?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid description' do
      let(:params) { default_params.merge(description: 1) }
      let(:expected_errors) do
        {
          description: [I18n.t('errors.str?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid default' do
      let(:params) { default_params.merge(default: 1) }

      let(:expected_errors) do
        {
          default: [I18n.t('errors.bool?')]
        }
      end

      it 'returns invalid' do
        expect(contract).not_to be_valid
      end

      it 'returns correct errors' do
        expect(errors).to eq expected_errors
      end
    end

    context 'when invalid project_id' do
      let(:params) { default_params.merge(project_id: 1) }

      let(:expected_errors) do
        {
          project_id: [I18n.t('errors.uuid_v4?'),I18n.t('errors.project_existence?')]
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

# frozen_string_literal: true

describe Api::V1::User::TaskProject::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:area) { create(:task_area, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }
  let(:deadline) { Date.today }

  let(:params) { { name: name, task_area_id: area.id, deadline: deadline } }

  context 'when user creates project' do
    it 'creates TaskProject' do
      expect { execute_operation }.to change(TaskProject, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITHOUT name and WITHOUT deadline' do
    let(:params) { { type: 'task_project', task_area_id: area.id } }

    it 'creates TaskProject' do
      expect { execute_operation }.to change(TaskProject, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITH area that not belongs to user' do
    let(:area) { create(:task_area) }

    it 'NOT creates NoteArea' do
      expect { execute_operation }.not_to change(NoteArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:params) { { name: name, task_area_id: area, deadline: deadline } }
    let(:current_user) { nil }
    let(:area) { nil }

    it 'NOT creates NoteArea' do
      expect { execute_operation }.not_to change(NoteArea, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

# frozen_string_literal: true

describe Api::V1::User::TaskProject::Operation::Index, type: :operation do
  subject(:execute_operation) { described_class.call(filter: filter, current_user: user_account) }

  let(:user_account) { create(:user_account) }
  let(:task_project_first) { create(:task_project, user_account: user_account) }
  let(:task_project_second) { create(:task_project, user_account: user_account) }

  context 'when trash filter' do
    let!(:deleted_tasks) { create_list(:task, 3, task_project: task_project_first, deleted: true) }
    let!(:tasks) { create_list(:task, 3, task_project: task_project_second) }

    let(:filter) { 'trash' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([task_project_first])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when logbook filter' do
    let!(:done_tasks) { create_list(:task, 3, task_project: task_project_first, done: true) }
    let!(:tasks) { create_list(:task, 3, task_project: task_project_second) }

    let(:filter) { 'logbook' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([task_project_first])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when anytime filter' do
    let!(:done_tasks) { create_list(:task, 3, task_project: task_project_first) }
    let!(:tasks) { create_list(:task, 3, task_project: task_project_second, done: true) }

    let(:filter) { 'anytime' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([task_project_first])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when without filter' do
    let!(:done_tasks) { create_list(:task, 3, task_project: task_project_first) }
    let!(:tasks) { create_list(:task, 3, task_project: task_project_second, done: true) }

    let(:filter) { nil }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(user_account.task_projects)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end
end

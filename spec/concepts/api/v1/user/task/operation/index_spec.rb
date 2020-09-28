# frozen_string_literal: true

describe Api::V1::User::Task::Operation::Index, type: :operation do
  subject(:execute_operation) { described_class.call(filter: filter, current_user: user_account) }

  let(:user_account) { create(:user_account) }
  let(:task_project) { create(:task_project, user_account: user_account) }

  context 'when today filter' do
    let!(:today_task) { create(:task, to_do_day: Time.zone.today, task_project: task_project) }
    let!(:yesterday_task) { create(:task, to_do_day: Time.zone.today - 1, task_project: task_project) }
    let!(:tomorrow_task) { create(:task, to_do_day: Time.zone.today + 1, task_project: task_project) }
    let(:filter) { 'today' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([today_task])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when trash filter' do
    let!(:today_task) { create(:task, to_do_day: Time.zone.today, task_project: task_project, deleted: true) }
    let!(:yesterday_task) { create(:task, to_do_day: Time.zone.today - 1, task_project: task_project) }
    let!(:tomorrow_task) { create(:task, to_do_day: Time.zone.today + 1, task_project: task_project) }

    let(:filter) { 'trash' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([today_task])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when logbook filter' do
    let!(:today_task) { create(:task, to_do_day: Time.zone.today, task_project: task_project, done: true) }
    let!(:yesterday_task) { create(:task, to_do_day: Time.zone.today - 1, task_project: task_project) }
    let!(:tomorrow_task) { create(:task, to_do_day: Time.zone.today + 1, task_project: task_project) }

    let(:filter) { 'logbook' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([today_task])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  xcontext 'when someday filter' do
    let!(:today_task) { create(:task, to_do_day: Time.zone.today, task_project: nil) }
    let!(:yesterday_task) { create(:task, to_do_day: Time.zone.today - 1, task_project: task_project) }
    let!(:tomorrow_task) { create(:task, to_do_day: Time.zone.today + 1, task_project: task_project) }

    let(:filter) { 'logbook' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([today_task])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when anytime filter' do
    let!(:today_task) { create(:task, to_do_day: Time.zone.today, task_project: task_project, done: false) }
    let!(:yesterday_task) { create(:task, to_do_day: Time.zone.today - 1, task_project: task_project, done: true) }
    let!(:tomorrow_task) { create(:task, to_do_day: Time.zone.today + 1, task_project: task_project, done: true) }

    let(:filter) { 'anytime' }

    it 'returns user_account' do
      expect(execute_operation['result']).to eq([today_task])
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end
end

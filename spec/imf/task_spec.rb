RSpec.describe IMF::Task do
  let(:template) do
    IMF.build_task_template(requirements: [IMF::Task::Requirement::NullOne.new(id: '300')])
  end

  let(:task) { template.materialize }

  it 'move the status with events' do
    start_evt = IMF::Event::StartTask.new
    success_evt = IMF::Event::CompleteSuccess.new
    fail_evt = IMF::Event::CompleteFail.new

    expect(task.status).to eq 'created'
    task.apply start_evt
    expect(task.status).to eq 'started'
    task.apply fail_evt
    expect(task.status).to eq 'completed_failed'
    task.apply success_evt
    expect(task.status).to eq 'completed_succeeded'
  end
end

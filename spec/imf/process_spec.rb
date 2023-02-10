RSpec.describe IMF::Process do
  let(:process_template) do
    task_templ_1 = IMF.build_task_template(
      requirements: [
        IMF::Task::Requirement::NullOne,
        IMF::Task::Requirement::NullTwo.new(id: '100', val1: 1, val2: 2),
      ],
    )
    task_templ_2 = IMF.build_task_template(
      requirements: [IMF::Task::Requirement::NullTwo],
    )

    stage_1 = IMF.build_stage_template 'first', [], task_templ_1, false
    stage_2 = IMF.build_stage_template 'last', ['first'], task_templ_2, true

    IMF.build_process_template [stage_2, stage_1]
  end

  let(:process_template_full) do
    task_templ_1 = IMF.build_task_template(requirements: [IMF::Task::Requirement::NullOne.new(id: '200')])
    task_templ_2 = IMF.build_task_template(requirements: [IMF::Task::Requirement::NullTwo.new(id: '101', val1: 7, val2: 8)])

    stage_1 = IMF.build_stage_template 'first', [], task_templ_1, false
    stage_2 = IMF.build_stage_template 'last', ['first'], task_templ_2, false

    IMF.build_process_template [stage_1, stage_2]
  end

  it 'instance a template process' do
    expect(process_template.stages).not_to be_empty

    st2, st1 = process_template.stages

    expect(st1.id).to eq 'first'
    expect(st1.multitask).to be false
    expect(st1.dependencies).to be_empty
    expect(st1.task_template).not_to be_nil

    expect(st2.id).to eq 'last'
    expect(st2.multitask).to be true
    expect(st2.dependencies).not_to be_empty
    expect(st2.task_template).not_to be_nil
  end

  context 'instance a process from a template' do
    it 'with correct information' do
      tasks = process_template.materialize(
        'first' => [
          { requirements: [{ type: 'null_one', params: {} }] },
        ],
        'last' => [
          { requirements: [{ type: 'null_two', params: { val1: 3, val2: 4 } }] },
          { requirements: [{ type: 'null_two', params: { val1: 5, val2: 6 } }] },
        ],
      )

      expect(tasks.size).to eq 3
      expect(tasks.first.stage).not_to be_nil
      expect(tasks.first.process).not_to be_nil
    end

    it 'omitting data correctly' do
      expect(process_template_full.materialize.size).to eq 2
    end

    it 'wont overwrite a fixed section' do
      params = { 'first' => [{ requirements: [{ type: 'null_one', params: {} }] }] }

      error_msg = 'Not allowed to overwrite a fixed section [requirements] with [{:type=>"null_one", :params=>{}}]'

      expect { process_template_full.materialize(params) }.to raise_error error_msg
    end

    it 'wont overwrite a closed section' do
      params = {
        'first' => [{ costs: [{ type: 'null_one', params: {} }] }],
      }

      error_msg = 'Not allowed to overwrite a closed section: costs'

      expect { process_template_full.materialize(params) }.to raise_error error_msg
    end
  end

  it 'check stage-dependencies when applying events' do
    start_evt = IMF::Event::StartTask.new
    complete_evt = IMF::Event::CompleteSuccess.new

    one, two = process_template_full.materialize

    expect(one.status).to eq 'created'
    expect(two.status).to eq 'created'

    one.apply(start_evt)
    expect{ two.apply(start_evt) }.to raise_error "Dependencies not completed: [\"first\"]"

    expect(one.status).to eq 'started'
    expect(two.status).to eq 'created'

    one.apply(complete_evt)
    two.apply(complete_evt) # do nothing because wrong event in given moment

    expect(one.status).to eq 'completed_succeeded'
    expect(two.status).to eq 'created'

    # correct sequence with dependencies solved
    two.apply(start_evt)
    expect(two.status).to eq 'started'

    two.apply(complete_evt)
    expect(two.status).to eq 'completed_succeeded'
  end
end

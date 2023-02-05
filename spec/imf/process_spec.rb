RSpec.describe IMF::Process do
  let(:process_template) do
    task_templ_1 = IMF.build_task_template(
      requirements: [
        IMF::Task::Requirement::NullOne,
        IMF::Task::Requirement::NullTwo.new(val1: 1, val2: 2),
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
    task_templ_1 = IMF.build_task_template(requirements: [IMF::Task::Requirement::NullOne.new])
    task_templ_2 = IMF.build_task_template(requirements: [IMF::Task::Requirement::NullTwo.new(val1: 7, val2: 8)])

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
    end

    it 'omitting data correctly' do
      expect(process_template_full.materialize.size).to eq 2
    end

    it 'wont overwrite a fixed section' do
      params = { 'first' => [{ requirements: [{ type: 'null_one', params: {} }] }] }

      error_msg = 'Not allowed to overwrite a fixed section [requirements] with [{:type=>"null_one", :params=>{}}]'

      expect{ process_template_full.materialize(params) }.to raise_error error_msg
    end

    it 'wont overwrite a closed section' do
      params = {
        'first' => [{ costs: [{ type: 'null_one', params: {} }] }],
      }

      error_msg = 'Not allowed to overwrite a closed section: costs'

      expect{ process_template_full.materialize(params) }.to raise_error error_msg
    end
  end

  it 'add a task to a process stage'
end

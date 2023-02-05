RSpec.describe IMF::Process do
  it 'instance a template process' do
    task_templ_1 = IMF.build_task_template(
      requirements: [IMF::Task::Requirement::Null],
    )
    task_templ_2 = IMF.build_task_template(
      requirements: [IMF::Task::Requirement::Null.new],
    )

    stage_1 = IMF.build_stage_template [], task_templ_1, false
    stage_2 = IMF.build_stage_template [stage_1], task_templ_2, true

    template = IMF.build_process_template [stage_1, stage_2]

    expect(template.stages).not_to be_empty
    expect(template.stages.first.multitask).to be false
    expect(template.stages.first.dependencies).to be_empty

    expect(template.stages.last.multitask).to be true
    expect(template.stages.last.dependencies).not_to be_empty
  end
end

class IMF::Process::Stage::Template
  attr_reader :dependencies, :task_template, :multitask

  # @param [Array(Stage)] dependencies
  # @param [Task::Template] task_template
  # @param [boolean] multitask
  def initialize(dependencies, task_template, multitask)
    @dependencies = dependencies
    @task_template = task_template
    @multitask = multitask
  end
end

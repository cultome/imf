class IMF::Process::Stage::Template
  attr_reader :id, :dependencies, :task_template, :multitask

  # @param [String] id identifier for this template
  # @param [Array(String)] dependencies id of the dependencies stages
  # @param [Task::Template] task_template
  # @param [boolean] multitask
  def initialize(id:, dependencies:, task_template:, multitask:)
    @id = id
    @dependencies = dependencies
    @task_template = task_template
    @multitask = multitask
  end
end

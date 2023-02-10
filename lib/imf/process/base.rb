class IMF::Process::Base
  attr_reader :id
  attr_accessor :tasks

  # @params [String] id
  # @params [Array(IMF::Task::Base)] tasks. DEfaults to []
  def initialize(id:, tasks: [])
    @id = id
    @tasks = tasks
  end
end

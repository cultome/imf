class IMF::Process::Template
  attr_reader :stages

  # @params [Array(Stage)] stages
  def initialize(stages)
    @stages = stages
  end
end

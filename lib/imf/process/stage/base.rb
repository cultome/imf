class IMF::Process::Stage::Base
  attr_reader :id, :dependencies

  def initialize(id:, dependencies:)
    @id = id
    @dependencies = dependencies
  end
end

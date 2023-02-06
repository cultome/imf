class IMF::Process::Base
  attr_reader :id

  # @params [String] id
  def initialize(id:)
    @id = id
  end
end

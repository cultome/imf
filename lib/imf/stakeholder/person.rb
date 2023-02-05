# Base class for stakeholders. Specialized classes will overwrite the methods defined in here
class IMF::Stakeholder::Person
  attr_reader :name, :contacts

  # @param [String] name
  # @param [Array(Contact)] name
  def initialize(name, contacts)
    @name = name
    @contacts = contacts
  end
end

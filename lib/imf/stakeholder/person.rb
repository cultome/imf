# Base class for stakeholders. Specialized classes will overwrite the methods defined in here
class IMF::Stakeholder::Person
  attr_reader :name, :contacts, :external

  # @param [String] name
  # @param [Array(Contact)] name
  # @param [boolean] external stakeholder external to the company?
  def initialize(name, contacts, external = true)
    @name = name
    @contacts = contacts
    @external = external
  end
end

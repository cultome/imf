class IMF::Task::Base
  attr_reader :status, :process, :stage, :transitions, :requirements, :constraints, :stakeholders, :objectives, :costs, :assignees

  # The allowed values for each "data section" are as follow:
  # nil: the section wont be available (none)
  # class: the section is available and required to fill (open)
  # instance: the section is available but not editable (fixed)
  # empty array: error
  #
  # @param [String] status
  # @param [IMF::Process::Stage::Base] stage
  # @param [IMF::Process::Base] process
  # @param [IMF::Task::EventTransitions] transitions
  # @param [Array(Requirement)] requirements
  # @param [Array(Constraint)] constraints
  # @param [Array(Stakeholder)] stakeholders
  # @param [Array(Objective)] objectives
  # @param [Array(Const)] costs
  # @param [Array(Stakeholder)] assignees
  def initialize(
    status: 'created',
    stage: nil,
    process: nil,
    transitions: nil,
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil
  )

    @status = status
    @stage = stage
    @process = process
    @transitions = transitions

    check_param! requirements, 'Requirements'
    check_param! constraints, 'Constraints'
    check_param! stakeholders, 'Stakeholders'
    check_param! objectives, 'Objectives'
    check_param! costs, 'Costs'
    check_param! assignees, 'Assignees'

    @requirements = requirements
    @constraints = constraints
    @stakeholders = stakeholders
    @objectives = objectives
    @costs = costs
    @assignees = assignees
  end

  # @param [IMF::Event] event
  def apply(event)
    new_status = transitions.dig(status, event.name)
    # if nil, try the catch-all
    new_status = transitions.dig(status, '*') if new_status.nil?
    # nope? ok, the lets stay in the same status
    new_status = status if new_status.nil?

    @status = new_status
  end

  private

  def check_param!(value, name)
    raise "#{name} list cannot be empty" if !value.nil? && value.empty?
  end
end

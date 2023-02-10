# frozen_string_literal: true

require 'securerandom'
require 'json'
require_relative 'imf/version'

module IMF
  extend self

  # @param [String] email
  def build_email_contact(email, id: nil)
    IMF::Stakeholder::EmailContact.new(
      id: id.nil? ? SecureRandom.uuid : id,
      value: email
    )
  end

  # @param [String] name
  # @param [Array(Contact)] name
  def build_client(name, contacts, id: nil)
    IMF::Stakeholder::ClientPerson.new(
      id: id.nil? ? SecureRandom.uuid : id,
      name:, contacts:
    )
  end

  # @param [String] id identifier for this stage
  # @param [Array(Stage)] dependencies
  # @param [Task::Template] task_template
  # @param [boolean] multitask
  def build_stage_template(id, dependencies, task_template, multitask)
    IMF::Process::Stage::Template.new id:, dependencies:, task_template:, multitask:
  end

  # @params [Array(IMF::Process::Stage::Template)] stages
  def build_process_template(stages, id: nil)
    IMF::Process::Template.new(
      id: id.nil? ? SecureRandom.uuid : id,
      stages:
    )
  end

  # The allowed values for each "data section" are as follow:
  # nil: the section wont be available (none)
  # class: the section is available and required to fill (open)
  # instance: the section is available but not editable (fixed)
  #
  # @param [Array(Requirement)] requirements
  # @param [Array(Constraint)] constraints
  # @param [Array(Stakeholder)] stakeholders
  # @param [Array(Objective)] objectives
  # @param [Array(Const)] costs
  # @param [Array(Stakeholder)] assignees
  def build_task_template(
    id: nil,
    requirements: nil,
    constraints: nil,
    stakeholders: nil,
    objectives: nil,
    costs: nil,
    assignees: nil)
    IMF::Task::Template.new(
      id: id.nil? ? SecureRandom.uuid : id,
      requirements:,
      constraints:,
      stakeholders:,
      objectives:,
      costs:,
      assignees:
    )
  end
end

require_relative './imf/monkeypatches'
require_relative './imf/event'
require_relative './imf/stakeholder'
require_relative './imf/task'
require_relative './imf/process'
require_relative './imf/store'

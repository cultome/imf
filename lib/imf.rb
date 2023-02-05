# frozen_string_literal: true

require_relative 'imf/version'

module IMF
  extend self

  # @param [String] email
  def build_email_contact(email)
    IMF::Stakeholder::EmailContact.new email
  end

  # @param [String] name
  # @param [Array(Contact)] name
  def build_client(name, contacts)
    IMF::Stakeholder::Client.new name, contacts
  end
end

require_relative './imf/stakeholder'

class IMF::Task::Requirement::Base
  def self.as_type
    @as_type ||= name.
      split('::').
      last.
      gsub(/([A-Z])/, '_\1').
      gsub(/^_/, '').
      downcase
  end

  def as_type
    @as_type ||= self.class.as_type
  end
end

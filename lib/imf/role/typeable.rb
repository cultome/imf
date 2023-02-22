module IMF::Role::Typeable
  def self.to_type(value)
    value.
      split('::').
      last.
      gsub(/([A-Z])/, '_\1').
      gsub(/^_/, '').
      downcase
  end

  def as_type
    IMF::Role::Typeable.to_type self.class.name
  end

  module ExtMethods
    def as_type
      IMF::Role::Typeable.to_type name
    end
  end

  def self.included(base)
    base.extend ExtMethods
  end
end

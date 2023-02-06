module IMF::Event
  class Base
    def name
      self.class.name.split('::').last.to_camelcase
    end
  end

  class StartTask < Base
    # TODO: here comes more data
  end

  class CompleteSuccess < Base
    # TODO: here comes more data
  end

  class CompleteFail < Base
    # TODO: here comes more data
  end
end

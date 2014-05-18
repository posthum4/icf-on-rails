module Warnings

  class JiraAlreadyExisted_NotOverwritten < StandardError ; end

  class StandardError
    def to_s
      inspect
    end
  end

end

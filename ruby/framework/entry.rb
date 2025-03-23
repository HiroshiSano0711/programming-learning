require './printer'

class Entry
  include Printer

  def add(entry)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def create(entry)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

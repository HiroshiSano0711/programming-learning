require_relative './entry'

class Folder < Entry
  attr_reader :name

  def initialize(name)
    @name = name
    @items = []
  end

  def add(item)
    @items << item
  end

  def create(prefix)
    system 'mkdir', '-p', prefix

    @items.each do |item|
      print_for_generator("#{prefix}/#{item.name}")
      item.create(prefix + '/' + item.name)
    end
  end
end

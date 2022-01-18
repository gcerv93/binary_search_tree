# frozen_string_literal: true

# class for tree nodes
class Node
  attr_reader :data

  include Comparable
  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

  def <=>(other)
    data <=> other.data
  end
end

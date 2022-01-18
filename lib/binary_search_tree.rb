# frozen_string_literal: true

# class for tree nodes
class Node
  attr_accessor :data, :left, :right

  include Comparable
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end

# class for the binary tree
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  # returns the level 0 root node
  def build_tree(arr)
    return nil if arr.empty?

    arr_copy = arr.uniq.sort
    mid = arr_copy.length / 2
    root = Node.new(arr_copy[mid])
    root.left = build_tree(arr_copy[0...mid])
    root.right = build_tree(arr_copy[mid + 1..arr_copy.length])
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

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

  def build_tree(arr)
    return nil if arr.empty?

    arr_copy = arr.uniq.sort
    mid = arr_copy.length / 2
    root = Node.new(arr_copy[mid])
    root.left = build_tree(arr_copy[0...mid])
    root.right = build_tree(arr_copy[mid + 1..arr_copy.length])
    root
  end

  def insert(value, root_node = @root)
    node = Node.new(value)
    return node if root_node.nil?

    if node < root_node
      root_node.left = insert(value, root_node.left)
    elsif node > root_node
      root_node.right = insert(value, root_node.right)
    end
    root_node
  end

  def delete(value)
    root = self.root
    until root.data == value
      parent = root
      if value < root.data
        root = root.left
      elsif value > root.data
        root = root.right
      end
    end
    delete_leaf(parent, value) if root.left.nil? && root.right.nil?
    delete_single_child(parent, root) if root.left.nil? || root.right.nil?
  end

  def delete_leaf(parent, value)
    if value < parent.data
      parent.left = nil
    elsif value > parent.data
      parent.right = nil
    end
  end

  def delete_single_child(parent, node)
    if node > parent
      parent.right = node.right.nil? ? node.left : node.right
    else
      parent.left = node.right.nil? ? node.left : node.right
    end
  end

  def find(value, root = @root)
    return puts 'Node not found' if root.nil?
    return root if root.data == value

    if value < root.data
      find(value, root.left)
    else
      find(value, root.right)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

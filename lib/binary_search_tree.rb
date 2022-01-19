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
# rubocop: disable Metrics/ClassLength
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
    # root here is node to delete
    # parent is parent of node to delete
    root = find(value)
    parent = find_parent(value)
    if root.left.nil? && root.right.nil?
      delete_leaf(parent, value)
    elsif root.left.nil? || root.right.nil?
      delete_single_child(parent, root)
    else
      # send right subtree to delete double child method
      delete_double_child(root, root.right)
    end
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

  def delete_double_child(node_to_delete, next_biggest)
    # find the successor to the node
    next_biggest = next_biggest.left until next_biggest.left.nil?

    # find the parent to the successor node and delete the correct child
    succ_parent = find_parent(next_biggest.data)
    if succ_parent.left == next_biggest
      succ_parent.left = nil
    elsif succ_parent.right == next_biggest
      succ_parent.right = nil
    end

    # copy the successor data into the node to be deleted
    node_to_delete.data = next_biggest.data
  end

  def find_parent(value)
    root = self.root
    until root.data == value
      parent = root
      if value < root.data
        root = root.left
      elsif value > root.data
        root = root.right
      end
    end
    parent
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

  def level_order
    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift

      # enqueue children nodes if not nil
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?

      # push to result depending on conditional
      result.push(block_given? ? yield(node.data) : node.data)
    end
    result
  end

  def recursive_level_order(queue = [@root], result = [])
    return result if queue.empty?

    node = queue.shift
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    result.push(block_given? ? yield(node.data) : node.data)
    recursive_level_order(queue, result)
    result
  end

  def inorder(root = @root, result = [], &block)
    return result if root.nil?

    inorder(root.left, result, &block)
    result.push(block_given? ? yield(root.data) : root.data)
    inorder(root.right, result, &block)
    result
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
# rubocop: enable Metrics/ClassLength

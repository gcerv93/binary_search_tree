# frozen_string_literal: true

require './lib/binary_search_tree'

tree = Tree.new(Array.new(15) {rand(1..100) })
tree.pretty_print
puts "Balanced: #{tree.balanced?}\n\n"

puts 'Level order:'
p tree.level_order
puts 'Preorder:'
p tree.preorder
puts 'Postorder:'
p tree.postorder
puts 'Inorder:'
p tree.inorder

puts "\n\n"

tree.insert(200)
tree.insert(420)
tree.insert(690)
tree.pretty_print
puts "Balanced: #{tree.balanced?}\n\n"
tree.rebalance
tree.pretty_print
puts "Balanced: #{tree.balanced?}"

puts 'Level order:'
p tree.level_order
puts 'Preorder:'
p tree.preorder
puts 'Postorder:'
p tree.postorder
puts 'Inorder:'
p tree.inorder

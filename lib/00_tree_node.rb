require 'byebug'

class PolyTreeNode

attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def inspect
    @value.inspect
  end

  def value
    @value
  end

  def parent=(node)
    if node.nil?
      @parent.children.reject! { |child| child == self }
      @parent = nil
    elsif self.parent.nil? #no parent before
      @parent = node
      node.children << self
    elsif @parent != node #new parent from diff parent
      @parent.children.reject! { |child| child == self }
      @parent = node
      @parent.children << self
    end
  end

  def add_child(node)
    node.parent=(self)
  end

  def remove_child(node)
    node.parent=(nil)
  end

  def dfs(target_value)
    return self if @value == target_value
    self.children.each do |child|
      result = child.dfs(target_value)
      #if result is a value, just return
      return result if result
      #if it is nil AND there are more, keep searching

    end
    #if it is nil and we are reached the end, return nil
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.pop
      return current_node if current_node.value == target_value
      queue.unshift(current_node.children.reverse)
      queue.flatten!
    end
    nil
  end
end

#
# node1 = PolyTreeNode.new('root')
# node2 = PolyTreeNode.new('child1')
# node3 = PolyTreeNode.new('child2')
#
# node2.parent=(node1)
# p node2.parent == 'root'
# node3.parent=(node1)
# p node3.parent == 'root'
# node3.parent=(node2)

# a = PolyTreeNode.new("a")
# a.parent

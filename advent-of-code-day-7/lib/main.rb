require 'parslet'

class ExploratoryParser < Parslet::Parser
  root(:instruction)
  rule(:instruction) {
    source.as(:source) >> str(' -> ') >> destination.as(:destination)
  }
  
  rule(:source) {
    literal.as(:literal) |
    unary_op.as(:unary_op) |
    binary_op.as(:binary_op)
  }
  rule(:destination) { wire_name }
  
  rule(:literal) { integer }
  rule(:unary_op) { not_source.as(:not) | shift_op }
  rule(:shift_op) { lshift_source.as(:lshift) | rshift_source.as(:rshift) }
  rule(:binary_op) { and_source.as(:and) | or_source.as(:or) }
  
  rule(:not_source) {
    str('NOT') >> sp >> wire_name.as(:wire)
  }
  rule(:lshift_source) {
    wire_name.as(:wire) >> sp >> str('LSHIFT') >> sp >> integer.as(:shift_by)
  }
  rule(:rshift_source) {
    wire_name.as(:wire) >> sp >> str('RSHIFT') >> sp >> integer.as(:shift_by)
  }
  rule(:and_source) {
    wire_name.as(:wire1) >> sp >> str('AND') >> sp >> wire_name.as(:wire2)
  }
  rule(:or_source) {
    wire_name.as(:wire1) >> sp >> str('OR') >> sp >> wire_name.as(:wire2)
  }
  
  rule(:sp) { str(' ') } # space
  rule(:integer) { match('[0-9]').repeat(1) }
  rule(:wire_name) { match('[a-z]').repeat(1) }
end

class InstructionsParser
  def initialize(instructions_reader)
    @instructions_reader = instructions_reader
  end
  
  include Enumerable
  def each
    while line = @instructions_reader.gets
      line = line.chomp
      yield parse_one_instruction(line)
    end
  end
  
  private

  def parse_one_instruction(line)
    {} # TODO
  end
end


if __FILE__ == $0
end

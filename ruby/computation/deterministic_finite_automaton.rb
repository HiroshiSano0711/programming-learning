# 規則。入力ストリームの1文字が規則に沿っているかどうかを判定したりする
class FARule < Struct.new(:state, :character, :next_state)
  def applies_to?(state, character)
    self.state == state && self.character == character
  end

  def follow
    next_state
  end

  def inspect
    "#<FARule #{state.inspect} --#{character}--> #{next_state.inspect}"
  end
end

# 規則集。規則（FARule）の集合。
class DFARuleBook < Struct.new(:rule)
  def next_state(state, character)
    rule_for(state, character).follow
  end

  def rule_for(state, character)
    rule.detect { |rule| rule.applies_to?(state, character) }
  end
end

# 現在の状態を記録して受理状態
class DFA < Struct.new(:current_state, :accept_states, :rulebook)
  def accepting?
    accept_states.include?(current_state)
  end

  def read_character(character)
    self.current_state = rulebook.next_state(current_state, character)
  end

  def read_string(string)
    string.chars.each do |character|
      read_character(character)
    end
  end
end

class DFADesign < Struct.new(:start_state, :accept_states, :rulebook)
  def to_dfa
    DFA.new(start_state, accept_states, rulebook)
  end

  def accepts?(string)
    to_dfa.tap { |dfa| dfa.read_string(string) }.accepting?
  end
end

rulebook = DFARuleBook.new([
  FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
  FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
  FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
])

dfa = DFA.new(1, [3], rulebook)
p dfa.accepting? #=> false
dfa.read_character('b')
p dfa.accepting? #=> false
3.times do dfa.read_character('a') end
p dfa.accepting? #=> false
dfa.read_character('b')
p dfa.accepting? #=> true
dfa.read_string('baaab')
p dfa.accepting?
dfa_design = DFADesign.new(1, [3], rulebook)
p dfa_design.accepts?('a')
p dfa_design.accepts?('baa')
p dfa_design.accepts?('baba')

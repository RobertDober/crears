require "./spec_helper"
require "../src/crears/scanner"

include Crears::Scanner

describe Crears::Scanner do
  tests =
  [
    { "",         Blank.new(line: "", lnb: 42) },
    { "   ",         Blank.new(line: "", lnb: 42) },
    { "* ab",        ListItem.new(bullet: "*", content: "ab", line: "* ab", lnb: 42, indent: 0, list_indent: 2, type: ListType::Ul) },
    { "x*   ab",     Text.new(content: "x*   ab", indent: 0, line: "x*   ab", lnb:42) } ,
    { "   x*   ab",     Text.new(content: "x*   ab", indent: 3, line: "   x*   ab", lnb:42) } ,
    { "    x*   ab",     Indent.new(content: "x*   ab", indent: 4, line: "    x*   ab", lnb:42) } ,
  ] # of Tuple(String, BaseToken)
  tests.each_with_index do |(input, expected), idx|
    it "Example: #{idx.succ}, transforms #{input.inspect} into #{expected}" do
      token = Crears::Scanner.line(line: input, lnb: 42)
      token.should eq(expected)
    end
  end
end

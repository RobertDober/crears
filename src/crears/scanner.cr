require "./scanner/line_types"
module Crears::Scanner extend self

  BlankRgx = /\A\s*\z/
  IndentRgx = /\A(\s{4,})(.*)/
  ListItemRgx = /\A(\s{0,3})([*-])\s(\s*)(.*)/
  TextRgx     = /\A(\s{0,3})(\S.*)/
  def line(line : String, lnb : Int32 = 0)
    case line 
    when BlankRgx
      Blank.new("", lnb)
    when ListItemRgx
      ListItem.new(
        line: line,
        lnb: lnb,
        content: "#{$3}#{$4}",
        bullet: $2,
        indent: $1.size,
        list_indent: $1.size + $2.size + $3.size + 1, 
        type: ListType::Ul)
    when TextRgx
      Text.new(content: $2, line: line, indent: $1.size, lnb: lnb)
    when IndentRgx
      Indent.new(content: $2, line: line, indent: $1.size, lnb: lnb)
    end
  end
end

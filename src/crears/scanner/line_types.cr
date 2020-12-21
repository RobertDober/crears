module Crears::Scanner
  abstract struct BaseToken
    property line
    property lnb
    def initialize(@line : String = "", @lnb : Int32 = 0)
    end
  end

  abstract struct ContentToken < BaseToken
    property content, indent
    def initialize(
      @content : String, 
      @lnb : Int32,
      @line : String,
      @indent : Int32)
    end
  end


  enum ListType
    Ol
    Ul
  end

  struct Blank < BaseToken
  end

  struct Indent < ContentToken
  end

  struct ListItem < ContentToken
    property bullet, list_indent, type
    def initialize(
      @content : String, 
      @lnb : Int32,
      @line : String, @bullet : String, @list_indent : Int32, @indent : Int32,
      @type : ListType,
    )
    end
  end

  struct Text < ContentToken
  end
end

require 'bundler'
Bundler.require

def parse_method_and_report(text)
  puts "parse_method_type #{text}"
  puts " => #{RBS::Parser.parse_method_type(text)}"
rescue => e
  puts " => Error: #{e}"
end

# 1: ok
parse_method_and_report("(foo: Integer) -> Integer")

# 2: ok
parse_method_and_report("(foo: Integer[]) -> Integer")

# 3: ok (error)
parse_method_and_report("(foo: Integer[) -> Integer")

# 4: ng (ok)
parse_method_and_report("(foo: Integer]) -> Integer")

=begin

parse_method_type (foo: Integer) -> Integer
 => (foo: Integer) -> Integer
parse_method_type (foo: Integer[]) -> Integer
 => (foo: Integer []) -> Integer
parse_method_type (foo: Integer[) -> Integer
 => Error: a.rbs:1:14...1:15: Syntax error: unexpected token for simple type, token=`)` (pRPAREN)
parse_method_type (foo: Integer]) -> Integer
 => (foo: Integer ]) -> Integer

=end

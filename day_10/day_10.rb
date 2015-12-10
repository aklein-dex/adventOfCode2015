#!/usr/bin/env ruby

puts "--- Day 10: Elves Look, Elves Say---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    MAX_DEPTH = 50
else
    puts "--- Part One ---"
    MAX_DEPTH = 40
end

input = "3113322113"

# Recursive function
def look_and_say(number, depth)
    
    if depth == MAX_DEPTH
        puts "Length is: #{number.length}"
        return
    end
    
    says = ""
    previous = ""
    count = 0
    number.each_char do |c|
        previous = c if previous == ""
    
        if previous != c
            says << count.to_s << previous
            previous = c
            count = 1
        else
            count+=1
        end
    end
    
    says << count.to_s << previous
    
    look_and_say(says, depth + 1)
end

look_and_say(input, 0)

# Note: another solution from the Web.
#       Seems to be slower (have to verify).
#MAX_DEPTH.times do
#  input.gsub!(/(\d)\1*/) { |match| "#{match.length}#{match[0]}" }
#end

#!/usr/bin/env ruby

puts "--- Day 8: Matchsticks ---"

literals = 0
memory   = 0
encoded  = 0

File.open("input.txt", "r") do |f|
    f.each_line do |string|            
        string = string.chomp
        
        literals += string.length
        
        # Part 1
        # Note: could have be done with just: memory+= eval(string).length
        i = 1
        while i < string.length-1
            inc = 1
            if string[i] == '\\'
                if string[i+1] == '\\' or string[i+1] == '"' 
                    inc = 2
                elsif string[i+1] == 'x'
                    inc = 4
                end
            end
            memory+=1
            i += inc
        end

        # Part 2, modify the string
        # Note: could have be done with just: encoded+= string.dump.length
        #newstring = string.gsub(/[\\"]/, '\\' => '\\\\', '"' => '\\"')
        newstring = string.gsub(/([\\"])/, '\\\\\1')
        encoded += "\"#{newstring}\"".length
    end
end

puts "--- Part One ---"
puts "Result is: #{literals} - #{memory} = #{literals - memory}"

puts "--- Part Two ---"
puts "Result is: #{encoded} - #{literals} = #{encoded - literals}"

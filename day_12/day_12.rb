#!/usr/bin/env ruby
require 'json'

puts "--- Day 12: JSAbacusFramework.io ---"

# recursive function
def abacus(line)

    if line.is_a?(Array)
        return line.map { |element| abacus(element) }.inject(:+)
    elsif line.is_a?(Hash)
        if line.values.include?("red")
            return 0
        else
            return abacus(line.values)
        end 
    elsif line.is_a?(String)
        return 0
    elsif line.is_a?(Fixnum)
        return line
    end
end

input = ""
File.open("input.txt", "r") do |f|
    f.each_line do |l|
        input = l.chomp!
    end
end

# Note: another regex found on Internet: /-?\d+/
results = input.scan(/[-\d]+/)
part1 = results.map(&:to_i).inject(:+)
puts "--- Part One ---"
puts "Sum is: #{part1}"


# part 2
total = 0
json = JSON.parse(input)
json.each do |line|
    total += abacus(line)
end

puts "--- Part Two ---"
puts "Sum is: #{total}"

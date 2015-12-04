#!/usr/bin/env ruby

puts "--- Day 2: I Was Told There Would Be No Math ---"

total = 0
ribbon = 0

File.open("wrapping.txt", "r") do |f|
    f.each_line do |line|
        # split, convert to integer and sort
        dimensions = line.split("x").map {|item| item.to_i}.sort
        
        total += (2 * (dimensions[0]*dimensions[1] + dimensions[1]*dimensions[2] + dimensions[2]*dimensions[0])) + ( dimensions[0] * dimensions[1] )
        ribbon+= 2 * (dimensions[0] + dimensions[1]) + (dimensions[0] * dimensions[1] * dimensions[2])
    end
end

puts "--- Part One ---"
puts "Total square feet of wrapping paper is: #{total}."
puts "--- Part Two ---"
puts "Total feet of ribbon is: #{ribbon}."

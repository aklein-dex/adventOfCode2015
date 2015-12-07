#!/usr/bin/env ruby

puts "--- Day 5: Doesn't He Have Intern-Elves For This? ---"

# Part 1
vowels = /(.*[aeiou]){3}/
bad    = /(ab)|(cd)|(pq)|(xy)/
double = /(.)\1/

# Part 2
repeat = /(.).\1/
pair   = /(..).*\1/

count_part1 = 0
count_part2 = 0

File.open("input.txt", "r") do |f|
    f.each_line do |word|
        
        # Part 1
        if word =~ vowels and word !~ bad and word =~ double
            count_part1 += 1
        end

        # Part 2
        if word =~ repeat and word =~ pair
            count_part2 += 1
        end
    end
end

puts "--- Part One ---"
puts "Number of words: #{count_part1}"

puts "--- Part Two ---"
puts "Number of words: #{count_part2}"

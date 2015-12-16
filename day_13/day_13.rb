#!/usr/bin/env ruby

puts "--- Day 13: Knights of the Dinner Table ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    part1 = false
else
    puts "--- Part One ---"
    part1 = true
end

happiness  = 0
people = Hash.new

File.open("input.txt", "r") do |f|
    f.each_line do |l|
        input = l.chomp!
        
        user, action, val, next_to = input.match(/^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+).$/).captures
        value = action == 'lose' ? val.to_i * -1 : val.to_i
        
        unless people.has_key?(user)
            people[user] = Hash.new
        end
        
        people[user][next_to] = value
    end
end

unless part1
    #add myself
    everyone = people.keys
    people["me"] = Hash.new
    
    everyone.each do |user|
        people[user]["me"] = 0
        people["me"][user] = 0
    end
end

# remember this from day 9
perms = people.keys.permutation.to_a

perms.each do |table|
    hap = 0
    for i in 0..table.length-1
        j = i == table.length-1 ? 0 : i+1
        
        hap += people[table[i]][table[j]]
        hap += people[table[j]][table[i]]
    end
    
    if hap > happiness
       happiness = hap
    end
end

puts "Happiness is: #{happiness}"

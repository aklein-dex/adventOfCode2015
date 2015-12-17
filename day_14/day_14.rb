#!/usr/bin/env ruby

puts "--- Day 14: Reindeer Olympics ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    part1 = false
else
    puts "--- Part One ---"
    part1 = true
end

FINISH = 2503

winning = 0
reindeers = Hash.new

def distance(reindeer, time)
    distance = 0
     cycle = reindeer["time"] + reindeer["rest"]
     nb_of_cycle = time / cycle
     
     if (time%cycle) > reindeer["time"]
        # stopped while resting
        nb_of_cycle += 1
    else
        # stopped while he was moving
        distance = reindeer["speed"] * (time%cycle)
    end
    
    distance += nb_of_cycle * reindeer["time"] * reindeer["speed"]
    return distance
end

File.open("input.txt", "r") do |f|
    f.each_line do |line|
        name, speed, time, rest = line.match(/^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/).captures
        reindeers[name] = Hash.new
        reindeers[name]["speed"] = speed.to_i
        reindeers[name]["time"]  = time.to_i
        reindeers[name]["rest"]  = rest.to_i
        reindeers[name]["point"] = 0
    end
end

if part1
    reindeers.each do |name, reindeer|
        traveled = 0
        traveled = distance(reindeer, FINISH)
        
        if traveled > winning
            winning = traveled
        end
    end
    
    puts "Max distance: #{winning}"
else #part 2
    positions = Hash.new
    max = 0
    for i in 1..FINISH
        reindeers.each do |name, reindeer|
            positions[name] = distance(reindeer, i)
        end
        
        # check who is first to give a point
        max = positions.values.max
        positions.each do |k, v|
            reindeers[k]["point"] += 1 if v == max
        end
    end
    
    puts "(part 1: distance: #{max})"
    puts "Max points: #{reindeers.map{ |k,v| v["point"]}.max}"
end


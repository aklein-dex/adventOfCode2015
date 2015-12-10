#!/usr/bin/env ruby

puts "--- Day 9: All in a Single Night ---"

$cities = {}
$min_distance = 9999
$max_distance = 0

# Recursive function
def travel(city, visited, dist)
    
    if visited.include?(city)
        # we can't visit twice the same city
        return
    end
    
    visited.push(city)
    
    if visited.length == $max_city
        # we visited all the cities
        if dist < $min_distance
            $min_distance = dist
        end
        
        if dist > $max_distance
            $max_distance = dist
        end
        
        visited.pop
        return
    end
    
    links = $cities[city]
    
    links.each do |to, km|
        travel(to, visited, dist+km.to_i)
    end
    
    visited.pop
end

File.open("input.txt", "r") do |f|
    f.each_line do |route|
        route.chomp!
        
        from, to, distance = route.match(/^(\w+) to (\w+) = (\d+)$/).captures
        
        unless $cities.has_key?(from)
            $cities[from] = Hash.new
        end
        
        unless $cities.has_key?(to)
            $cities[to] = Hash.new
        end
           
        $cities[from][to] = distance
        $cities[to][from] = distance
        
    end
end

$max_city = $cities.keys.length

visited = Array.new

# Note: I should have use $cities.keys.permutation
# Note 2: but before using ".permutation", you have to be sure
#         that all the cities are connected to each other!
$cities.each do |city, links|
    travel(city, visited, 0)
end


puts "--- Part One ---"
puts "Min distance is: #{$min_distance}"

puts "--- Part Two ---"
puts "Max distance is: #{$max_distance}"

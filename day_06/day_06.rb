#!/usr/bin/env ruby

puts "--- Day 6: Probably a Fire Hazard ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    part1 = false
else
    puts "--- Part One ---"
    part1 = true
end

SIZE = 1000
grid = Array.new(SIZE) { Array.new(SIZE){0} }

count = 0
brightness = 0


File.open("input.txt", "r") do |f|
    f.each_line do |line|
        
        order, x1, y1, x2, y2 = line.match(/^(\w+\s?\w+) (\d+),(\d+) through (\d+),(\d+)$/).captures
        
        for i in x1.to_i..x2.to_i
            for j in y1.to_i..y2.to_i
            
                if part1
                    # in Part1, a light is either ON (1) or OFF (0)
                    if order == "turn on"
                        if grid[i][j] == 0
                            grid[i][j] = 1
                            count+=1
                        end
                        
                    elsif order == "turn off"
                        if grid[i][j] == 1
                            grid[i][j] = 0
                            count-=1
                        end
                    
                    else #toggle
                        if grid[i][j] == 0
                            grid[i][j] = 1
                            count+=1
                        else
                            grid[i][j] = 0
                            count-=1
                        end
                    
                    end
                else 
                    # In part2, a light has a degree of brightness
                    if order == "turn on"
                        grid[i][j] += 1
                        brightness+=1
                        
                    elsif order == "turn off"
                        if grid[i][j] > 0
                            grid[i][j] -= 1
                            brightness-=1
                        end
                    else #toggle
                        grid[i][j] += 2
                        brightness+=2
                    end
                end
            end
        end
        
    end
end

if part1
    puts "Lights on: #{count}"
else
    puts "Brightness is: #{brightness}"
end

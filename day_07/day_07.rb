#!/usr/bin/env ruby

puts "--- Day 7: Some Assembly Required ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    part1 = false
else
    puts "--- Part One ---"
    part1 = true
end

# Recursive function
def applyCommand(key)

    if key =~ /\d+/
        return key.to_i
    end
    
    # return the value if we already know the value of this node
    if $values[key] != -1
        return $values[key]
    end
    
    command = $instructions[key]
    circuit = command.split(" ")
    
    if circuit.length == 1
        val = applyCommand(circuit[0])
        
    elsif circuit.length == 2
        # we have a "not"
        val = ~(applyCommand(circuit[1]))
        
    elsif circuit.length == 3
        if circuit[1] == "OR"
            val = applyCommand(circuit[0]) | applyCommand(circuit[2])
        elsif circuit[1] == "AND"
            val = applyCommand(circuit[0]) & applyCommand(circuit[2])
        elsif circuit[1] == "LSHIFT"
            val = applyCommand(circuit[0]) << circuit[2].to_i
        else #RSHIFT
            val = applyCommand(circuit[0]) >> circuit[2].to_i
        end
    end
    
    $values[key] = val
    return $values[key]
end

$instructions = {}
# "$values" has the same set of keys as "instructions".
# "$values" will store the result to avoid re-calculating the values.
$values = {}

File.open("input.txt", "r") do |f|
    f.each_line do |line|
        command = line.split(" -> ")
        
        if part1
            $instructions[command[1].chomp] = command[0]
            $values[command[1].chomp] = -1
        else
            # Part 2, the result of part 1 is the value for "b"
            if command[1].chomp == "b"
                $instructions[command[1].chomp] = "956"
            else
                $instructions[command[1].chomp] = command[0]
            end
            $values[command[1].chomp] = -1
        end
        
    end
end

value = applyCommand("a")

puts "Value for a: #{value}"

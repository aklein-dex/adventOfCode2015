#!/usr/bin/env ruby
require 'digest'

puts "--- Day 4: The Ideal Stocking Stuffer ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    mask = /^000000/
else
    puts "--- Part One ---"
    mask = /^00000/
end

input = "bgvyzdsv"

found = false
sha256 = Digest::MD5.new

# I'm cheating. Based on the examples, I'm pretty sure the value won't be below 100000
counter = 100000

# just to avoid infinite loop
MAX = 5000000

while(!found)
    
    x = Digest::MD5.hexdigest(input + counter.to_s)
    
    if x =~ mask
        found = true
        puts "MD5 Hash: #{x}."
        puts "Magic number: #{counter}."
    else
        counter+=1
    end
    
    if counter == MAX
        puts "Too long!"
        found = true
    end
end

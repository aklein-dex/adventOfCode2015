#!/usr/bin/env ruby

puts "--- Day 11: Corporate Policy ---"

if ARGV[0] == "2"
    puts "--- Part Two ---"
    input = "cqjxxzaa"
else
    puts "--- Part One ---"
    input = "cqjxjnds"
end

def skipLetter(letter)
    return 106 if letter == 105
    return 109 if letter == 108
    return 112 if letter == 111
    return letter
end

def is_valid_password?(password)
    # these 3 values must be true to have a valid password
    suite = pairA = pairB = false
    
    # avoid overlapping pairs (i.e. aaa)
    overlapp = false
    
    for i in 0..password.length-2
        if i < password.length-3 and password[i]+1 == password[i+1] and password[i]+2 == password[i+2]
            suite = true # suite of 3 letters!
        end

        if overlapp 
            overlapp = false
        else
            if password[i] == password[i+1]
                if !pairA
                    pairA = true
                    overlapp = true
                else
                    pairB = true
                end
            end
        end
    end

    return (suite and pairA and pairB)
end

password = Array.new
input.each_char do |c|
    password.push c.ord
end

while true

    if is_valid_password?(password)
        puts "Password: #{password.map(&:chr).join}"
        break
    else
        inc = true
        i = password.length-1
        password[i] = skipLetter(password[i]+1)

        while inc and i >= 0
            if password[i] == 123
                password[i] = 97
                password[i-1] += 1 if i-1 >=0
            else
                inc = false
                password[i-1] = skipLetter(password[i-1])
            end
            i-=1
        end
    end
end

# Found on the Web:
# s = 'cqjxjnds'
# r = Regexp.union [*?a..?z].each_cons(3).map(&:join)
# s.succ! until s[r] && s !~ /[iol]/ && s.scan(/(.)\1/).size > 1
# p s

# Note: I think this will test all the "cqkai...", but my version skip it.
#       Maybe I should mesure the time it takes and compare the result.

# Note: At first I tried with a recursive function, but I got this error msg:
#       stack level too deep

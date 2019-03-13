#!/usr/bin/ruby

def csv_to_hash_yield
    h_to_yield = Hash.new
    headarr    = Array.new
    File.open("test.csv").each_with_index do | line, line_num |            
        l = line.chomp.split( ';' )
        i = 0
        if (line_num==0)
            headarr = l
        else
            until (i>=l.length)
                h_to_yield[ headarr[i] ] = l[i]
                i+=1
            end
            yield h_to_yield
        end
    end
end

idx=1
csv_to_hash_yield{ | hash |
    hash.each_key{ | key  | 
        puts "index #{idx} - #{key} : #{hash[key]}"
    }
    puts "*"*30
    idx+=1
}



'''
class Greeter
    def initialize(name)
        @name=name
    end
    def say_hi
        puts "Hello #{@name}!"
    end
    def say_bye
        puts "bye #{@name}!"
    end
end

g=Greeter.new("test")
g.say_hi
g.say_bye
g = nil
'''
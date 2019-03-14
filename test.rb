#!/usr/bin/ruby


class CSV2HashMap
    def initialize(file, 
                   separator=";", 
                   hasHeader=false)
        @file = file
        @hasHeader = hasHeader
        @separator = separator
    end
    def gen_hash
        hashtable  = Hash.new
        headarray  = Array.new
        File.open(@file).each_with_index do | line, line_idx |
            l = line.chomp.split( @separator )
            i = 0

            if ((!@hasHeader) && (line_idx==0)) 
                j=0
                until (j>=l.length)
                    headarray.push( j )
                    j+=1
                end

            elsif ((@hasHeader) && (line_idx==0))
                headarray = l
            end

            if ((!@hasHeader) || (line_idx>=1))
                until (i>=l.length)
                    hashtable[ headarray[i] ] = l[i]
                    i+=1
                end
                yield hashtable
            end
        end
    end
end

#exemple
idx=1
csv = CSV2HashMap.new( file='test.csv', 
                       separator=";", 
                       hasHeader=true )

csv.gen_hash { | hash |
    hash.each_key{ | key  | 
        puts "index #{idx} - #{key} : #{hash[key]}"
    }
    puts "*"*30
    idx+=1
}

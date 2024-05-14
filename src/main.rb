def rekursif(graph, i, list)
    if (list == [])
        if graph[i-1][0] == 0 
            return [Float::INFINITY, [1]]
        else
            return [graph[i-1][0], [1]]
        end
    else
        min_dist = Float::INFINITY

        for x in list
            if graph[i-1][x-1] == 0 # Case: node is not accessible
                next
            end

            rek = rekursif(graph, x, list - [x])
            temp = graph[i-1][x-1] + rek[0]
            if (temp < min_dist)
                min_dist = temp
                path = [x] + rek[1]
            end
        end
        return [min_dist, path]
    end
end

def tsp(graph)
    num_cities = graph.size
    result = rekursif(graph, 1, (2..num_cities).to_a)
    puts "Bobot minimum: #{result[0]}"
    puts "Path yang dilalui: #{[1] + result[1]}"
end

# Main Program
## Get filepath
puts "Masukkan nama file testing: "
path = "../test/" + gets.chomp

## Read file
fileobject = File.new(path, mode="r")
lines = fileobject.readlines

## Convert into matrix
graph = Array.new
for x in lines
    graph = graph.push(x.split(' ').map{|a| Integer(a)})
end
fileobject.close()

## Calling function
tsp(graph)

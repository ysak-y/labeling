

###README

####Labeling
4-neighbors labeling method.
When you pass binary matrix to this, return sum of blobs and labeling result.

####Sample	
		$c, $r = gets.split(" ").map(&:to_i)

		maze = $stdin.read.split(?\n).map(&:to_s)
		maze = maze.map{|a| a.split(" ")}
		l_num = 1
		c_arr = [] #Array of "1" cluster indexes.

		maze.each.with_index do |a, idx|
			a.each.with_index do |s, i|
				if s == "1"
					n = (idx * $c) + (i)
					c_arr.push(n)
				end
			end
		end
		

		cluster_table = {}
		labeled_index = []
		while c_arr.length != 0
			cluster_table_tmp = {}
			b_num = c_arr.pop()
			cluster_table_tmp = set_label(b_num, l_num, c_arr)
			cluster_table.merge!(cluster_table_tmp)
			labeled_index = cluster_table_tmp.keys
			c_arr -= labeled_index
			l_num += 1
		end

		cluster_table.each_pair do |k, v|
			r = k / $c
			c = k % $c
			maze[r][c] = v
		end

		puts cluster_table.to_s => {19=>1, 14=>1, 9=>1, 8=>1, 4=>1, 17=>2, 16=>2, 15=>2, 12=>2, 6=>3, 5=>3, 1=>3, 2=>3}
		puts l_num - 1 => 3
			

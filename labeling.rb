

$vec_arr = [[0, 1], [0, -1], [1, 0], [-1, 0]]

def set_label(b_num, l_num, c_arr)
	cluster_table = {}	
	cluster_table[b_num] = l_num
	c_arr.delete(b_num)
	cluster_table_tmp = {}
	labeled_index = []

	$vec_arr.each do |v|
		r = b_num / $c
		c = b_num % $c
		r_mv, c_mv = v
		if r - r_mv >= 0 && c - c_mv >= 0 && c - c_mv <= ($c - 1)
			t_b_num = b_num - c_mv - ($c * r_mv)
			if c_arr.include?(t_b_num)
				cluster_table_tmp = set_label(t_b_num, l_num, c_arr)
				labeled_index = cluster_table_tmp.keys

				cluster_table.merge!(cluster_table_tmp)
				c_arr -= labeled_index
			end
		end
	end
	
	return cluster_table
end

if __FILE__ == $0

	$c, $r = gets.split(" ").map(&:to_i)

	maze = $stdin.read.split(?\n).map(&:to_s)
	maze = maze.map{|a| a.split(" ")}
	l_num = 1
	c_arr = [] #"1"のクラスタのインデックスを格納した配列

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

	puts cluster_table.to_s
	puts l_num - 1
end

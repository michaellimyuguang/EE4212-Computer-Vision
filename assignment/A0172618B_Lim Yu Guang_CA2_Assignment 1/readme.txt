1. main.m is the file to execute the texture synthesis
2. find_matches.m and get_neighborhood_window.n are functions created
to facilitate texture synthesis process
3. set window_size to the desired window size and s_image to the
texture sample you are interested to perform texture synthesis
e.g.
	window_size = 5
	s_image = 'texture1.jpg'
4. an output jpg format file will be saved in the same directory after
performing texture synthesis
e.g.
	synthesised_texture1.jpg
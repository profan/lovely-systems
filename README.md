![Tree](http://i.imgur.com/PZCJuuA.png)

lovely-systems
=================================

Simple implementation of L-Systems in Lua, with examples in LÖVE2D.

Requirements
------------

* Lua >= 5.1 (?)
* LÖVE2D (for the example project)

Running the example project

		love example

Downloading the source
------------
Either with git clone as below or by downloading a zipball of the [latest...](https://github.com/Profan/lovely-systems/archive/master.zip)
		
		git clone https://github.com/Profan/lovely-systems.git

Usage
------------
Example of defining a sierpinski triangle, example also already present in example code.
	
		local lsystem = require "l-system.lua"
		
		initial_state = {state = {'F'}, rules = {['F'] = 'G-F-G', ['G'] = 'F+G+F'} }
		fractal = lsystem.nthstep(initial_state, 2) -- recurses twice
		
		-- fractal.state now holds: F+G+F-G-F-G-F+G+F, in table form.

which in turn can be used to produce: ![Fractal](http://i.imgur.com/iPqtXre.png)

or by increasing the iterations to 8, you can produce: ![BetterFractal](http://i.imgur.com/wR1noEP.png)

another example, a christmas tree! (sort of)
![Gran](http://i.imgur.com/KolwM5G.png)

TODO
------------

 - [ ] ... write tests?

Credits
------------
Credits for the libraries which are used in the example!

* Matthias Richter - [HUMP.](https://github.com/vrld/hump)

License
------------
See attached LICENSE file.

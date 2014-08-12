# *element      :Type: html element  :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *from_frame   :Type: int           :Example: 1, 4 
# *total_frames :Type: int           :Example: 1, 4 
# *tbf          :Type: html element  :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# tbf = time bettwen frames 
# restart       :Type: boolean       :Example: true, false
# if we need to restrt the animation every time is called
# loop          :Type: boolean       :Example: true, false 
# callback      :Type: function      :Example: -> console.log, App.setBack

# can be used on sprite or image sequence
# on css 
# @for $i from 1 through 9
# 	#intro_img1.frame_#{$i}							
# 		background-image: url("../secuencia_final/Seccion01000#{$i}.png")
# on coffee
# App.spritefy.init({element: App.by_id("intro_img1"),from_frame: 1 ,total_frames: 24 ,tbf: 44,restart: true,loop: true})

# you can stop on the animation like this
# animation = App.spritefy.init({element: App.by_id("intro_img1"),from_frame: 1 ,total_frames: 24 ,tbf: 44,restart: true,loop: true})
# animation.stop()

((root) ->
	root.spritefy=
	{
		interval_obj : null
		settings: null
		reverse: false
		init: (_settings) ->
			# if wee need to reset to frame 1 every time when user open a section
			@settings = _settings
			if @.settings.restart is not undefined        
				 @.restart()       
			
			if @.settings.current_frame > @.settings.total_frames				
				@reverse= true
			else
				@reverse= false
				
			@.settings.current_frame = @.settings.from_frame
			@.interval_obj = setInterval( ->
					root.spritefy.go()
				@.settings.tbf)
			return this
		go : ->
						
			# delete prev class the add the new one 
			prev_frame = @.settings.current_frame
			

			if !@reverse
				@.settings.current_frame++	
			else
				@.settings.current_frame--			
			if ( @.settings.current_frame > @.settings.total_frames and !@reverse ) or  ( @.settings.current_frame < @.settings.total_frames and @reverse )
				# if we want to loop or trigger the callback at the end of the animation				
				if @.settings.loop is not undefined
					@.settings.restart = true
					@.stop()
					@.init(@.settings)          
				else
					
					obj = @.interval_obj
					@.stop()

					if typeof @.settings.callback is "function"
						@.settings.callback.call()
			else 
				console.log  @.settings.current_frame     
				root.replace_class(@.settings.element,"frame_"+prev_frame,"frame_"+@.settings.current_frame)
			

				
		stop: ->
			clearInterval(@.interval_obj)
		restart: ->
			i = 0
			class_array = @.settings.element.className.split(" ")
			root.remove_all_class(@.settings.element)        
			while i <= class_array.length-1
									
				if class_array[i].indexOf("frame_") is -1            
					root.add_class(@.settings.element,class_array[i])					
				
				i++
			@.settings.current_frame = @.settings.from_frame
			root.add_class(@.settings.element,"frame_"+@.settings.from_frame)


	}
	# Anonymous function empty return
	return
	)(App)
# *element    :Type: html element  :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *_animation :Type: object        :Example: {"height":"50px","width":"50px" }
# *_settings  :Type: object        :Example: {duration: 500, easing:"easeOutQuad",callback: -> console.log }
# *duration   :Type: int           :Example: 500
#  easing     :Type: string        :Example: "easeOutQuart", "easeInCubic"
#  callback   :Type: function      :Example: -> console.log, App.setBack

# * required
# normal use
# App.question3_animation_left.stop()
# App.question3_animation_left = new App.animate(App.question3_left_hide,{left:"-100%"},{duration:350,easing:"easeOutQuart"})
#	App.question3_animation_text.stop()

# works with transform , but we need to initialize the value first 
# @.css(App.$bg,{transform:"translateZ(0px)"})
# new App.animate(App.$bg,{translateZ:"-100px"},{duration:3500,easing:"easeOutQuart",is_transform:true,})

# works on filter 
# new App.animate(App.question3_text,{blur:"0px"},{duration:350,easing:"easeOutQuart",is_filter:true})
((root) ->

	root.animate = (element, _animation,_settings) ->
		@busy = false
		@interval_obj = null
		@current_frame=0
		@array_animation= new Array()
		@array_transform= new Array()
		@array_initial = null
		@cadena_initial = null
		@frate = 50
		@init= ->
			self = @ 
			
			if @busy
				return false    
			@busy = true
			@animations= new Array()
			frames = _settings.duration / @frate    

			for key, value of _animation                
				obj= new Object()
								
				obj.to_value= value
				obj.property_to_animate= key		
				
				if value.toString().indexOf("%") != -1      
					obj.initial_value = parseInt(element.style[key])           
					
					if isNaN(obj.initial_value)
						root.css(element,{"display":"none"})
						obj.initial_value= document.defaultView.getComputedStyle(element,null).getPropertyValue(key)
						root.css(element,{"display":"block"})
													
					obj.measure= "percent"
					
					
				else if value.toString().indexOf("px") != -1
					
					obj.initial_value = getComputedStyle(element)[key]
					obj.measure= "pixels"					
				
				else if value.toString().indexOf("deg") != -1
					
					obj.initial_value = getComputedStyle(element)[key]
					obj.measure= "deg"

				else 
					obj.initial_value = getComputedStyle(element)[key]
					obj.measure= "int"
					
				
				if _settings.is_filter != undefined        
					obj.initial_value= document.defaultView.getComputedStyle(element,null).getPropertyValue("filter").replace(key,"").replace("(","").replace(")","")
					if obj.initial_value is "none"
						obj.initial_value= 0

				if _settings.is_transform != undefined
					css= element.style["transform"]
					@cadena_initial= css
					
					
					@array_initial= css.split(" ")
					
					found = false
					cont= 0
					while !found or cont < @array_initial.length
						if @array_initial[cont].indexOf(key)!= -1
							found = true
							obj.key = key
							
							obj.initial_value= @array_initial[cont].replace(key,"").replace("(","").replace(")","").replace("deg","").replace("px","")
							# console.log obj.initial_value

						cont++ 
					# dejamos a un lado las matrices me dedico a los string es más fácil :D
					# st= document.defaultView.getComputedStyle(element,null)
					# obj.initial_value= st.getPropertyValue("-webkit-transform") ||
					# st.getPropertyValue("-moz-transform") ||
					# st.getPropertyValue("-ms-transform") ||
					# st.getPropertyValue("-o-transform") ||
					# st.getPropertyValue("transform") ||
				 # "fail..."
					# obj.initial_value = obj.initial_value.split('(')[1]
					# obj.initial_value = obj.initial_value.split(')')[0]
					# obj.initial_value = obj.initial_value.split(',')
					# @array_transform= obj.initial_value
					
					# scaleX = obj.initial_value[0]
					# skewX = obj.initial_value[1]
					# skewY = obj.initial_value[2]
					# scaleY = obj.initial_value[3]
					# translateX = obj.initial_value[4]
					# translateY = obj.initial_value[5]
					
					# console.log "scaleX="+scaleX
					# console.log "skewX="+skewX
					# console.log "skewY="+skewY
					# console.log "scaleY="+scaleY
					# console.log "translateX="+translateX
					# console.log "translateY="+translateY
					

					# scale = Math.sqrt(scaleX*scaleX + skewX*skewX);
					# sin = skewX/scale

					# radians = Math.atan2(skewX, scaleX)
					# if radians < 0
					# 	radians += (2 * Math.PI)
					# # angle = Math.round(Math.atan2(skewX, scaleX) * (180/Math.PI))
					# angle = Math.round( radians * (180/Math.PI))
					# console.log "angle="+angle
					# if obj.initial_value is "none"
					# 	obj.initial_value= 0

					# console.log @array_transform




				@array_animation.push obj        

			@current_frame = 1     
			if _settings.delay != undefined
				setTimeout(
					->
						self.interval_obj = setInterval( ->
							self.animate_tick(element,frames,_settings)
						,@frate)

					,_settings.delay)
			else
				self.interval_obj = setInterval( ->
					self.animate_tick(element,frames,_settings)
				,@frate)
			

		@animate_tick= (element, _frames, _settings) ->
			# callback at the end of the animation if needed      
			if @current_frame > _frames        
				@.stop()
				if typeof _settings.callback is "function"           
					@busy= false
					_settings.callback.call()
				return false
			
			if _settings.is_transform != undefined
				# console.log "tick"
				cadena = @cadena_initial
				for $i in [0..@array_animation.length-1] by 1
					found = false
					cont = 0
					
					while !found and cont < @array_initial.length
						
						obj = @array_animation[$i]
						
						if @array_initial[cont].indexOf(obj.key) != -1
							found = true
							

							
							initial = parseFloat(obj.initial_value)
							final = parseFloat(obj.to_value)
							
							if _settings.easing is undefined
								chunk= ( final - initial ) / _frames
								current_value=  initial  + (chunk  * @current_frame)
							else
								fn = window[_settings.easing]
								if typeof fn is "function"
									current_value= fn.apply(this,new Array(@current_frame, initial, (final - initial), _frames))
							# if the animation is on % px or int
							if obj.measure == "percent"
								current_value= current_value + "%"
							else if obj.measure is "pixels"
								current_value= current_value + "px"
							else if obj.measure is "deg"
								current_value= current_value + "deg"
							# console.log "current->"+current_value
							
							cadena = cadena.replace(@array_initial[cont],obj.key+"("+current_value+")")
							
							
						cont++
				# console.log cadena
				root.css(element,{"transform": cadena})
			else
				for $i in [0..@array_animation.length-1] by 1

					obj = @array_animation[$i]  
					initial = parseInt(obj.initial_value)
					final = parseInt(obj.to_value)
					
					# when easing is defined we need the "js/libs/easing.js from penner-kirupa"
					if _settings.easing is undefined
						chunk= ( final - initial ) / _frames
						current_value=  (initial  + (chunk  * @current_frame)).toFixed(2)
					else
						fn = window[_settings.easing]
						if typeof fn is "function"
							current_value= (fn.apply(this,new Array(@current_frame, initial, (final - initial), _frames))).toFixed(2)
					# if the animation is on % px or int
					if obj.measure == "percent"
						current_value= current_value + "%"
					else if obj.measure is "pixels"
						current_value= current_value + "px"           
									
					if _settings.is_filter != undefined
						# current_value= parseInt(current_value)
						cadena = obj.property_to_animate+"("+current_value+")"
						root.css(element,{"-webkit-filter": cadena})
					else
						
						element.style[obj.property_to_animate] = current_value
						
											
					
					
				
			@current_frame++

								
		@stop= ->
			
			clearInterval(@.interval_obj)
			@busy = false
			return false
		
		if _settings.autostart is undefined
			@init()

		return
	
	
	
)(App)
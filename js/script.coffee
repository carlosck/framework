
App =
	# init your global vars (best practice)
	init: ->		
		@.$stage = null				
		@.$header = null
		@.$menu = null
		@.$loader = null
		@.$gallery = null
		@.$popup = null

		@.section = 1
		@.scroll_busy = true
		@.current_section = 1
		
		@.current_animation= null
						
		@.bind()	
		
	# bind your elements to vars for a better performance
	bind : ->				
		@.$stage = @.by_id("stage")
		# todo fix the no value at initial value, when animation is on percent
		@.$stage.style.top = "0px"

		@.$header = @.by_id("header")		
		 
		@.$menu = @.by_id("menu")	
		@.$loader = @.by_id("loading")	
		@.$gallery = @.by_id("gallery")	
		@.$popup = @.by_id("gallery_popup")
		@sprite_container = @by_id("intro_img1")

		# todo use request animation frame instead of settimeout //ie10+
		# requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame
		@.start()
				
	start: ->
		@.set_mouse_scroll(@.mouse_scroll)
		@.set_on(document,"keyup",@.key_up)		

		elements= @.each(@.$menu,"a", (element, i)->			
			App.set_on(element,"click",App.menu_click)
		)

		elements= @.each(@.$gallery,".item_gallery", (element, i)->						
			App.set_on(element,"click",App.gallery_click)
		)

		@.set_on(App.find(App.$popup,"#popup_close"),"click",->
			App.popup_close()

			)

		left = @.find(@.$popup,"#popup_left_container")
		right = @.find(@.$popup,"#popup_right_container")
		menu_elements = @.find_all(@.$popup,".popup_button")
		slider = @.find(@.$popup,"#popup_slider")		

		@.gallery.init({left:left,right:right,menu:menu_elements,slider:slider,current:4,easing:"easeOutQuart"})

		@.preload()
		
	preload: ->
		# set the paths for preload
		array_img = new Array()
		for i in [1..30] by 1
			array_img.push("img/secuencia/secuencia_#{i}.png")
			
		self = @

		#initializing the preloading plugin 
		@.preload_img.init(
			array_img 			
			->
				self.loading_cerrar()
			(obj) ->				
				self.add_preload(obj)								
			)	

	add_preload : (obj) ->
		@.find(App.$loader,"#loading_container").innerHTML= obj.current+" de "+obj.total		
		
	loading_cerrar: ->
		@.animate.to(App.$loader,{"height":"0px"},{duration: 500, easing:"easeOutQuad",callback: ->
			App.scroll_busy = false
		 }) 

	mouse_scroll :(event) ->						
		
		evt = window.event || event
		delta =  evt.detail * (-120) or evt.wheelDelta
		
		if delta < 0
			if App.section+1 < 8
				App.change_page(App.section + 1)
		else			
			if App.section-1 > 0
				App.change_page(App.section - 1)	
		

	key_up: (event) ->		
		
		e = window.event || event
		
		delta= 0

		switch event.which
			when 38  
				delta = 1 				
			when 40  
				delta = -1 				

		if delta < 0
			if App.section+1 < 8
				App.change_page(App.section + 1)
		else			
			if App.section-1 > 0
				App.change_page(App.section - 1)

	menu_click: (e) ->
		
		e = event || window.event
		e.preventDefault()
		
		page = e.target.id.replace("menu_item","")

		App.change_page(parseInt(page))
		return

	gallery_click: (e) ->
		
		e = event || window.event
		e.preventDefault()
		
		page = e.target.id.replace("item_gallery_","")

		App.popup_open(parseInt(page))
		return

	change_page: (_page)->
		
		if @.section is _page or @.scroll_busy
			return false				 

		@.scroll_busy = true		
		if @.section < _page
			top_to_bottom = true		
		else
			top_to_bottom = false
		
		@.animate.to(@.find(@.$menu,"#menu_item"+_page),{"height":"50px","width":"50px"},{duration: 500, easing:"easeOutQuad"})
		@.animate.to(@.find(@.$menu,"#menu_item"+@.section),{"height":"25px","width":"25px"},{duration: 500, easing:"easeOutQuad"})
		
		

		if _page  is 2 			
			@.animate.to(@.$header,{"height":"50px"},{duration: 500, easing:"easeOutQuad"})			
			@.animate.to(@.find(@.$header,"#logo"),{"marginTop":"0px"},{duration: 500, easing:"easeOutQuad"})
			@.animate.to(@.find(@.$header,"#list"),{"marginTop":"0px"},{duration: 500, easing:"easeOutQuad"})

		if _page  is 1 			
			@.animate.to(@.$header,{"height":"100px"},{duration: 500, easing:"easeOutQuad"})	
			@.animate.to(@.find(@.$header,"#logo"),{"marginTop":"25px"},{duration: 500, easing:"easeOutQuad"})
			@.animate.to(@.find(@.$header,"#list"),{"marginTop":"25px"},{duration: 500, easing:"easeOutQuad"})
			
		
		frame_from = 0
		frame_to = 0				
		switch _page
			when 2 
				App.spritefy.init({element: @sprite_container,from_frame: 1 ,total_frames: 10 ,tbf:100 ,restart: true})		
			when 3 
				App.spritefy.init({element: @sprite_container,from_frame: 11 ,total_frames: 20 ,tbf:100,restart: true})		
			when 4 
				App.spritefy.init({element: @sprite_container,from_frame: 21 ,total_frames: 30 ,tbf:100,restart: true})

		
		@.section = _page		
		
		@.animate.to(@.$stage,{"top": ((_page-1) * -100)+"%"}, {duration: 500, easing:"easeOutQuad",callback: ->
			
			if App.current_animation != null					
					App.current_animation.stop()
					
			App.scroll_busy = false
						
			})	

	popup_open: (_section) ->
		
		@.scroll_busy= true
		@.css(App.$popup,{"opacity":0,"display":"block"})		
		@.animate.to(@.$popup,{"opacity":1},{duration: 100})
	
	popup_close: () ->
								
		@.animate.to(@.$popup,{"opacity":0},{duration: 100,callback: ->
			App.css(App.$popup,{"opacity":0,"display":"none"})
			App.scroll_busy= true

		})



document.addEventListener 'DOMContentLoaded', ->	
	App.init()
	

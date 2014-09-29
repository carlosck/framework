# *left    :Type: html element           :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *right   :Type: html element           :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *menu    :Type: array of html element  :Example: @.find_all(@.$popup,".popup_button") 
# *slider  :Type: html element           :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *current :Type: int                    :Example: 1, 4 
# easing  :Type: string                  :Example: "easeOutQuart", "easeInCubic" 

#  * required

# left = @.find(@.$popup,"#popup_left_container")
# right = @.find(@.$popup,"#popup_right_container")
# menu_elements = @.find_all(@.$popup,".popup_button")
# slider = @.find(@.$popup,"#popup_slider")		
# App.gallery_beetle = new App.simple_gallery({left:left_beetle, right:right_beetle, menu:menu_elements_beetle, slider:slider_beetle,current:1,easing:"easeOutQuart"})
# App.gallery_beetle.init()
# you can make calls to the function calling them as follow
# App.gallery_beetle.next()

((root) ->
	root.simple_gallery= (_settings) ->
		@$left= null
		@$right= null
		@$menu= null
		@$slider= null
		@easing = null
		
		current= 0
		busy = false
		@init= ->
			@$left = _settings.left
			@$right = _settings.right
			@$menu = _settings.menu
			@$slider = _settings.slider
			@current = _settings.current-1
			@easing = null
			root.add_class(@$left,"active")
			root.add_class(@$right,"active")

			if _settings.easing != undefined
				@.easing= _settings.easing
			
			root.add_class(@$menu[@current],"active")
			
			root.css(@$slider,{"left":(@current*-100)+"%"})
			@page(@current)
			
			self = @

			root.set_on(@$left,"click",(event)->
					root.prevent_default(event)
					self.prev()
				)

			root.set_on(@$right,"click",(event)->
					root.prevent_default(event)
					self.next()
				)

			for i in [0..@$menu.length-1] 
				_i = i
				
				root.set_on(@$menu[i],"click",(event) ->
					root.prevent_default(event)

					_page= root.get_target(event).getAttribute("page")
					
					self.page(_page)
				)

		@page= (_page) ->
			if @busy
				return false 
			_page = parseInt(_page)
			
			@busy= true
			@current = _page
			

			# if _page == 0
			# 	root.remove_class(@$left,"active")
			# else
			# 	if !root.has_class(@$left,"active") 
			# 		root.add_class(@$left,"active")


			# if _page == @$menu.length-1
			# 	root.remove_class(@$right,"active")
			# else
			# 	if !root.has_class(@$right,"active") 
			# 		root.add_class(@$right,"active")

			self = @
			root.remove_class(App.find(self.$menu[0].parentNode,".popup_button.active"),"active")
			root.add_class(@$menu[_page],"active")
			
			@current= _page
			if @easing != null			
				obj= new root.animate(@$slider,{"left":(@current * -100) + "%"},{duration: 500,easing:@easing, callback: ->
					self.busy= false
					})
				obj.init()
			else
				obj= new root.animate(@$slider,{"left":(@current * -100) + "%"},{duration: 500,callback: ->
					self.busy= false
					})
				obj.init()

		@prev= ->			
			if @current == 0
				@page(@$menu.length-1)
			else
				@page(@current-1)

		@next= ->			
			if @current == @$menu.length-1
				@page(0)
			else
				@page(@current+1)

		return

	 
)(App)
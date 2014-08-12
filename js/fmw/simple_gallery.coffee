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
# @.gallery.init({left:left,right:right,menu:menu_elements,slider:slider,current:4,easing:"easeOutQuart"})

((root) ->
	root.gallery = {
		$left: null
		$right: null
		$menu: null
		$slider: null
		current: 0
		busy : false
		init: (_settings)->
			@$left = _settings.left
			@$right = _settings.right
			@$menu = _settings.menu
			@$slider = _settings.slider
			@current = _settings.current
			@easing = null
			root.add_class(@$left,"active")
			root.add_class(@$right,"active")

			if _settings.easing != undefined
				@.easing= _settings.easing
			
			root.add_class(@$menu[@current],"active")
			
			root.css(@$slider,{"left":(@current*-100)+"%"})
			@page(@current)
			
			self = @

			root.set_on(@$left,"click",->
					self.prev()
				)

			root.set_on(@$right,"click",->
					self.next()
				)

			for i in [0..@$menu.length-1] 
				_i = i
				
				root.set_on(@$menu[i],"click",(event) ->
					event.preventDefault()
					_page= event.target.getAttribute("page")
					
					self.page(_page)
				)

			
			
		page: (_page) ->
			if @busy
				return false 
			_page = parseInt(_page)
			
			@busy= true
			@current = _page
			

			if _page == 0
				root.remove_class(@$left,"active")
			else
				if !root.has_class(@$left,"active") 
					root.add_class(@$left,"active")


			if _page == @$menu.length-1
				root.remove_class(@$right,"active")
			else
				if !root.has_class(@$right,"active") 
					root.add_class(@$right,"active")

			self = @
			root.remove_class(App.find(self.$menu[0].parentNode,".popup_button.active"),"active")
			root.add_class(@$menu[_page],"active")
			
			@current= _page
			if @easing != null			
				root.animate.to(@$slider,{"left":(@current * -100) + "%"},{duration: 500,easing:@easing, callback: ->
					self.busy= false
					})
			else
				root.animate.to(@$slider,{"left":(@current * -100) + "%"},{duration: 500,callback: ->
					self.busy= false
					})

		prev: ->			
			if @current == 0
				return false
			
			@page(@current-1)
		next: ->			
			if @current == @$menu.length-1
				return false
			
			@page(@current+1)

	}
	return 
)(App)
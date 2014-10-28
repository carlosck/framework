((root) ->
	c = root
		
		#     ,o888888o.    8 8888                  .8.            d888888o.      d888888o.
		#    8888     `88.  8 8888                 .888.         .`8888:' `88.  .`8888:' `88.
		# ,8 8888       `8. 8 8888                :88888.        8.`8888.   Y8  8.`8888.   Y8
		# 88 8888           8 8888               . `88888.       `8.`8888.      `8.`8888.
		# 88 8888           8 8888              .8. `88888.       `8.`8888.      `8.`8888.
		# 88 8888           8 8888             .8`8. `88888.       `8.`8888.      `8.`8888.
		# 88 8888           8 8888            .8' `8. `88888.       `8.`8888.      `8.`8888.
		# `8 8888       .8' 8 8888           .8'   `8. `88888.  8b   `8.`8888. 8b   `8.`8888.
		#    8888     ,88'  8 8888          .888888888. `88888. `8b.  ;8.`8888 `8b.  ;8.`8888
		#     `8888888P'    8 888888888888 .8'       `8. `88888. `Y8888P ,88P'  `Y8888P ,88P'
		
		# _element   :Type: html element :Example: App.$menu , App.byId("menu") , document.getElementByid("menu")
		# _class     :Type: string       :Example: "frame_1" , "item_"+i
		# _class_new :Type: string       :Example: "frame_1" , "item_"+i
		# return null
		
		 								


	c.remove_class= (_element,_class,_callback)  ->    
		array= _element.className.split(" ")
		_element.className = _element.className.replace(" "+_class,"") 
		found = false
		count = 0
		while !found and count < array.length
			if array[count] is _class
				array[count]= ''
				found = true
			else
				count++
		_element.className= array.join(" ")
		if typeof _callback is "function" 
    	_callback.call()
	c.remove_all_class= (_element)  ->    
		_element.className = ""
	c.remove_all_class_startwith= (_element,_startwith)  ->    
		i = 0
		class_array = _element.className.split(" ")
		_element.className = ""       
		while i <= class_array.length-1
								
			if class_array[i].indexOf(_startwith) is -1            
				root.add_class(_element,class_array[i])					
			
			i++ 	
	c.add_class= (_element,_class) ->    
		_element.className = _element.className + " "+_class
	c.has_class= (_element,_class) -> 
		
		if _element.className.indexOf(_class) != -1
			return true
		else
			return false
		
	c.replace_class= (_element,_class,_class_new)  ->    
		_element.className = _element.className.replace(" "+_class," "+_class_new)

				
		#    d888888o.   8 8888888888   8 8888         8 8888888888       ,o888888o. 8888888 8888888888 ,o888888o.     8 888888888o.     d888888o.
		#  .`8888:' `88. 8 8888         8 8888         8 8888            8888     `88.     8 8888    . 8888     `88.   8 8888    `88.  .`8888:' `88.
		#  8.`8888.   Y8 8 8888         8 8888         8 8888         ,8 8888       `8.    8 8888   ,8 8888       `8b  8 8888     `88  8.`8888.   Y8
		#  `8.`8888.     8 8888         8 8888         8 8888         88 8888              8 8888   88 8888        `8b 8 8888     ,88  `8.`8888.
		#   `8.`8888.    8 888888888888 8 8888         8 888888888888 88 8888              8 8888   88 8888         88 8 8888.   ,88'   `8.`8888.
		#    `8.`8888.   8 8888         8 8888         8 8888         88 8888              8 8888   88 8888         88 8 888888888P'     `8.`8888.
		#     `8.`8888.  8 8888         8 8888         8 8888         88 8888              8 8888   88 8888        ,8P 8 8888`8b          `8.`8888.
		# 8b   `8.`8888. 8 8888         8 8888         8 8888         `8 8888       .8'    8 8888   `8 8888       ,8P  8 8888 `8b.    8b   `8.`8888.
		# `8b.  ;8.`8888 8 8888         8 8888         8 8888            8888     ,88'     8 8888    ` 8888     ,88'   8 8888   `8b.  `8b.  ;8.`8888
		#  `Y8888P ,88P' 8 888888888888 8 888888888888 8 888888888888     `8888888P'       8 8888       `8888888P'     8 8888     `88. `Y8888P ,88P'
		
		# _item   :Type: string       :Example: "frame_1" , "item_"+i
		# _parent :Type: html element :Example: App.$menu , App.byId("menu") , document.getElementByid("menu")
		# _callback :Type: function :Example:  -> console.log , App.key_up}
		# return  :Type: html element

		#each 
		# @.each(App.$menu,".answer_left", (element, i)->					
		# 	App.set_on(element,"mouseenter",App.open_left)
		# )
	c.selector_all	= (_item)->
		return document.querySelectorAll( _item )
	c.by_id= (_item)->
		return document.getElementById( _item ) 
	c.by_class= (_item)->
		return document.getElementByClass( _item )
	c.find = (_parent, _item) ->
		return _parent.querySelectorAll(_item)[0]
	c.find_all = (_parent, _item) ->
		return _parent.querySelectorAll(_item)
	c.each = (_parent, _item,_callback) ->
		elements = _parent.querySelectorAll(_item)
		Array.prototype.forEach.call(elements,_callback)

		

		# 8 8888888888 `8.`888b           ,8' 8 8888888888   b.             8 8888888 8888888888 d888888o.
		# 8 8888        `8.`888b         ,8'  8 8888         888o.          8       8 8888     .`8888:' `88.
		# 8 8888         `8.`888b       ,8'   8 8888         Y88888o.       8       8 8888     8.`8888.   Y8
		# 8 8888          `8.`888b     ,8'    8 8888         .`Y888888o.    8       8 8888     `8.`8888.
		# 8 888888888888   `8.`888b   ,8'     8 888888888888 8o. `Y888888o. 8       8 8888      `8.`8888.
		# 8 8888            `8.`888b ,8'      8 8888         8`Y8o. `Y88888o8       8 8888       `8.`8888.
		# 8 8888             `8.`888b8'       8 8888         8   `Y8o. `Y8888       8 8888        `8.`8888.
		# 8 8888              `8.`888'        8 8888         8      `Y8o. `Y8       8 8888    8b   `8.`8888.
		# 8 8888               `8.`8'         8 8888         8         `Y8o.`       8 8888    `8b.  ;8.`8888
		# 8 888888888888        `8.`          8 888888888888 8            `Yo       8 8888     `Y8888P ,88P'

		# _callback :Type: function :Example:  -> console.log , App.mouse_scroll}
		# return    :Type: event    :Example: evt = window.event || e
	c.set_mouse_scroll = (_callback)->
		mousewheelevt = null
		if (/Firefox/i.test(navigator.userAgent))
			mousewheelevt =   "DOMMouseScroll"
		else
			mousewheelevt =   "mousewheel"
						
		@.set_on(document,mousewheelevt,_callback)
		
		# _element :Type: html element :Example: App.$menu , App.byId("menu") , document.getElementByid("menu")
		# _evType   :Type: string :Example:  "keyup" , "mouseenter"}
		# _callback :Type: function :Example:  -> console.log , App.key_up}
		# return    :Type: event    :Example: evt = window.event || e

	c.set_on =(_element,_evType,_callback) ->    
				
		if _element.attachEvent     
			_element.attachEvent("on"+_evType,_callback)
		else if _element.addEventListener     
			_element.addEventListener(_evType, _callback, false)
		else      
			_element['on'+_evType]= _callback
	
	# _element  :Type: html element :Example: App.$menu , App.byId("menu") , document.getElementByid("menu")
	# _property :Type: string :Example:  "opacity" , "display"}
	# _value 		:Type: string :Example:  "1" , "block"}
	# return    null
	c.css = (_element,_settings) ->		
		for key, value of _settings			
			_element.style[key] = value

	# _element  :Type: html element :Example: App.$menu , App.byId("menu") , document.getElementByid("menu")	
	# return    int
	# example @.height(@$full_container)
	c.height = (_element) ->		
		return parseInt(getComputedStyle(_element).height)
	c.width = (_element) ->		
		return parseInt(getComputedStyle(_element).width)

	# 8 8888      88 8888888 8888888888  8 8888 8 8888           d888888o.
	# 8 8888      88       8 8888        8 8888 8 8888         .`8888:' `88.
	# 8 8888      88       8 8888        8 8888 8 8888         8.`8888.   Y8
	# 8 8888      88       8 8888        8 8888 8 8888         `8.`8888.
	# 8 8888      88       8 8888        8 8888 8 8888          `8.`8888.
	# 8 8888      88       8 8888        8 8888 8 8888           `8.`8888.
	# 8 8888      88       8 8888        8 8888 8 8888            `8.`8888.
	# ` 8888     ,8P       8 8888        8 8888 8 8888        8b   `8.`8888.
	#   8888   ,d8P        8 8888        8 8888 8 8888        `8b.  ;8.`8888
	#    `Y88888P'         8 8888        8 8888 8 888888888888 `Y8888P ,88P'

	# return    boolean
	# example if @is_internet_explorer()

	c.is_internet_explorer = ->
		ua = window.navigator.userAgent		
		msie = ua.indexOf("MSIE ")		

		if msie > -1 or navigator.userAgent.match(/Trident.*rv\:11\./)
			return true
		else
			return false
	c.is_firefox = ->
		ua = window.navigator.userAgent		
		msff = ua.indexOf("Firefox")		

		if msff > -1 
			return true
		else
			return false
	c.get_internet_explorer_version = ->
		ua = window.navigator.userAgent
		msie = ua.indexOf("MSIE ")
		return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)))
	c.is_mobile = ->
		@mobileWeb = /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/i.test(navigator.userAgent)
		return @mobileWeb
	# event  : js event
	# return    null
	# example @set_on(@.popup_btn,"click", (event)->
	#  App.prevent_default(event)

	c.prevent_default	= (_event) ->
		if @is_internet_explorer()						
			_event.returnValue = false
		else
			_event.preventDefault()
	# event  : js event
	# return : Type: html element 
	# example: _event= App.get_target(e)
	# page = _event.getAttribute("page")	
	

	c.get_target = (_event) ->
		e= _event.target || _event.srcElement		
		return e
		


	
)(App)
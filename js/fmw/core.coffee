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

	c.remove_class= (_element,_class)  ->    
		_element.className = _element.className.replace(" "+_class,"")    
	c.remove_all_class= (_element)  ->    
		_element.className = ""
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
	
)(App)
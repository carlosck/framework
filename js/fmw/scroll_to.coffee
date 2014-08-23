# *element    :Type: html element  :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *_animation :Type: object        :Example: {"height":"50px","width":"50px" }
# *_settings  :Type: object        :Example: {duration: 500, easing:"easeOutQuad",callback: -> console.log }
# *duration   :Type: int           :Example: 500
#  easing     :Type: string        :Example: "easeOutQuart", "easeInCubic"
#  callback   :Type: function      :Example: -> console.log, App.setBack

# * required

# @.gallery.init({left:left,right:right,menu:menu_elements,slider:slider,current:4})

((root) ->

  root.scroll_to = {
  
  go:(element, _animation,_settings) ->
    @.isie = root.is_internet_explorer()
    console.log "--Element --"
    console.log document.documentElement    
    for key, value of _animation
      
      frames = _settings.duration / 10    
      
      if value.toString().indexOf("%") != -1      
        initial_value = parseInt(element.style[key])         
        @.animate_tick(element,{initial:initial_value,is_percent: true,frames: frames},{property: key,to: value},_settings,1)
      else if value.toString().indexOf("px") != -1
        if @isie 
          initial_value= document.documentElement.scrollTop
        else
          initial_value = element.scrollTop                         
        @.animate_tick(element,{initial:initial_value,is_px: true,frames: frames},{property: key,to: value},_settings,1)
      else
        if @isie 
          initial_value= document.documentElement.scrollTop
        else
          initial_value = element.scrollTop  
                 
        @.animate_tick(element,{initial:initial_value,is_int: true,frames: frames},{property: key,to: value},_settings,1)

    this

  animate_tick: (element, _from, _animation,_settings,current_frame) ->
    # callback at the end of the animation if needed
    self = this
    if current_frame > _from.frames     
      if typeof _settings.callback is "function" 
        _settings.callback.call()
      return false

    initial = parseInt(_from.initial)
    final = parseInt(_animation.to)
    
    # when easing is defined we need the "js/libs/easing.js from penner-kirupa"
    if _settings.easing is undefined
      chunk= ( final - initial ) / _from.frames
      current_value=  initial  + (chunk  * current_frame)
    else
      fn = window[_settings.easing]
      if typeof fn is "function"
        current_value= fn.apply(this,new Array(current_frame, initial, (final - initial), _from.frames))
    # if the animation is on % px or int
    if _from.is_percent != undefined
      current_value= current_value + "%"
    else if _from.is_px != undefined
      current_value= current_value + "px"           
    
    if @isie 
      document.documentElement.scrollTop= current_value
    else
      element.scrollTop= current_value
    
    current_frame++
    
    setTimeout( ->
      self.animate_tick(element, _from, _animation,_settings,current_frame)
    ,10)
  }
  # Anonymous function empty return
  return
)(App)
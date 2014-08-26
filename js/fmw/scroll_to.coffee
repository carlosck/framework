# *_settings  :Type: object        :Example: {duration: 500, easing:"easeOutQuad",callback: -> console.log }
# *duration   :Type: int           :Example: 500
#  easing     :Type: string        :Example: "easeOutQuart", "easeInCubic"
#  callback   :Type: function      :Example: -> console.log, App.setBack

# * required

# @.scroll_to.go({"top":250}, {duration: 500, easing:"easeOutQuad",callback: ->      
#  App.scroll_busy = false        
# })

((root) ->

  root.scroll_to = {
  
  go:( _animation,_settings) ->
    @.isie = root.is_internet_explorer()
    @.isff = root.is_firefox()
    @element= null
    if @.isie || @.isff
      @element= document.documentElement 
      # body focus because explorer redo animation on mouse scroll 
      document.body.focus() 
    else 
      @element= document.body

    
    for key, value of _animation
      
      frames = _settings.duration / 10    
      
      if value.toString().indexOf("%") != -1      
        initial_value = parseInt(@element.style[key])         
        @.animate_tick(@element,{initial:initial_value,is_percent: true,frames: frames},{property: key,to: value},_settings,1)
      else if value.toString().indexOf("px") != -1
        initial_value = @element.scrollTop                         
        @.animate_tick(@element,{initial:initial_value,is_px: true,frames: frames},{property: key,to: value},_settings,1)
      else
        initial_value = @element.scrollTop  
                 
        @.animate_tick({initial:initial_value,is_int: true,frames: frames},{property: key,to: value},_settings,1)

    this

  animate_tick: ( _from, _animation,_settings,current_frame) ->
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
        
    @element.scrollTop= current_value

    
    current_frame++
    
    setTimeout( ->
      self.animate_tick( _from, _animation,_settings,current_frame)
    ,10)
  }
  # Anonymous function empty return
  return
)(App)
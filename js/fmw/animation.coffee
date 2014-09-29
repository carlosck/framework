# *element    :Type: html element  :Example: App.$menu , App.by_id("menu") , document.getElementBy_id("menu")
# *_animation :Type: object        :Example: {"height":"50px","width":"50px" }
# *_settings  :Type: object        :Example: {duration: 500, easing:"easeOutQuad",callback: -> console.log }
# *duration   :Type: int           :Example: 500
#  easing     :Type: string        :Example: "easeOutQuart", "easeInCubic"
#  callback   :Type: function      :Example: -> console.log, App.setBack

# * required

# @.gallery.init({left:left,right:right,menu:menu_elements,slider:slider,current:4})

((root) ->

  root.animate = (element, _animation,_settings) ->
    @busy = false
    @interval_obj = null
    @current_frame=0
    @array_animation= new Array()
    
    @init= ->
      self = @ 
      
      if @busy
        return false    
      @busy = true
      @animations= new Array()
      frames = _settings.duration / 10    

      for key, value of _animation                
        obj= new Object()
        if value.toString().indexOf("%") != -1      
          obj.initial_value = parseInt(element.style[key])         
          obj.measure= "percent"
          obj.to_value= value
          obj.property_to_animate= key
          
        else if value.toString().indexOf("px") != -1
          
          obj.initial_value = getComputedStyle(element)[key]
          obj.measure= "pixels"
          obj.to_value= value         
          obj.property_to_animate= key
          
        else
          obj.initial_value = getComputedStyle(element)[key]
          obj.measure= "int"
          obj.to_value= value 
          obj.property_to_animate= key
                
        @array_animation.push obj        

      @current_frame = 1        
      self.interval_obj = setInterval( ->
        self.animate_tick(element,frames,_settings)
      ,10)

    @animate_tick= (element, _frames, _settings) ->
      # callback at the end of the animation if needed      
      if @current_frame > _frames        
        @.stop()
        if typeof _settings.callback is "function"           
          @busy= false
          _settings.callback.call()
        return false

      for $i in [0..@array_animation.length-1] by 1

        obj = @array_animation[$i]  
        initial = parseInt(obj.initial_value)
        final = parseInt(obj.to_value)
        
        # when easing is defined we need the "js/libs/easing.js from penner-kirupa"
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
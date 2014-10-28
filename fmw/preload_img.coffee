# *_img_array  :Type: array of strings :Example: ["images/img1.jpg","images/img2.jpg","images/img3.jpg","images/titulo.jpg"]
# _on_complete :Type: function  :Example: self.loading_cerrar() 
# _on_update   :Type: function  :Example: self.add_preload(obj), console.log obj
# return :Type: obj {current : 4 ,total : 8 ,percent: 50}

#  * required

# for j in [10..@.num_images] by 1
#   array_img.push("secuencia_final/Seccion0100#{j}.png")  

# self = @

# @.preload_img.init(
#   array_img       
#   ->
#     self.loading_cerrar()
#   (obj) ->        
#     self.add_preload(obj)               
#   )

((root) ->    
  root.preload_img = {
    total : 0
    current : 0
    img_array : null
    on_complete: null
    on_update: null
    init : (_img_array, _on_complete, _on_update) ->
      @img_array = _img_array
      @total = @img_array.length-1
      @on_update = _on_update
      @on_complete = _on_complete
      
      self = @
      for i in [0..@total-1]
        img = null
        img= new Image()
        img.onload = ->
          laimg = this
          self.update(laimg)
        img.src = @img_array[i]

      return  
    update:(img) ->
      
      @current++
      if @current == @total
        if @on_complete != undefined                  
          @on_complete.call(obj)
      else
        if @on_update != undefined
          pc = (@current * 100 ) / @total
          obj = {current : @current,total : @total,percent: pc,image: img}
          @on_update.call(null,obj)

  }
  return
)(App)
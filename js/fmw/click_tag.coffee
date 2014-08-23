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
  root.click_tag = {
    
    init :  ->
      self = @
      root.each(document,".click_tag", (element, i)-> 
        # console.log  element       
        root.set_on(element,"click",self.click_tag)
      )
      

      return  
    click_tag:(event) ->
      e = event || window.event
      console.log e
      target_current = e.target
      found= false
      cont = 0
      
      while cont<10 and !found 
        if root.has_class(target_current,"click_tag")
          final_target= target_current
          found= true
        else
          cont++
          target_current= target_current.parentNode

      if found
        tag = target_current.getAttribute("ct")
        console.log "click"+tag      
        window.ga('send','pageview',tag);
      return

  }
  return
)(App)
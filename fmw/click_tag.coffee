# in coffee @.click_tag.init()
# on .html you need to add the clik_tag class also the attribute ct="value of the clicktag"
# example
# %a#logo.click_tag{href:"http://www.rdy.mx/",target:"_blank",ct:'logo-main'}



((root) ->    
  root.click_tag = {
    
    init :  ->
      self = @
      root.each(document,".click_tag", (element, i)->               
        root.set_on(element,"click",self.click_tag)
      )
      

      return  
    click_tag:(event) ->
      e = event || window.event      
      target_current = root.get_target(e)
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
        window.ga('send','pageview',tag);
      return

  }
  return
)(App)
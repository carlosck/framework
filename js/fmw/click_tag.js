(function(root) {
  root.click_tag = {
    init: function() {
      var self;
      self = this;
      root.each(document, ".click_tag", function(element, i) {
        return root.set_on(element, "click", self.click_tag);
      });
    },
    click_tag: function(event) {
      var cont, e, final_target, found, tag, target_current;
      e = event || window.event;
      target_current = root.get_target(e);
      found = false;
      cont = 0;
      while (cont < 10 && !found) {
        if (root.has_class(target_current, "click_tag")) {
          final_target = target_current;
          found = true;
        } else {
          cont++;
          target_current = target_current.parentNode;
        }
      }
      if (found) {
        tag = target_current.getAttribute("ct");
        window.ga('send', 'pageview', tag);
      }
    }
  };
})(App);

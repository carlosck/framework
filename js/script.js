var App;

App = {
  init: function() {
    this.$stage = null;
    this.$header = null;
    this.$menu = null;
    this.$loader = null;
    this.$gallery = null;
    this.$popup = null;
    this.section = 1;
    this.scroll_busy = true;
    this.current_section = 1;
    this.current_animation = null;
    return this.bind();
  },
  bind: function() {
    this.$stage = this.by_id("stage");
    this.$stage.style.top = "0px";
    this.$header = this.by_id("header");
    this.$menu = this.by_id("menu");
    this.$loader = this.by_id("loading");
    this.$gallery = this.by_id("gallery");
    this.$popup = this.by_id("gallery_popup");
    this.sprite_container = this.by_id("intro_img1");
    return this.start();
  },
  start: function() {
    var elements, left, menu_elements, right, slider;
    this.set_mouse_scroll(this.mouse_scroll);
    this.set_on(document, "keyup", this.key_up);
    elements = this.each(this.$menu, "a", function(element, i) {
      return App.set_on(element, "click", App.menu_click);
    });
    elements = this.each(this.$gallery, ".item_gallery", function(element, i) {
      return App.set_on(element, "click", App.gallery_click);
    });
    this.set_on(App.find(App.$popup, "#popup_close"), "click", function() {
      return App.popup_close();
    });
    left = this.find(this.$popup, "#popup_left_container");
    right = this.find(this.$popup, "#popup_right_container");
    menu_elements = this.find_all(this.$popup, ".popup_button");
    slider = this.find(this.$popup, "#popup_slider");
    this.gallery.init({
      left: left,
      right: right,
      menu: menu_elements,
      slider: slider,
      current: 4,
      easing: "easeOutQuart"
    });
    return this.preload();
  },
  preload: function() {
    var array_img, i, self, _i;
    array_img = new Array();
    for (i = _i = 1; _i <= 30; i = _i += 1) {
      array_img.push("img/secuencia/secuencia_" + i + ".png");
    }
    self = this;
    return this.preload_img.init(array_img, function() {
      return self.loading_cerrar();
    }, function(obj) {
      return self.add_preload(obj);
    });
  },
  add_preload: function(obj) {
    return this.find(App.$loader, "#loading_container").innerHTML = obj.current + " de " + obj.total;
  },
  loading_cerrar: function() {
    return this.animate.to(App.$loader, {
      "height": "0px"
    }, {
      duration: 500,
      easing: "easeOutQuad",
      callback: function() {
        return App.scroll_busy = false;
      }
    });
  },
  mouse_scroll: function(event) {
    var delta, evt;
    evt = window.event || event;
    delta = evt.detail * (-120) || evt.wheelDelta;
    if (delta < 0) {
      if (App.section + 1 < 8) {
        return App.change_page(App.section + 1);
      }
    } else {
      if (App.section - 1 > 0) {
        return App.change_page(App.section - 1);
      }
    }
  },
  key_up: function(event) {
    var delta, e;
    e = window.event || event;
    delta = 0;
    switch (event.which) {
      case 38:
        delta = 1;
        break;
      case 40:
        delta = -1;
    }
    if (delta < 0) {
      if (App.section + 1 < 8) {
        return App.change_page(App.section + 1);
      }
    } else {
      if (App.section - 1 > 0) {
        return App.change_page(App.section - 1);
      }
    }
  },
  menu_click: function(e) {
    var page;
    e = event || window.event;
    e.preventDefault();
    page = e.target.id.replace("menu_item", "");
    App.change_page(parseInt(page));
  },
  gallery_click: function(e) {
    var page;
    e = event || window.event;
    e.preventDefault();
    page = e.target.id.replace("item_gallery_", "");
    App.popup_open(parseInt(page));
  },
  change_page: function(_page) {
    var frame_from, frame_to, top_to_bottom;
    if (this.section === _page || this.scroll_busy) {
      return false;
    }
    this.scroll_busy = true;
    if (this.section < _page) {
      top_to_bottom = true;
    } else {
      top_to_bottom = false;
    }
    this.animate.to(this.find(this.$menu, "#menu_item" + _page), {
      "height": "50px",
      "width": "50px"
    }, {
      duration: 500,
      easing: "easeOutQuad"
    });
    this.animate.to(this.find(this.$menu, "#menu_item" + this.section), {
      "height": "25px",
      "width": "25px"
    }, {
      duration: 500,
      easing: "easeOutQuad"
    });
    if (_page === 2) {
      this.animate.to(this.$header, {
        "height": "50px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
      this.animate.to(this.find(this.$header, "#logo"), {
        "marginTop": "0px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
      this.animate.to(this.find(this.$header, "#list"), {
        "marginTop": "0px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
    }
    if (_page === 1) {
      this.animate.to(this.$header, {
        "height": "100px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
      this.animate.to(this.find(this.$header, "#logo"), {
        "marginTop": "25px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
      this.animate.to(this.find(this.$header, "#list"), {
        "marginTop": "25px"
      }, {
        duration: 500,
        easing: "easeOutQuad"
      });
    }
    frame_from = 0;
    frame_to = 0;
    switch (_page) {
      case 2:
        App.spritefy.init({
          element: this.sprite_container,
          from_frame: 1,
          total_frames: 10,
          tbf: 100,
          restart: true
        });
        break;
      case 3:
        App.spritefy.init({
          element: this.sprite_container,
          from_frame: 11,
          total_frames: 20,
          tbf: 100,
          restart: true
        });
        break;
      case 4:
        App.spritefy.init({
          element: this.sprite_container,
          from_frame: 21,
          total_frames: 30,
          tbf: 100,
          restart: true
        });
    }
    this.section = _page;
    return this.animate.to(this.$stage, {
      "top": ((_page - 1) * -100) + "%"
    }, {
      duration: 500,
      easing: "easeOutQuad",
      callback: function() {
        if (App.current_animation !== null) {
          App.current_animation.stop();
        }
        return App.scroll_busy = false;
      }
    });
  },
  popup_open: function(_section) {
    this.scroll_busy = true;
    this.css(App.$popup, {
      "opacity": 0,
      "display": "block"
    });
    return this.animate.to(this.$popup, {
      "opacity": 1
    }, {
      duration: 100
    });
  },
  popup_close: function() {
    return this.animate.to(this.$popup, {
      "opacity": 0
    }, {
      duration: 100,
      callback: function() {
        App.css(App.$popup, {
          "opacity": 0,
          "display": "none"
        });
        return App.scroll_busy = true;
      }
    });
  }
};

document.addEventListener('DOMContentLoaded', function() {
  return App.init();
});

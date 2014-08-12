(function(root) {
  root.gallery = {
    $left: null,
    $right: null,
    $menu: null,
    $slider: null,
    current: 0,
    busy: false,
    init: function(_settings) {
      var i, self, _i, _ref, _results;
      this.$left = _settings.left;
      this.$right = _settings.right;
      this.$menu = _settings.menu;
      this.$slider = _settings.slider;
      this.current = _settings.current;
      this.easing = null;
      root.add_class(this.$left, "active");
      root.add_class(this.$right, "active");
      if (_settings.easing !== void 0) {
        this.easing = _settings.easing;
      }
      root.add_class(this.$menu[this.current], "active");
      root.css(this.$slider, {
        "left": (this.current * -100) + "%"
      });
      this.page(this.current);
      self = this;
      root.set_on(this.$left, "click", function() {
        return self.prev();
      });
      root.set_on(this.$right, "click", function() {
        return self.next();
      });
      _results = [];
      for (i = _i = 0, _ref = this.$menu.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        _i = i;
        _results.push(root.set_on(this.$menu[i], "click", function(event) {
          var _page;
          event.preventDefault();
          _page = event.target.getAttribute("page");
          return self.page(_page);
        }));
      }
      return _results;
    },
    page: function(_page) {
      var self;
      if (this.busy) {
        return false;
      }
      _page = parseInt(_page);
      this.busy = true;
      this.current = _page;
      if (_page === 0) {
        root.remove_class(this.$left, "active");
      } else {
        if (!root.has_class(this.$left, "active")) {
          root.add_class(this.$left, "active");
        }
      }
      if (_page === this.$menu.length - 1) {
        root.remove_class(this.$right, "active");
      } else {
        if (!root.has_class(this.$right, "active")) {
          root.add_class(this.$right, "active");
        }
      }
      self = this;
      root.remove_class(App.find(self.$menu[0].parentNode, ".popup_button.active"), "active");
      root.add_class(this.$menu[_page], "active");
      this.current = _page;
      if (this.easing !== null) {
        return root.animate.to(this.$slider, {
          "left": (this.current * -100) + "%"
        }, {
          duration: 500,
          easing: this.easing,
          callback: function() {
            return self.busy = false;
          }
        });
      } else {
        return root.animate.to(this.$slider, {
          "left": (this.current * -100) + "%"
        }, {
          duration: 500,
          callback: function() {
            return self.busy = false;
          }
        });
      }
    },
    prev: function() {
      if (this.current === 0) {
        return false;
      }
      return this.page(this.current - 1);
    },
    next: function() {
      if (this.current === this.$menu.length - 1) {
        return false;
      }
      return this.page(this.current + 1);
    }
  };
})(App);

(function() {
  (function(root) {
    root.preload_img = {
      total: 0,
      current: 0,
      img_array: null,
      on_complete: null,
      on_update: null,
      init: function(_img_array, _on_complete, _on_update) {
        var i, img, self, _i, _ref;
        this.img_array = _img_array;
        this.total = this.img_array.length - 1;
        this.on_update = _on_update;
        this.on_complete = _on_complete;
        self = this;
        for (i = _i = 0, _ref = this.total - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          img = null;
          img = new Image();
          img.onload = function() {
            var laimg;
            laimg = this;
            return self.update(laimg);
          };
          img.src = this.img_array[i];
        }
      },
      update: function(img) {
        var obj, pc;
        this.current++;
        if (this.current === this.total) {
          if (this.on_complete !== void 0) {
            return this.on_complete.call(obj);
          }
        } else {
          if (this.on_update !== void 0) {
            pc = (this.current * 100) / this.total;
            obj = {
              current: this.current,
              total: this.total,
              percent: pc,
              image: img
            };
            return this.on_update.call(null, obj);
          }
        }
      }
    };
  })(App);

}).call(this);

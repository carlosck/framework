(function(root) {
  return root.spritefy = function(_settings) {
    this.interval_obj = null;
    this.settings = _settings;
    this.reverse = false;
    this.init = function() {
      var self;
      if (this.settings.restart === !void 0) {
        this.restart();
      } else {
        this.settings.element.className = " " + this.settings.element.className.trim();
      }
      this.settings.current_frame = this.settings.from_frame;
      if (this.settings.current_frame > this.settings.total_frames) {
        this.reverse = true;
      } else {
        this.reverse = false;
      }
      self = this;
      return this.interval_obj = setInterval(function() {
        return self.go();
      }, this.settings.tbf);
    };
    this.go = function() {
      var obj, prev_frame;
      prev_frame = this.settings.current_frame;
      if (!this.reverse) {
        this.settings.current_frame++;
      } else {
        this.settings.current_frame--;
      }
      if ((this.settings.current_frame > this.settings.total_frames && !this.reverse) || (this.settings.current_frame < this.settings.total_frames && this.reverse)) {
        if (this.settings.loop === !void 0) {
          this.settings.restart = true;
          this.stop();
          return this.init(this.settings);
        } else {
          obj = this.interval_obj;
          this.stop();
          if (typeof this.settings.callback === "function") {
            return this.settings.callback.call();
          }
        }
      } else {
        root.remove_all_class_startwith(this.settings.element, "frame");
        return root.add_class(this.settings.element, "frame_" + this.settings.current_frame);
      }
    };
    this.stop = function() {
      return clearInterval(this.interval_obj);
    };
    this.restart = function() {
      var class_array, i;
      i = 0;
      class_array = this.settings.element.className.split(" ");
      root.remove_all_class(this.settings.element);
      while (i <= class_array.length - 1) {
        if (class_array[i].indexOf("frame_") === -1) {
          root.add_class(this.settings.element, class_array[i]);
        }
        i++;
      }
      this.settings.current_frame = this.settings.from_frame;
      return root.add_class(this.settings.element, "frame_" + this.settings.from_frame);
    };
  };
})(App);

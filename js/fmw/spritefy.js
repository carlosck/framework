(function(root) {
  root.spritefy = {
    interval_obj: null,
    settings: null,
    reverse: false,
    init: function(_settings) {
      this.settings = _settings;
      if (this.settings.restart === !void 0) {
        this.restart();
      }
      if (this.settings.current_frame > this.settings.total_frames) {
        this.reverse = true;
      } else {
        this.reverse = false;
      }
      this.settings.current_frame = this.settings.from_frame;
      this.interval_obj = setInterval(function() {
        return root.spritefy.go();
      }, this.settings.tbf);
      return this;
    },
    go: function() {
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
        console.log(this.settings.current_frame);
        return root.replace_class(this.settings.element, "frame_" + prev_frame, "frame_" + this.settings.current_frame);
      }
    },
    stop: function() {
      return clearInterval(this.interval_obj);
    },
    restart: function() {
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
    }
  };
})(App);

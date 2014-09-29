(function(root) {
  return root.animate = function(element, _animation, _settings) {
    this.busy = false;
    this.interval_obj = null;
    this.current_frame = 0;
    this.array_animation = new Array();
    this.init = function() {
      var frames, key, obj, self, value;
      self = this;
      if (this.busy) {
        return false;
      }
      this.busy = true;
      this.animations = new Array();
      frames = _settings.duration / 10;
      for (key in _animation) {
        value = _animation[key];
        obj = new Object();
        if (value.toString().indexOf("%") !== -1) {
          obj.initial_value = parseInt(element.style[key]);
          obj.measure = "percent";
          obj.to_value = value;
          obj.property_to_animate = key;
        } else if (value.toString().indexOf("px") !== -1) {
          obj.initial_value = getComputedStyle(element)[key];
          obj.measure = "pixels";
          obj.to_value = value;
          obj.property_to_animate = key;
        } else {
          obj.initial_value = getComputedStyle(element)[key];
          obj.measure = "int";
          obj.to_value = value;
          obj.property_to_animate = key;
        }
        this.array_animation.push(obj);
      }
      this.current_frame = 1;
      return self.interval_obj = setInterval(function() {
        return self.animate_tick(element, frames, _settings);
      }, 10);
    };
    this.animate_tick = function(element, _frames, _settings) {
      var $i, chunk, current_value, final, fn, initial, obj, _i, _ref;
      if (this.current_frame > _frames) {
        this.stop();
        if (typeof _settings.callback === "function") {
          this.busy = false;
          _settings.callback.call();
        }
        return false;
      }
      for ($i = _i = 0, _ref = this.array_animation.length - 1; _i <= _ref; $i = _i += 1) {
        obj = this.array_animation[$i];
        initial = parseInt(obj.initial_value);
        final = parseInt(obj.to_value);
        if (_settings.easing === void 0) {
          chunk = (final - initial) / _frames;
          current_value = initial + (chunk * this.current_frame);
        } else {
          fn = window[_settings.easing];
          if (typeof fn === "function") {
            current_value = fn.apply(this, new Array(this.current_frame, initial, final - initial, _frames));
          }
        }
        if (obj.measure === "percent") {
          current_value = current_value + "%";
        } else if (obj.measure === "pixels") {
          current_value = current_value + "px";
        }
        element.style[obj.property_to_animate] = current_value;
      }
      return this.current_frame++;
    };
    this.stop = function() {
      clearInterval(this.interval_obj);
      this.busy = false;
      return false;
    };
    if (_settings.autostart === void 0) {
      this.init();
    }
  };
})(App);

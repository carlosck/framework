(function(root) {
  root.animate = {
    to: function(element, _animation, _settings) {
      var frames, initial_value, key, value;
      for (key in _animation) {
        value = _animation[key];
        frames = _settings.duration / 10;
        if (value.toString().indexOf("%") !== -1) {
          initial_value = parseInt(element.style[key]);
          this.animate_tick(element, {
            initial: initial_value,
            is_percent: true,
            frames: frames
          }, {
            property: key,
            to: value
          }, _settings, 1);
        } else if (value.toString().indexOf("px") !== -1) {
          initial_value = getComputedStyle(element)[key];
          this.animate_tick(element, {
            initial: initial_value,
            is_px: true,
            frames: frames
          }, {
            property: key,
            to: value
          }, _settings, 1);
        } else {
          initial_value = getComputedStyle(element)[key];
          this.animate_tick(element, {
            initial: initial_value,
            is_int: true,
            frames: frames
          }, {
            property: key,
            to: value
          }, _settings, 1);
        }
      }
      return this;
    },
    animate_tick: function(element, _from, _animation, _settings, current_frame) {
      var chunk, current_value, final, fn, initial, self;
      self = this;
      if (current_frame > _from.frames) {
        if (typeof _settings.callback === "function") {
          _settings.callback.call();
        }
        return false;
      }
      initial = parseInt(_from.initial);
      final = parseInt(_animation.to);
      if (_settings.easing === void 0) {
        chunk = (final - initial) / _from.frames;
        current_value = initial + (chunk * current_frame);
      } else {
        fn = window[_settings.easing];
        if (typeof fn === "function") {
          current_value = fn.apply(this, new Array(current_frame, initial, final - initial, _from.frames));
        }
      }
      if (_from.is_percent !== void 0) {
        current_value = current_value + "%";
      } else if (_from.is_px !== void 0) {
        current_value = current_value + "px";
      }
      element.style[_animation.property] = current_value;
      current_frame++;
      return setTimeout(function() {
        return self.animate_tick(element, _from, _animation, _settings, current_frame);
      }, 10);
    }
  };
})(App);

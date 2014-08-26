(function() {
  (function(root) {
    root.scroll_to = {
      go: function(_animation, _settings) {
        var frames, initial_value, key, value;
        this.isie = root.is_internet_explorer();
        this.isff = root.is_firefox();
        this.element = null;
        if (this.isie || this.isff) {
          this.element = document.documentElement;
          document.body.focus();
        } else {
          this.element = document.body;
        }
        for (key in _animation) {
          value = _animation[key];
          frames = _settings.duration / 10;
          if (value.toString().indexOf("%") !== -1) {
            initial_value = parseInt(this.element.style[key]);
            this.animate_tick(this.element, {
              initial: initial_value,
              is_percent: true,
              frames: frames
            }, {
              property: key,
              to: value
            }, _settings, 1);
          } else if (value.toString().indexOf("px") !== -1) {
            initial_value = this.element.scrollTop;
            this.animate_tick(this.element, {
              initial: initial_value,
              is_px: true,
              frames: frames
            }, {
              property: key,
              to: value
            }, _settings, 1);
          } else {
            initial_value = this.element.scrollTop;
            this.animate_tick({
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
      animate_tick: function(_from, _animation, _settings, current_frame) {
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
        this.element.scrollTop = current_value;
        current_frame++;
        return setTimeout(function() {
          return self.animate_tick(_from, _animation, _settings, current_frame);
        }, 10);
      }
    };
  })(App);

}).call(this);

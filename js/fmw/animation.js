(function(root) {
  return root.animate = function(element, _animation, _settings) {
    this.busy = false;
    this.interval_obj = null;
    this.current_frame = 0;
    this.array_animation = new Array();
    this.array_transform = new Array();
    this.array_initial = null;
    this.cadena_initial = null;
    this.init = function() {
      var cont, css, found, frames, key, obj, self, value;
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
        obj.to_value = value;
        obj.property_to_animate = key;
        if (value.toString().indexOf("%") !== -1) {
          obj.initial_value = parseInt(element.style[key]);
          if (isNaN(obj.initial_value)) {
            root.css(element, {
              "display": "none"
            });
            obj.initial_value = document.defaultView.getComputedStyle(element, null).getPropertyValue(key);
            root.css(element, {
              "display": "block"
            });
          }
          obj.measure = "percent";
        } else if (value.toString().indexOf("px") !== -1) {
          obj.initial_value = getComputedStyle(element)[key];
          obj.measure = "pixels";
        } else if (value.toString().indexOf("deg") !== -1) {
          obj.initial_value = getComputedStyle(element)[key];
          obj.measure = "deg";
        } else {
          obj.initial_value = getComputedStyle(element)[key];
          obj.measure = "int";
        }
        if (_settings.is_filter !== void 0) {
          obj.initial_value = document.defaultView.getComputedStyle(element, null).getPropertyValue("-webkit-filter").replace(key, "").replace("(", "").replace(")", "");
          if (obj.initial_value === "none") {
            obj.initial_value = 0;
          }
        }
        if (_settings.is_transform !== void 0) {
          css = element.style["transform"];
          this.cadena_initial = css;
          this.array_initial = css.split(" ");
          found = false;
          cont = 0;
          while (!found || cont < this.array_initial.length) {
            if (this.array_initial[cont].indexOf(key) !== -1) {
              found = true;
              obj.key = key;
              obj.initial_value = this.array_initial[cont].replace(key, "").replace("(", "").replace(")", "").replace("deg", "").replace("px", "");
            }
            cont++;
          }
        }
        this.array_animation.push(obj);
      }
      this.current_frame = 1;
      return self.interval_obj = setInterval(function() {
        return self.animate_tick(element, frames, _settings);
      }, 10);
    };
    this.animate_tick = function(element, _frames, _settings) {
      var $i, cadena, chunk, cont, current_value, final, fn, found, initial, obj, _i, _j, _ref, _ref1;
      if (this.current_frame > _frames) {
        this.stop();
        if (typeof _settings.callback === "function") {
          this.busy = false;
          _settings.callback.call();
        }
        return false;
      }
      if (_settings.is_transform !== void 0) {
        cadena = this.cadena_initial;
        for ($i = _i = 0, _ref = this.array_animation.length - 1; _i <= _ref; $i = _i += 1) {
          found = false;
          cont = 0;
          while (!found && cont < this.array_initial.length) {
            obj = this.array_animation[$i];
            if (this.array_initial[cont].indexOf(obj.key) !== -1) {
              found = true;
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
              } else if (obj.measure === "deg") {
                current_value = current_value + "deg";
              }
              cadena = cadena.replace(this.array_initial[cont], obj.key + "(" + current_value + ")");
            }
            cont++;
          }
        }
        console.log(cadena);
        root.css(element, {
          "transform": cadena
        });
      } else {
        for ($i = _j = 0, _ref1 = this.array_animation.length - 1; _j <= _ref1; $i = _j += 1) {
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
          if (_settings.is_filter !== void 0) {
            cadena = obj.property_to_animate + "(" + current_value + ")";
            root.css(element, {
              "-webkit-filter": cadena
            });
          } else {
            element.style[obj.property_to_animate] = current_value;
          }
        }
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

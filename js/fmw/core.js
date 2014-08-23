(function() {
  (function(root) {
    var c;
    c = root;
    c.remove_class = function(_element, _class, _callback) {
      _element.className = _element.className.replace(" " + _class, "");
      if (typeof _callback === "function") {
        return _callback.call();
      }
    };
    c.remove_all_class = function(_element) {
      return _element.className = "";
    };
    c.remove_all_class_startwith = function(_element, _startwith) {
      var class_array, i, _results;
      i = 0;
      class_array = _element.className.split(" ");
      _element.className = "";
      _results = [];
      while (i <= class_array.length - 1) {
        if (class_array[i].indexOf(_startwith) === -1) {
          root.add_class(_element, class_array[i]);
        }
        _results.push(i++);
      }
      return _results;
    };
    c.add_class = function(_element, _class) {
      return _element.className = _element.className + " " + _class;
    };
    c.has_class = function(_element, _class) {
      console.log(_element);
      if (_element.className.indexOf(_class) !== -1) {
        return true;
      } else {
        return false;
      }
    };
    c.replace_class = function(_element, _class, _class_new) {
      return _element.className = _element.className.replace(" " + _class, " " + _class_new);
    };
    c.selector_all = function(_item) {
      return document.querySelectorAll(_item);
    };
    c.by_id = function(_item) {
      return document.getElementById(_item);
    };
    c.by_class = function(_item) {
      return document.getElementByClass(_item);
    };
    c.find = function(_parent, _item) {
      return _parent.querySelectorAll(_item)[0];
    };
    c.find_all = function(_parent, _item) {
      return _parent.querySelectorAll(_item);
    };
    c.each = function(_parent, _item, _callback) {
      var elements;
      elements = _parent.querySelectorAll(_item);
      return Array.prototype.forEach.call(elements, _callback);
    };
    c.set_mouse_scroll = function(_callback) {
      var mousewheelevt;
      mousewheelevt = null;
      if (/Firefox/i.test(navigator.userAgent)) {
        mousewheelevt = "DOMMouseScroll";
      } else {
        mousewheelevt = "mousewheel";
      }
      return this.set_on(document, mousewheelevt, _callback);
    };
    c.set_on = function(_element, _evType, _callback) {
      if (_element.attachEvent) {
        return _element.attachEvent("on" + _evType, _callback);
      } else if (_element.addEventListener) {
        return _element.addEventListener(_evType, _callback, false);
      } else {
        return _element['on' + _evType] = _callback;
      }
    };
    c.css = function(_element, _settings) {
      var key, value, _results;
      _results = [];
      for (key in _settings) {
        value = _settings[key];
        _results.push(_element.style[key] = value);
      }
      return _results;
    };
    c.height = function(_element) {
      return parseInt(getComputedStyle(_element).height);
    };
    c.width = function(_element) {
      return parseInt(getComputedStyle(_element).width);
    };
    c.is_internet_explorer = function() {
      var msie, ua;
      ua = window.navigator.userAgent;
      msie = ua.indexOf("MSIE ");
      if (msie > -1 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) {
        return true;
      } else {
        return false;
      }
    };
    c.get_internet_explorer_version = function() {
      var msie, ua;
      ua = window.navigator.userAgent;
      msie = ua.indexOf("MSIE ");
      return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)));
    };
    return c.prevent_default = function(event) {
      if (this.is_internet_explorer) {
        return event.returnValue = false;
      } else {
        return event.preventDefault();
      }
    };
  })(App);

}).call(this);

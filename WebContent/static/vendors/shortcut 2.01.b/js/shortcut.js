/**
 * http://www.openjs.com/scripts/events/keyboard_shortcuts/ Version : 2.01.B By
 * Binny V A License : BSD
 */
shortcut = {
	'all_shortcuts': {}, // All the shortcuts are stored here
	'add': function(shortcut_combination, callback, opt) {
		// Provide a set of default options
		var default_options = {
			'type': 'keydown',
			'propagate': false,
			'disable_in_input': false,
			'disable_in_select': false,
			'target': document,
			'keycode': false
		};
		if (!opt) {
			opt = default_options;
		} else {
			for ( var dfo in default_options) {
				if (typeof opt[dfo] == 'undefined') {
					opt[dfo] = default_options[dfo];
				}
			}
		}
		var ele = opt.target;
		if (typeof opt.target == 'string') {
			ele = document.getElementById(opt.target);
		}
		shortcut_combination = this.preProcessShortcut(shortcut_combination);

		var func = function(e) { // The function to be called at keypress
			e = e || window.event;
			if (opt['disable_in_input'] || opt['disable_in_select']) { // Don't enable shortcut keys in Input, Textarea fields
				var element = null;
				if (e.target) {
					element = e.target;
				} else if (e.srcElement) {
					element = e.srcElement;
				}
				if (element.nodeType == 3) {
					element = element.parentNode;
				}
				if ((opt['disable_in_input'] && (element.tagName == 'INPUT' || element.tagName == 'TEXTAREA')) || (opt['disable_in_select'] && element.tagName == 'SELECT')) {
					return;
				}
			}
			// Find Which key is pressed
			if (e.keyCode) {
				code = e.keyCode;
			} else if (e.which) {
				code = e.which;
			}
			// Check numeric keypad codes.
			if (code >= 96 && code <= 105 ) {
				// Convert from numeric keypad to common numeric key code.
				code -= 48;
			}
			var character = String.fromCharCode(code).toLowerCase();
			if (code == 188) {
				character = ","; // If the user presses , when the type is onkeydown
			}
			if (code == 190) {
				character = "."; // If the user presses , when the type is onkeydown
			}
			var keys = shortcut_combination.split("+");
			// Key Pressed - counts the number of valid keypresses - if it is same as
			// the number of keys, the shortcut function is invoked
			var kp = 0;
			// Work around for stupid Shift key bug created by using lowercase - as a
			// result the shift+num combination was broken
			var shift_nums = {
				"`": "~",
				"1": "!",
				"2": "@",
				"3": "#",
				"4": "$",
				"5": "%",
				"6": "^",
				"7": "&",
				"8": "*",
				"9": "(",
				"0": ")",
				"-": "_",
				"=": "+",
				";": ":",
				"'": "\"",
				",": "<",
				".": ">",
				"/": "?",
				"\\": "|"
			};
			// Special Keys - and their codes
			var special_keys = {
				'esc': 27,
				'escape': 27,
				'tab': 9,
				'space': 32,
				'return': 13,
				'enter': 13,
				'backspace': 8,
				'scrolllock': 145,
				'scroll_lock': 145,
				'scroll': 145,
				'capslock': 20,
				'caps_lock': 20,
				'caps': 20,
				'numlock': 144,
				'num_lock': 144,
				'num': 144,
				'pause': 19,
				'break': 19,
				'insert': 45,
				'ins': 45,
				'home': 36,
				'delete': 46,
				'del': 46,
				'end': 35,
				'pageup': 33,
				'page_up': 33,
				'page up': 33,
				'pu': 33,
				'pagedown': 34,
				'page_down': 34,
				'page down': 34,
				'pd': 34,
				'left': 37,
				'up': 38,
				'right': 39,
				'down': 40,
				'f1': 112,
				'f2': 113,
				'f3': 114,
				'f4': 115,
				'f5': 116,
				'f6': 117,
				'f7': 118,
				'f8': 119,
				'f9': 120,
				'f10': 121,
				'f11': 122,
				'f12': 123,
				'n0': 96,
				'n1': 97,
				'n2': 98,
				'n3': 99,
				'n4': 100,
				'n5': 101,
				'n6': 102,
				'n7': 103,
				'n8': 104,
				'n9': 105
			};
			var modifiers = {
				shift: {
					wanted: false,
					pressed: false
				},
				ctrl: {
					wanted: false,
					pressed: false
				},
				alt: {
					wanted: false,
					pressed: false
				},
				meta: {
					wanted: false,
					pressed: false
				}
			// Meta is Mac specific
			};
			/**
			 * Check if special key has been pressed.
			 * If so, consider character as empty string because
			 * converting the key to a character does not make sense.
			 *
			 * This check is necessary to avoid, for instance, mapping
			 * F5 key (code 116) to letter "t" (ASCII 116).
			 */
			var special_keys_values = Object.keys(special_keys).map(function(key) {
			    return special_keys[key];
			});
			if (special_keys_values.indexOf(code) > -1) {
				character = "";
			}

			if (e.ctrlKey) {
				modifiers.ctrl.pressed = true;
			}
			if (e.shiftKey) {
				modifiers.shift.pressed = true;
			}
			if (e.altKey) {
				modifiers.alt.pressed = true;
			}
			if (e.metaKey) {
				modifiers.meta.pressed = true;
			}
			for (var i = 0; k = keys[i], i < keys.length; i++) {
				// Modifiers
				if (k == 'ctrl' || k == 'control') {
					kp++;
					modifiers.ctrl.wanted = true;
				} else if (k == 'shift') {
					kp++;
					modifiers.shift.wanted = true;
				} else if (k == 'alt') {
					kp++;
					modifiers.alt.wanted = true;
				} else if (k == 'meta') {
					kp++;
					modifiers.meta.wanted = true;
				} else if (k.length > 1) { // If it is a special key
					if (special_keys[k] == code) {
						kp++;
					}
				} else if (opt['keycode']) {
					if (opt['keycode'] == code) {
						kp++;
					}
				} else { // The special keys did not match
					if (character == k) {
						kp++;
					} else {
						if (shift_nums[character] && e.shiftKey) { // Stupid Shift key bug created by using lowercase
							character = shift_nums[character];
							if (character == k) {
								kp++;
							}
						}
					}
				}
			}
			if (kp == keys.length && modifiers.ctrl.pressed == modifiers.ctrl.wanted
					&& modifiers.shift.pressed == modifiers.shift.wanted
					&& modifiers.alt.pressed == modifiers.alt.wanted
					&& modifiers.meta.pressed == modifiers.meta.wanted
					&& (typeof shortcut.all_shortcuts[shortcut_combination] != 'undefined' && shortcut.all_shortcuts[shortcut_combination].enabled)) {

				callback(e, shortcut_combination);

				if (!opt['propagate']) { // Stop the event
					e.cancelBubble = true; // e.cancelBubble is supported by IE - this will kill the bubbling process.
					e.returnValue = false;
					if (e.stopPropagation) { // e.stopPropagation works in Firefox.
						e.stopPropagation();
						e.preventDefault();
					}
					return false;
				}
			}
		};
		this.all_shortcuts[shortcut_combination] = {
			'callback': func,
			'target': ele,
			'event': opt['type'],
			'enabled': true
		};
		// Attach the function with the event
		if (ele.addEventListener) {
			ele.addEventListener(opt['type'], func, false);
		} else if (ele.attachEvent) {
			ele.attachEvent('on' + opt['type'], func);
		} else {
			ele['on' + opt['type']] = func;
		}
	},
	'addAll': function(shortcut_combinations, callback, opt) {
		for (var sc in shortcut_combinations) {
			shortcut.add(shortcut_combinations[sc], callback, opt);
		}
	},
	'remove': function(shortcut_combination) { // Remove the shortcut - just specify the shortcut and I will remove the binding
		shortcut_combination = this.preProcessShortcut(shortcut_combination);
		var binding = this.all_shortcuts[shortcut_combination];
		delete (this.all_shortcuts[shortcut_combination]);
		if (!binding) {
			return;
		}
		var type = binding['event'];
		var ele = binding['target'];
		var callback = binding['callback'];
		if (ele.detachEvent) {
			ele.detachEvent('on' + type, callback);
		} else if (ele.removeEventListener) {
			ele.removeEventListener(type, callback, false);
		} else {
			ele['on' + type] = false;
		}
	},
	'disable': function(shortcut_combination) {
		shortcut_combination = this.preProcessShortcut(shortcut_combination);
		if (typeof this.all_shortcuts[shortcut_combination] == 'undefined') {
			return;
		}
		this.all_shortcuts[shortcut_combination].enabled = false;
	},
	'enable': function(shortcut_combination) {
		shortcut_combination = this.preProcessShortcut(shortcut_combination);
		if (typeof this.all_shortcuts[shortcut_combination] == 'undefined') {
			return;
		}
		this.all_shortcuts[shortcut_combination].enabled = true;
	},
	'removeAll': function() { // Remove all shortcuts
		for ( var shrtct in this.all_shortcuts) {
			this.remove(shrtct);
		}
	},
	'disableAll': function() {
		for (var shrtct in this.all_shortcuts) {
			this.disable(shrtct);
		}
	},
	'disableAllExcept': function(except) { // Disable all shortcuts, expect specified as a string or an array.
		if (typeof except == 'string') {
			except = except.toLowerCase();
			for (var shrtct in this.all_shortcuts) {
				if (shrtct != except) {
					this.disable(shrtct);
				}
			}
		} else if (typeof except == 'object' && typeof except.length != 'undefined') {
			except = except.map(function(ex) {
				return ex.toLowerCase();
			});
			for (var shrtct in this.all_shortcuts) {
				if (except.indexOf(shrtct) === -1) {
					this.disable(shrtct);
				}
			}
		}
	},
	'enableAll': function() { // Enable all shortcuts
		for ( var shrtct in this.all_shortcuts) {
			this.enable(shrtct);
		}
	},
	'preProcessShortcut': function(keys) {
		/**
		 * Numeric keypad shortcuts arrive here as "n<NUM>" or "num-<NUM>".
		 * Convert such shortcuts to their equivalent numeric
		 * representation by removing the "n" or "num-".
		 * This assures that "1", "n1" or "num-1" are mapped to "1",
		 * and that both numeric keypads (top row and lateral) work.
		 */
		var shortcut_combination = keys.toLowerCase()
									.replace(/n([0-9])/, '$1')
									.replace(/num-([0-9])/, '$1');
		return shortcut_combination;
	}
};
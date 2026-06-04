(function () {
    // --- Theme switching ---
    var root = document.documentElement;
    var storageKey = 'g3pix-theme';
    var themeSelect = document.querySelector('[data-theme-select]');

    var setTheme = function (theme) {
        if (!theme) {
            root.removeAttribute('data-theme');
            localStorage.removeItem(storageKey);
            return;
        }
        root.setAttribute('data-theme', theme);
        localStorage.setItem(storageKey, theme);
    };

    var savedTheme = localStorage.getItem(storageKey);
    if (savedTheme === 'light' || savedTheme === 'dark') {
        setTheme(savedTheme);
    }

    if (themeSelect) {
        themeSelect.value = (savedTheme === 'light' || savedTheme === 'dark') ? savedTheme : 'auto';
        themeSelect.addEventListener('change', function (event) {
            var selected = event.target.value;
            if (selected === 'auto') {
                setTheme(null);
            } else {
                setTheme(selected);
            }
        });
    }

    // --- Mobile nav toggle ---
    var toggle = document.getElementById('g3pix-nav-toggle');
    var shell = document.getElementById('g3pix-nav-shell');

    if (toggle && shell) {
        toggle.addEventListener('click', function () {
            if (shell.className.indexOf('is-open') >= 0) {
                shell.className = shell.className.replace(' is-open', '');
                return;
            }
            shell.className += ' is-open';
        });
    }

    var shortcodeButtons = document.querySelectorAll('.g3pix-insert-shortcode');
    var i;
    for (i = 0; i < shortcodeButtons.length; i++) {
        shortcodeButtons[i].addEventListener('click', function () {
            var targetName = this.getAttribute('data-target');
            var shortcode = this.getAttribute('data-shortcode') || '';
            if (!targetName || !shortcode) {
                return;
            }

            var target = document.querySelector('textarea[name="' + targetName + '"]');
            if (!target) {
                return;
            }

            var start = target.selectionStart || 0;
            var end = target.selectionEnd || 0;
            var before = target.value.substring(0, start);
            var after = target.value.substring(end);
            target.value = before + shortcode + after;
            target.focus();

            var cursor = start + shortcode.length;
            target.selectionStart = cursor;
            target.selectionEnd = cursor;
        });
    }
})();
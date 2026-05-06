window.PromptUI = (() => {
	const C = {
		base:    '#1e1e2e',
		mantle:  '#181825',
		surface0:'#313244',
		surface1:'#45475a',
		surface2:'#585b70',
		text:    '#cdd6f4',
		subtext: '#a6adc8',
		overlay: '#6c7086',
		blue:    '#89b4fa',
		mauve:   '#cba6f7',
		peach:   '#fab387',
		green:   '#a6e3a1',
		red:     '#f38ba8',
		maroon:  '#eba0ac',
		yellow:  '#f9e2af',
	};

	function el(tag, css, props) {
		const e = document.createElement(tag);
		if (css) e.style.cssText = css;
		if (props) Object.assign(e, props);
		return e;
	}

	function build() {
		const host = el('div', `
			position: fixed;
			top: 60px; right: 20px;
			width: 420px; height: 520px;
			z-index: 2147483647;
			border-radius: 8px;
			resize: both; overflow: hidden;
		`);
		host.id = 'prompt-api-panel';

		const shadow = host.attachShadow({ mode: 'open' });

		const style = document.createElement('style');
		style.textContent = `
			*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
			:host { display: block; }
			#root {
				width: 100%; height: 100%;
				background: ${C.base};
				color: ${C.green};
				font-family: 'Cascadia Code', 'Fira Code', 'Consolas', monospace;
				font-size: 13px; line-height: 1.5;
				box-shadow: 0 8px 40px rgba(0,0,0,0.7);
				border-radius: 8px;
				border: 1px solid ${C.surface1};
				display: flex; flex-direction: column;
				overflow: hidden;
			}
			#header {
				padding: 8px 14px;
				background: ${C.mantle};
				border-bottom: 1px solid ${C.surface0};
				font-size: 11px; font-weight: bold; letter-spacing: 0.08em;
				color: ${C.subtext};
				flex-shrink: 0;
				display: flex; justify-content: space-between; align-items: center;
				cursor: grab; border-radius: 8px 8px 0 0; user-select: none;
			}
			#header.grabbing { cursor: grabbing; }
			#close-btn {
				background: none; border: none;
				color: ${C.overlay}; cursor: pointer;
				font-size: 13px; padding: 0; line-height: 1;
				font-family: inherit;
			}
			#feed {
				flex: 1; overflow-y: auto;
				padding: 10px 14px;
				display: flex; flex-direction: column-reverse; gap: 2px;
			}
			#stats-bar {
				flex-shrink: 0;
				padding: 3px 14px;
				font-size: 10px; color: ${C.overlay};
				background: ${C.mantle};
				border-top: 1px solid ${C.surface0};
				white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
			}
			#footer {
				flex-shrink: 0;
				border-top: 1px solid ${C.surface0};
				background: ${C.mantle};
				padding: 8px 12px;
				display: flex; align-items: flex-end; gap: 8px;
				border-radius: 0 0 8px 8px;
			}
			#prompt-glyph {
				color: ${C.green}; font-size: 15px;
				line-height: 1.8; flex-shrink: 0; user-select: none;
			}
			#input {
				flex: 1; background: transparent; border: none;
				color: ${C.text}; font-family: inherit;
				font-size: 13px; line-height: 1.6;
				padding: 2px 0; resize: none; outline: none; overflow: hidden;
			}
			#input::placeholder { color: ${C.overlay}; }
			#queue-count {
				font-size: 10px; color: ${C.peach};
				flex-shrink: 0; align-self: center;
				opacity: 0.8;
			}
			.link-line { padding: 1px 0; }
			.link-line a {
				color: ${C.blue}; text-decoration: none;
				border-bottom: 1px solid ${C.blue}66;
			}
			.link-line a:hover { border-bottom-color: ${C.blue}; }
			.line {
				white-space: pre-wrap; word-break: break-word; padding: 1px 0;
			}
			.line.md { white-space: normal; }
			.line.md p { margin: 0 0 6px; }
			.line.md p:last-child { margin-bottom: 0; }
			.line.md h1,.line.md h2,.line.md h3,.line.md h4 {
				color: ${C.blue}; margin: 8px 0 4px; font-size: 1em;
			}
			.line.md ul,.line.md ol { padding-left: 18px; margin: 4px 0; }
			.line.md li { margin: 2px 0; }
			.line.md code {
				background: ${C.surface1}; color: ${C.peach};
				padding: 1px 4px; border-radius: 3px; font-family: inherit; font-size: 0.95em;
			}
			.line.md pre {
				background: ${C.surface0}; border: 1px solid ${C.surface1};
				border-radius: 4px; padding: 8px 10px; overflow-x: auto; margin: 6px 0;
			}
			.line.md pre code { background: none; padding: 0; color: ${C.text}; }
			.line.md a { color: ${C.blue}; }
			.line.md strong { color: ${C.text}; }
			.separator { border-top: 1px solid ${C.surface0}; margin: 6px 0; }
		`;

		const root = el('div');
		root.id = 'root';

		const header = el('div');
		header.id = 'header';

		const titleText = el('span');
		titleText.textContent = 'prompt-api — bash';

		const closeBtn = el('button');
		closeBtn.id = 'close-btn';
		closeBtn.textContent = '✕';
		closeBtn.onclick = () => host.remove();

		header.append(titleText, closeBtn);

		let dragging = false, ox = 0, oy = 0;
		header.addEventListener('mousedown', (e) => {
			if (e.target === closeBtn) return;
			dragging = true;
			ox = e.clientX - host.getBoundingClientRect().left;
			oy = e.clientY - host.getBoundingClientRect().top;
			header.classList.add('grabbing');
		});
		document.addEventListener('mousemove', (e) => {
			if (!dragging) return;
			host.style.left = (e.clientX - ox) + 'px';
			host.style.top  = (e.clientY - oy) + 'px';
			host.style.right = 'unset';
		});
		document.addEventListener('mouseup', () => {
			dragging = false;
			header.classList.remove('grabbing');
		});

		const feed = el('div');
		feed.id = 'feed';

		const statsBar = el('div');
		statsBar.id = 'stats-bar';
		const statsEl = el('span');
		statsEl.id = 'stats';
		statsBar.appendChild(statsEl);

		const footer = el('div');
		footer.id = 'footer';

		const promptGlyph = el('span');
		promptGlyph.id = 'prompt-glyph';
		promptGlyph.textContent = '❯';

		const input = el('textarea', null, { rows: 1, placeholder: 'enter prompt…' });
		input.id = 'input';
		input.addEventListener('input', () => {
			input.style.height = 'auto';
			input.style.height = input.scrollHeight + 'px';
		});

		const queueCount = el('span');
		queueCount.id = 'queue-count';

		footer.append(promptGlyph, input, queueCount);
		root.append(header, feed, statsBar, footer);
		shadow.append(style, root);
		document.body.appendChild(host);

		return { host, feed, input, statsEl, C };
	}

	function addLine(feed, C, text, color, prefix) {
		const line = el('div');
		line.className = 'line';
		line.style.color = color;
		line.textContent = prefix ? `${prefix} ${text}` : text;
		feed.prepend(line);
		return line;
	}

	function addSeparator(feed, C) {
		const sep = el('div');
		sep.className = 'separator';
		feed.prepend(sep);
	}

	function addStreamingBlock(feed, C, color) {
		const wrap = el('div');
		wrap.className = 'line md';
		wrap.style.color = color;
		feed.prepend(wrap);
		return {
			el: wrap,
			update(text) {
				wrap.innerHTML = window.marked.parse(text);
			},
		};
	}

	function addLink(feed, C, label, url) {
		const wrap = el('div');
		wrap.className = 'link-line';
		const a = el('a');
		a.href = url;
		a.textContent = label;
		a.target = '_blank';
		a.rel = 'noopener noreferrer';
		wrap.appendChild(a);
		feed.prepend(wrap);
	}

	return { build, addLine, addLink, addSeparator, addStreamingBlock };
})();

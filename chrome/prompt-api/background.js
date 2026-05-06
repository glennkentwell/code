chrome.action.onClicked.addListener((tab) => {
	chrome.scripting.executeScript({
		target: { tabId: tab.id },
		files: ['marked.min.js', 'ui.js', 'prompt.js'],
	});
});

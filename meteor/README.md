# Meteor

Leaderboard demo application (Meteor 0.6.4).

## Structure

```
leaderboard/
├── leaderboard.html   # Handlebars templates
├── leaderboard.js     # Client/server logic
├── leaderboard.css    # Styling
├── public/            # Static assets
└── .meteor/           # Framework config
```

## Files

### leaderboard.js
MongoDB CRUD, session state, event handlers, seed data.

**Issues:**
- **Critical security flaw:** `allow()` returns true for all operations—full database access to any client
- Hardcoded offensive name in seed data
- No input validation on player names
- Inconsistent indentation

### leaderboard.html
Player list, details panel, add-player form.

**Issues:**
- Deprecated `<br clear="all" />`
- No accessibility attributes

### leaderboard.css
Clean, readable. Hardcoded colors, no responsive design.

### .meteor/packages
Uses `autopublish` and `insecure`—**must remove for production**.

## Running

```bash
cd meteor/leaderboard
meteor run
```

Requires Meteor framework installation.

## Status

**Demo only.** Meteor 0.6.4 is extremely outdated (2013). Modern Meteor is 2.x+.

Security packages `autopublish` and `insecure` auto-expose all data and disable access control.

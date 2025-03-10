# Instagram Stories Feature

This project demonstrates an Instagram Stories–like feature built with Swift and SwiftUI. It showcases key iOS engineering skills such as code quality, architecture, performance, and best practices.

## Features

### Story List Screen
- **Horizontal Scrolling:** Stories are displayed with pagination.
- **Visual Indicators:** Stories are shown with a gray border when seen and a blue border when unseen.
- **Full-Screen View:** Tapping a story opens it in a full-screen mode.

### Story Full-Screen View
- **Display:** Shows story content in full screen with a like button and a dismiss button.
- **Navigation:** 
  - Tapping the **right half** of the screen animates to the next story.
  - Tapping the **left half** of the screen animates to the previous story.
- **Seen State:** Automatically marks stories as seen upon display.

### State Persistence
- **UserDefaults:** Persists seen and liked states across sessions.
- **Reset Behavior:** New batches of stories reset state for un-interacted users while preserving interactions.

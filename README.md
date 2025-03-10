##Instagram Stories Feature##

This project demonstrates an Instagram Stories–like feature built with Swift and SwiftUI. It showcases key iOS engineering skills such as code quality, architecture, performance, and best practices.

#Features#
Story List Screen:
	•	Horizontal scrolling of stories with pagination.
	•	Visual indicators for seen (gray border) and unseen (blue border) stories.
	•	Tapping a story opens a full-screen view.
 
Story Full-Screen View:
	•	Displays story content full-screen with a like button and a dismiss button.
	•	Tapping the right half of the screen animates to the next story.
  •	Tapping the left half of the screen animates to the previous story.
	•	Automatically marks stories as seen upon display.

State Persistence:
	•	Uses UserDefaults to persist seen and liked states across sessions.
	•	New batches of stories reset state for un-interacted users while preserving interactions.

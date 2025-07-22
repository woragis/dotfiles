// ~/.config/ags/config.js

import { Bar } from './widgets/bar/bar.js'; // We'll create this next

// Function to apply CSS
App.config({
    style: App.configDir + '/style.scss',
    windows: [
        Bar(), // Create your main bar
        // Add other popups/windows here later, e.g.,
        // ControlCenter(),
        // NotificationPopups(),
    ],
});
// Import necessary modules
import { Gdk } from "ags/gtk4"; // Gdk is fine
import Bar from "./widgets/bar/index"; // Import your main Bar component

// Main AGS configuration
// Fix 1 & 2: Use global 'App' object for config and configDir. Convert ListModel to array.
// Fix 3: Explicitly type 'monitor'.
App.config({
    style: `${App.configDir}/style.scss`, // Use template literal for path
    windows: Gdk.Display.get_default()?.get_monitors().map((monitor: Gdk.Monitor) => Bar(monitor)) || [],
    // If .map() still gives issues on ListModel, you might need to convert it explicitly:
    // windows: Array.from(Gdk.Display.get_default()?.get_monitors() || []).map((monitor: Gdk.Monitor) => Bar(monitor)) || [],
});
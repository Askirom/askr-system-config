// Focus or launch Alacritty

function focusOrLaunchAlacritty() {
  var found = false;
  workspace.clientList().forEach(function (client) {
    if (
      client.resourceClass.toLowerCase() === "alacritty" ||
      client.caption.toLowerCase().includes("alacritty")
    ) {
      workspace.activeClient = client;
      found = true;
    }
  });

  if (!found) {
    launchAlacritty();
  }
}

function launchAlacritty() {
  // Launch using KIO/Plasma Wayland-safe method
  var proc = new QProcess();
  proc.startDetached("alacritty");
}

// Register shortcut
registerShortcut(
  "FocusAlacritty",
  "Focus or Launch Alacritty",
  "Meta+Alt+Space",
  focusOrLaunchAlacritty,
);

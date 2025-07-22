import { execAsync } from "ags/process";
import { Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";

type Device = '@DEFAULT_AUDIO_SINK@' | '@DEFAULT_AUDIO_SOURCE@';

/** FontAwesome icons */
const icons = {
  speaker: { on: "", mute: "" }, // fa-volume-up / fa-microphone-slash
  mic: { on: "", mute: "" },     // fa-microphone / fa-microphone-slash
};

/** Current values to be shown */
let speakerState = "0% ";
let micState = "0% ";

/** Reactive display via createPoll */
export const speakerVolume = createPoll(speakerState, 500, () => speakerState);
export const micVolume = createPoll(micState, 500, () => micState);

/** Extracts volume info from wpctl output */
const getVolumeInfo = async (device: Device) => {
  try {
    const output = await execAsync(`wpctl get-volume ${device}`);
    const match = output.match(/Volume: ([\d.]+) \[(\d+)%\](?: \[(MUTED)\])?/);
    if (match) {
      const percentage = parseInt(match[2]);
      const muted = !!match[3];
      return { percentage, muted };
    }
  } catch (e) {
    console.error(`Failed to get volume for ${device}:`, e);
  }
  return { percentage: 0, muted: true };
};

/** Updates both speaker/mic display text */
export const refreshVolumes = async () => {
  const [spk, mic] = await Promise.all([
    getVolumeInfo('@DEFAULT_AUDIO_SINK@'),
    getVolumeInfo('@DEFAULT_AUDIO_SOURCE@'),
  ]);

  speakerState = `${spk.percentage}% ${spk.muted ? icons.speaker.mute : icons.speaker.on}`;
  micState = `${mic.percentage}% ${mic.muted ? icons.mic.mute : icons.mic.on}`;
};

/** Start automatic refresh */
setInterval(refreshVolumes, 1000);
refreshVolumes(); // initial load

/** Volume adjustment and toggle functions */
export const setVolume = async (device: Device, change: string) => {
  await execAsync(`wpctl set-volume ${device} ${change}`);
  refreshVolumes();
};

export const toggleMute = async (device: Device) => {
  await execAsync(`wpctl set-mute ${device} toggle`);
  refreshVolumes();
};

/** UI Component */
export function AudioControls() {
  return (
    <box orientation={Gtk.Orientation.VERTICAL} spacing={15}>
      {/* Speaker Controls */}
      <box orientation={Gtk.Orientation.HORIZONTAL} spacing={8}>
        <label label=" Speaker:" /> {/* fa-volume-up */}
        <button onClicked={() => setVolume('@DEFAULT_AUDIO_SINK@', '5%+')}>
          <label label="+" />
        </button>
        <button onClicked={() => setVolume('@DEFAULT_AUDIO_SINK@', '5%-')}>
          <label label="-" />
        </button>
        <button onClicked={() => toggleMute('@DEFAULT_AUDIO_SINK@')}>
          <label label="" /> {/* fa-volume-mute */}
        </button>
        <label label={speakerVolume} hexpand halign={Gtk.Align.END} />
      </box>

      {/* Mic Controls */}
      <box orientation={Gtk.Orientation.HORIZONTAL} spacing={8}>
        <label label=" Mic:" /> {/* fa-microphone */}
        <button onClicked={() => setVolume('@DEFAULT_AUDIO_SOURCE@', '5%+')}>
          <label label="+" />
        </button>
        <button onClicked={() => setVolume('@DEFAULT_AUDIO_SOURCE@', '5%-')}>
          <label label="-" />
        </button>
        <button onClicked={() => toggleMute('@DEFAULT_AUDIO_SOURCE@')}>
          <label label="" /> {/* fa-microphone-slash */}
        </button>
        <label label={micVolume} hexpand halign={Gtk.Align.END} />
      </box>
    </box>
  );
}

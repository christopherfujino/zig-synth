const std = @import("std");
const out = std.io.getStdOut().writer();
const err = std.io.getStdErr().writer();
const exit = std.os.exit;
const c = @cImport({
    @cInclude("alsa/asoundlib.h");
});

pub fn main() !void {
    var handle: ?*c.snd_pcm_t = null;

    // Open PCM device for playback.
    const rc = c.snd_pcm_open(
        &handle,
        "default",
        c.SND_PCM_STREAM_PLAYBACK,
        0,
    );
    if (rc < 0) {
        _ = try err.print(
            "Unable to open PCM device: {s}\n",
            .{c.snd_strerror(rc)},
        );
        exit(1);
    }

    var params: ?*c.snd_pcm_hw_params_t = null;

    // Allocate a hardware parameters object.
    //#define __snd_alloca(ptr,type) do { *ptr = (type##_t *) alloca(type##_sizeof()); memset(*ptr, 0, type##_sizeof()); } while (0)
    c.snd_pcm_hw_params_alloca(&params);

    // Fill it in with default values.
    c.snd_pcm_hw_params_any(handle, params);

    _ = try out.write("Done.\n");
}

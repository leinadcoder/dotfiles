{ pkgs, ... }:

# Speaker "loudness" chain for the Latitude 5590 internal speakers (ALC3246).
#
# Windows ships Waves MaxxAudio on this codec, which compresses and boosts the
# signal; Linux sends it raw, so the same slider position sounds much quieter.
# This recreates that: compressor with makeup gain -> lookahead limiter capped
# below 0 dBFS, so it gets louder without clipping and without >100% volume.
#
# It is a WirePlumber "smart filter": it is inserted transparently only in
# front of the analog sink below. The default sink and the volume slider stay
# on the hardware device; Bluetooth/HDMI sinks are not processed.
# Note: the 3.5mm jack is a port of the same ALSA sink, so wired headphones
# also go through this chain.
let
  targetSink = "alsa_output.pci-0000_00_1f.3.analog-stereo";
  ladspa = "${pkgs.ladspaPlugins}/lib/ladspa";

  # Tuning knobs. More makeup = louder; limit keeps peaks from clipping.
  makeupGainDb = 14.0;
  thresholdDb = -20.0;
  ratio = 4.0;
  limitDb = -1.0;
in
{
  services.pipewire.extraConfig.pipewire."60-speaker-loudness" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        args = {
          "node.description" = "Speaker Loudness";
          "media.name" = "Speaker Loudness";
          "filter.graph" = {
            nodes = [
              {
                type = "ladspa";
                name = "comp";
                plugin = "${ladspa}/sc4_1882.so";
                label = "sc4";
                control = {
                  "RMS/peak" = 0.0;
                  "Attack time (ms)" = 10.0;
                  "Release time (ms)" = 150.0;
                  "Threshold level (dB)" = thresholdDb;
                  "Ratio (1:n)" = ratio;
                  "Knee radius (dB)" = 6.0;
                  "Makeup gain (dB)" = makeupGainDb;
                };
              }
              {
                type = "ladspa";
                name = "limit";
                plugin = "${ladspa}/fast_lookahead_limiter_1913.so";
                label = "fastLookaheadLimiter";
                control = {
                  "Input gain (dB)" = 0.0;
                  "Limit (dB)" = limitDb;
                  "Release time (s)" = 0.05;
                };
              }
            ];
            links = [
              { output = "comp:Left output"; input = "limit:Input 1"; }
              { output = "comp:Right output"; input = "limit:Input 2"; }
            ];
            inputs = [ "comp:Left input" "comp:Right input" ];
            outputs = [ "limit:Output 1" "limit:Output 2" ];
          };
          "audio.channels" = 2;
          "audio.position" = [ "FL" "FR" ];
          "capture.props" = {
            "node.name" = "effect_input.speaker_loudness";
            "media.class" = "Audio/Sink";
            "filter.smart" = true;
            "filter.smart.name" = "speaker-loudness";
            "filter.smart.target" = { "node.name" = targetSink; };
          };
          "playback.props" = {
            "node.name" = "effect_output.speaker_loudness";
            "node.passive" = true;
          };
        };
      }
    ];
  };
}

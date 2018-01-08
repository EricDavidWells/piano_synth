
import mido
from mido import MidiFile

# open a midi file
mid = MidiFile(r'C:\Users\bwcon\Documents\Processing Projects\piano_synth\MidiFiles\c-major-scale-on-treble-clef.mid')
print(mid.type)     # midi file type (0, 1, or 2)
print(mid.length)   # time length in seconds
print(mid.ticks_per_beat)   # ticks per beat, tick is the smallest time unit

# mido.get_output_names()   # gets available output port names

messages = []

for i, track in enumerate(mid.tracks):
    print('Track {}: {}'.format(i, track.name))
    for msg in track:
        if 'note' in msg.type:
            print(msg)




import csv
import mido
from mido import MidiFile

midifilename = r'C:\Users\bwcon\Documents\Processing Projects\piano_synth\MidiFiles\Porz-Goret-Yann-Tiersen.mid'
# midifilename = r'C:\Users\bwcon\Documents\Processing Projects\piano_synth\MidiFiles\c-major-scale-on-treble-clef.mid'
outputfilename = r'C:\Users\bwcon\Documents\Processing Projects\piano_synth\NoteFiles\porz_goret.csv'

timestart_delay = 5

# open a midi file
mid = MidiFile(midifilename)

type = mid.type     # midi file type (0, 1, or 2)
total_length = mid.length   # time length in seconds
tpb = mid.ticks_per_beat   # ticks per beat, tick is the smallest time unit
notemax = 127

# outports = mido.get_output_names()   # gets available output port names

note_msgs = []
tempo = 0   # in microseconds per beat
for i, track in enumerate(mid.tracks):
    for msg in track:
        print(msg)
        if msg.is_meta:
            if msg.type == 'set_tempo':
                tempo = msg.tempo
        if 'note' in msg.type:
            note_msgs.append(msg)

t2s = tempo*1e-6/tpb    # ticks to seconds conversion (ms/beat)(s/ms)(beat/tick)(tick) = (s)
t2us = tempo/tpb    # ticks to micro seconds conversion
notes = []
basetime = timestart_delay
channel = 0
# separates note on and off signals into note volume, length, pitch, and time
for n, msg in enumerate(note_msgs):     # iterate through all note messages

    if msg.channel != channel:
        basetime = timestart_delay
        channel = msg.channel
    basetime += msg.time    # time that note starts in ticks

    if msg.type == 'note_on':   # if the msg is to turn note on
        note_l = 0  # note length
        for n_, msg_ in enumerate(note_msgs[n+1:], n+1):
            note_l += msg_.time
            if msg_.note == msg.note and 'note' in msg_.type:
                note_p = msg.note   # note pitch
                note_v = msg.velocity   # note volume
                notes.append({'pitch': note_p, 'volume': note_v, 'length': note_l, 'time': basetime})
                break

notes.sort(key=lambda k: k['time'])

# write notes to a csv file
with open(outputfilename, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    for note in notes:
        p = str(note['pitch'])
        v = str(note['volume'])
        l = str(int(note['length'] * t2us))
        t = str(int(note['time'] * t2us))

        writer.writerow([p, v, l, t])

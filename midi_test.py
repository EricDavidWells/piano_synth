
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
tempodict = []   # in microseconds per beat
tempoticktotal = 0
timetotal = 0
for i, track in enumerate(mid.tracks):
    for j, msg in enumerate(track):
        if msg.is_meta:
            if msg.type == 'set_tempo':
                tempoticktotal += msg.time
                timetotal += msg.time[max(0, j-1)]*msg.tempo/tpb
                tempodict.append({'tempo': msg.tempo, 'tick': tempoticktotal, 'time': timetotal})
        if 'note' in msg.type:
            note_msgs.append(msg)

for x in tempodict:
    print(x)


# timemap = map(lambda x: x['tempodict']*x['time']/tpb)

# t2s = tempo*1e-6/tpb    # ticks to seconds conversion (ms/beat)(s/ms)(beat/tick)(tick) = (s)
# t2us = tempo/tpb    # ticks to micro seconds conversion

notes = []
totaltick = 0
totaltime = 0
channel = 0
# separates note on and off signals into note volume, length, pitch, and time
for n, msg in enumerate(note_msgs):     # iterate through all note messages

    if msg.channel != channel:
        totaltick = 0
        channel = msg.channel

    totaltick += msg.time    # time that note starts in ticks

    if msg.type == 'note_on':   # if the msg is to turn note on
        note_l = 0  # note length
        for n_, msg_ in enumerate(note_msgs[n+1:], n+1):
            note_l += msg_.time

            if msg_.note == msg.note and 'note' in msg_.type:
                note_p = msg.note   # note pitch
                note_v = msg.velocity   # note volume
                notes.append({'pitch': note_p, 'volume': note_v, 'length': note_l, 'time': totaltick})
                break

notes.sort(key=lambda k: k['time'])

# write notes to a csv file
with open(outputfilename, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    for note in notes:
        p = str(note['pitch'])
        v = str(note['volume'])

        index_1 = max([i for i, x in enumerate(tempodict) if x['tick'] < note['tick']])
        index_2 = max([i for i, x in enumerate(tempodict) if x['tick'] < note['tick'] + note['length']])

        if index_1 != index_2:
            ticks_1 = tempodict[index_1+1]['tick'] - note['tick']
            ticks_2 = note['tick'] + note['length'] - tempodict[index_2]['tick']

            time_1 = ticks_1 * tempodict[index_1]['tempo']
            time_2 = ticks_2 * tempodict[index_2['tempo']]

            start_time = tempodict[index_1 + 1]['time'] - time_1
            end_time = tempodict[index_2]['time'] + time_2

        else:
            start_time =

        l = str(int(note['length']))
        t = str(int(note['time']))

        writer.writerow([p, v, l, t])

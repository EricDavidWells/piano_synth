
import csv
import mido
from mido import MidiFile

midifilename = r'piano_synth\data\MidiFiles\mozart_2pianos_1.mid'
# midifilename = r'MidiFiles\fur_elise_by_beethoven.mid'
outputfilename = r'piano_synth\data\NoteFiles\mozart_2pianos_1.csv'


def music_track_index(mid):
    """
    finds the tracks in a midi file object that contain note messages

    :param mid: MidiFile object
    :return: list containing 0 if track contains no notes and 1 if it does
    """
    track_list = []

    for i, track in enumerate(mid.tracks):
        noteflag = 0
        for msg in track:
            if 'note' in msg.type:
                noteflag = 1
        track_list.append(noteflag)

    return track_list


# open a midi file
mid = MidiFile(midifilename)
type = mid.type     # midi file type (0, 1, or 2)
total_length = mid.length   # time length in seconds
tpb = mid.ticks_per_beat   # ticks per beat, tick is the smallest time unit
notemax = 127
# outports = mido.get_output_names()   # gets available output port names


tempodict = []   # dictionary holding tempo change message information
tempoticktotal = 0
timetotal = 0

# check which tracks contain note messages
notetracklist = music_track_index(mid)

# get all tempo changes and store in tempo list of dictionaries
for i, track in enumerate(mid.tracks):
    for j, msg in enumerate(track):
        print(msg)
        if msg.is_meta:
            if msg.type == 'set_tempo':
                tempoticktotal += msg.time
                timetotal += msg.time * msg.tempo / tpb
                tempodict.append({'tempo': msg.tempo, 'tick': tempoticktotal, 'time': timetotal})

notes = []  # list to store individual note dictionaries
totaltick = 0
totaltime = 0
channel = 0

# get all note messages and timing (in ticks) into the note list of dictionaries
for i, track in enumerate(mid.tracks):
    if notetracklist[i] == 0:   # skip track if it contains no note messages
        continue

    for j, msg in enumerate(track):
        if msg.is_meta:     # skip message if it is a meta message
            continue
        if msg.channel != channel:      # reset timer if the channel changes
            totaltick = 0
            channel = msg.channel

        totaltick += msg.time    # increment the time that note starts in ticks

        if msg.type == 'note_on' and msg.velocity != 0:   # if message is a note_on message
            note_l = 0  # note length
            for j_, msg_ in enumerate(track[j + 1:], j + 1):    # find next instance of note to calc parameters
                note_l += msg_.time
                if 'note' in msg_.type and msg_.note == msg.note:
                    note_p = msg.note  # note pitch
                    note_v = msg.velocity  # note volume
                    notes.append({'pitch': note_p, 'volume': note_v, 'length': note_l, 'tick': totaltick})
                    break

notes.sort(key=lambda k: k['tick'])     # sort notes just in case they are not in order

print(notes[-1]['tick'])
# write notes to a csv file
with open(outputfilename, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    for note in notes:
        p = str(note['pitch'])
        v = str(note['volume'])

        index_1 = max([i for i, x in enumerate(tempodict) if x['tick'] <= note['tick']])
        index_2 = max([i for i, x in enumerate(tempodict) if x['tick'] <= note['tick'] + note['length']])

        tempotick_1 = tempodict[index_1]['tick']
        tempotick_2 = tempodict[index_2]['tick']

        tempotime_1 = tempodict[index_1]['time']
        tempotime_2 = tempodict[index_2]['time']

        tempo_1 = tempodict[index_1]['tempo']
        tempo_2 = tempodict[index_2]['tempo']

        notetime_1 = tempotime_1 + (note['tick']-tempotick_1)*(tempo_1/tpb)
        notetime_2 = tempotime_2 + (note['tick'] + note['length'] - tempotick_2)*(tempo_2/tpb)

        l = str(notetime_2-notetime_1)
        t = str(notetime_1)

        writer.writerow([p, v, l, t])

# exec(open("piano_synth.pde").read(), globals())
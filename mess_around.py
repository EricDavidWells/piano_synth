
import bisect

note_tick1 = 205
note_tick2 = 455

tempodict = [{'tick': 100}, {'tick': 200}, {'tick': 200}, {'tick': 400}, {'tick': 450}]
b = [x['tick'] for x in tempodict]
# c = [x for x in b if x < value1]

index1 = max([i for i, x in enumerate(b) if x < note_tick1])
index2 = max([i for i, x in enumerate(tempodict) if x['tick'] < note_tick2])

tempo_tk1 = tempodict[index1]['tick']
tempo_tk3 = tempodict[index2]['tick']

if index1 != index2:

# print(a)
# print(b)
# print(c)
print(index1)
print(index2)

# string = 'note_off channel=0 note=48 velocity=95 time=240'
#
# string2 = string.split()
# # print(string2)
#
# for pos, string in enumerate(string2):
#     string = string.replace('_', '=')
#     string2[pos] = string.split('=')
#     print(string)

# print(string2)


# # seperates note on and off signals into note volume, length, pitch, and time
# for n, msg in enumerate(note_msgs):
#     if msg.type == 'note_on':
#         note_length = 0
#         note_pitch = msg.note
#         note_volume = msg.velocity
#         for n_, msg_ in enumerate(note_msgs[n+1:], n+1):
#             note_length += msg_.time
#             if msg_.note == msg.note and msg_.type == 'note_off':
#                 break
#
#         print(note_length)
#         # notes.append([note_length, note_pitch, note_volume])



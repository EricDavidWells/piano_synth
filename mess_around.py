
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
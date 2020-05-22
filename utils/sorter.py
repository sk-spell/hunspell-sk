#!/usr/bin/env python
'''
sorts stdin based on grammatical case, singular first.
secondary key is a condition to match (4th field of rule)

used to sort prefixes belonging to the same flag
in sk_sk.aff file

turns this:
 SFX D   ň           ne         [^á][lš]eň is:nominative is:plural
 SFX D   0           e          [^acďľňť] is:genitive
 SFX D   0           0          . is:accusative
 SFX D   ec          ci         ec is:dative

into this:
 SFX D   0           e          [^acďľňť] is:genitive
 SFX D   ec          ci         ec is:dative
 SFX D   0           0          . is:accusative
 SFX D   ň           ne         [^á][lš]eň is:nominative is:plural

to use with vim:
 - move to the first line of affix rule (right under header)
 - !} (in normal mode)
 - ./sorter.py

'''

import sys

order = ['nominative', 'genitive', 'dative', 'accusative', 'locative', 'instrumental']
input_text = []

def sort_func(key):
    for i in range(len(order)):
        if order[i] in key:
            if 'plural' in key:
                i += 10
            return (i, key.split()[4])
    return -1
  

for line in sys.stdin:
    line = line.rstrip()
    input_text.append(line)

input_text.sort(key=sort_func)
print('\n'.join(input_text))

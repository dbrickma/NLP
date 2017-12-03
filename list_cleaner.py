
from profanity_class import *

class listcleaner(object):

    def __init__(self):
        super(profanity_checker, self).__init__()

    #Removes stopwords from profanity list
    def stop_rid(self):
        self.proflst[:] = [[x for x in sub if x not in self.stopwords] for sub in self.proflst]
        return
    #Unlists list in another list
    def unlister(self):
        self.msglst = [x for i in self.msglst for x in i]
        return
    #splits strings and removes special characters from strings
    def strpsplt(self):
        self.proflst = [x.rstrip() for x in self.proflst]
        self.msglst = [x.rstrip() for x in self.msglst]
        self.msglst = [x.split(" ") for x in self.msglst]

        return
    #splits strings for profanity list
    def p_split(self):
        self.proflst = [x.split(" ") for x in [i for i in self.proflst]]
        return
    #combines sublists of profanity list by spaces
    def p_space(self):
        self.proflst = [' '.join(x) for x in self.proflst]
        return
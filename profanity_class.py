
from list_cleaner import listcleaner
from nltk.corpus import stopwords
class profanity_checker(listcleaner):
    def __init__(self):
        self.proflst = []
        self.clean_prof = []
        self.msglst = []
        self.stopwords = set(stopwords.words('english'))
        return
    #Reads profanity list
    def p_reader(self,filename):
        self.proflst = open(filename).readlines()
        return

    #Calls list_cleaner stopword remover for profanity checking process
    def p_cleaner(self):
        self.stop_rid()
        return
    def m_cleaner(self):
        self.stop_msg()

    #reads message
    def m_reader(self,filename):
        self.msglst = open(filename).readlines()
        return

    #splits based upon 'n' spaces and adds to the previous list
    def n_splitter(self,n):
        i = iter(self.msglst)
        self.msglst.append(list(map(" ".join, zip(*[i] * n))))
        return
    #determines if message contains profanity, then reveals to user what profanity words were used
    def p_checker(self):
        c = [i for i in self.msglst if i in self.proflst]
        a = []
        if c == a:
            print('No profanity')
        elif c != a:
            print("Profanity was: %s" %c)
        return

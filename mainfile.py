
from profanity_class import *
filedir = 'C:/Users/db234/Desktop/DataProjects/Dirty_Words/'
plist = 'profanity.txt'
message = 'message1.txt'
#message = 'nice_message.txt'
def main():
    pc = profanity_checker()
    pc.p_reader(filedir + plist)
    pc.m_reader(filedir + message)
    pc.strpsplt()
    pc.p_split()
    pc.unlister()
    for i in range(1, 4):
        pc.n_splitter(i)
    pc.p_cleaner()
    pc.p_space()
    pc.p_checker()




if __name__ == '__main__':
    main()
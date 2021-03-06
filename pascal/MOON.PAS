{ TheDraw Pascal Crunched Screen Image.  Date: 02/13/97 }
const
  MOON_WIDTH=80;
  MOON_DEPTH=25;
  MOON_LENGTH=1035;
  MOON : array [1..1035] of Char = (
     #5,#16,#26,#22,'�',#24,'�',#12,'�','�','�','�','�',' ','�','�','�',
    '�',' ','�','�','�','�',' ','�','�','�','�',' ', #5,'�',#25, #4,#10,
    'T','h','e',' ','h','u','m','b','l','e',' ','M','o','o','n',',',' ',
    'w','i','t','h',' ','i','t','s',' ','r','i','c','h','e','s',' ','o',
    'f',' ','m','i','n','e','r','a','l',' ','d','e','p','o','s','i','t',
    's',#24, #5,'�',#12,'�',' ','�',' ','�',' ','�',' ',' ','�',' ','�',
    ' ',' ','�',' ','�',' ',' ','�',' ', #5,'�',' ',' ',#10,'a','n','d',
    ' ','l','o','w',' ','g','r','a','v','i','t','y',',',' ','h','a','s',
    ' ','b','e','c','o','m','e',' ','a','n',' ','i','n','d','u','s','t',
    'r','i','a','l',' ','s','u','p','e','r','-','p','l','a','n','e','t',
    '.',#24, #5,'�',#12,'�',' ','�',' ','�',' ','�','�','�','�',' ','�',
    '�','�','�',' ','�',' ',' ','�',' ', #5,'�',#25, #5,#10,'M','i','n',
    'i','n','g',' ','a','n','d',' ','m','a','n','u','f','a','c','t','u',
    'r','i','n','g',' ','p','l','a','n','t','s',' ','h','a','v','e',' ',
    'b','e','e','n',' ','b','u','i','l','t',#24, #5,#26,#22,'�',#25, #3,
    #10,'i','n',' ','e','v','e','r','y',' ','p','o','s','s','i','b','l',
    'e',' ','p','l','a','c','e','.',' ',' ','W','e','a','p','o','n','s',
    ',',' ','s','p','a','c','e','c','r','a','f','t',' ','a','n','d',#24,
    #25,#12,'c','o','m','p','u','t','e','r','s',' ','a','r','e',' ','t',
    'h','e',' ','s','p','e','c','i','a','l','t','y',' ','i','n','d','u',
    's','t','r','i','e','s',' ','o','f',' ','t','h','e',' ','M','o','o',
    'n',' ','b','e','c','a','u','s','e',' ','i','t','s',#24,#25, #8,'l',
    'o','w',' ','g','r','a','v','i','t','y',' ','a','l','l','o','w','s',
    ' ','e','s','p','e','c','i','a','l','l','y',' ','p','r','o','d','u',
    'c','t','i','v','e',' ','m','e','t','h','o','d','s',' ','o','f',' ',
    'm','a','n','u','f','a','c','t','u','r','e',' ','t','o',' ','b','e',
    #24,#25,#14,'u','s','e','d',',',' ','a','n','d',' ','t','h','e','s',
    'e',' ','t','h','i','n','g','s',' ','a','r','e',' ','a','v','a','i',
    'l','a','b','l','e',' ','c','h','e','a','p',#14,'e','r',' ','h','e',
    'r','e',' ','t','h','a','n',' ','a','n','y','w','h','e','r','e','.',
    #24,#25, #2,#15,'�',#25,'.','�',#25, #8, #8,'�', #7,'�','�', #8,'�',
     #7,'�', #8,'�', #7,'�','�',#24,#25,#14,#15,'�',#25,#16,'�',#25,#26,
    '�',#25, #4, #8,'�', #7,'�','�',#24,#25,'C','�', #8,'�', #7,'�',#24,
    #25,#20,#15,'�',#25,#28, #7,'�',#25,#15, #8,'�','�','�',#24,#25, #9,
    #15,'�',#25,'3','�',#25, #3, #1,'�','�','�',#15,'�',#24,#25, #2, #7,
    '�',#25,'"',#15,'�',#25, #3, #7,'�',#25,#22,#14,'�','�','�',#24,#25,
    #10,#15,'�',' ', #7,'�',#25,#17,'�',#25,#18,'�',#25, #8,'�',#25, #3,
     #1,'�','�','�','�','�',#24,#25,#12,#15,'�',#25,'3',#14,'�','�','�',
    '�','�','�','�',#26, #6,'�',#24,#25, #6, #7,'�',#25,#15, #8,'�',#25,
    #10,#15,'�',' ','�',#25,#26, #1,'�','�','�','�','�','�','�',#14,'�',
    '�',' ','�','�',' ','�',#24,#25,#22, #8,'�','�','�',#25,#23,#15,'�',
    #25, #6, #8,'�',#25, #5,#15,'�',#14,'�','�','�','�','�','�','�',#26,
     #6,'�',#24,#25, #9, #7,'�',#25,#10, #8,'�',#26, #3,'�',#25,#29,'�',
    '�','�',#25, #5, #1,'�','�','�','�','�','�','�',#14,'�','�',' ','�',
    '�',' ','�',#24,#25, #2, #8,'�',#25,#15,'�',#26, #6,'�','�',#25, #8,
    '�',#25,#15,'�',#26, #4,'�',#25, #4,#14,'�','�','�','�','�','�','�',
    #26, #6,'�',#24,#25, #2, #8,'�','�',#25,#10,'�',#26,#14,'�','�',#25,
     #2,'�',#26, #3,'�','�',#25, #7,'�',#26,#10,'�','�',#25, #2, #1,'�',
    '�','�','�','�','�','�',#14,'�','�',' ','�','�',' ','�',#24,' ',' ',
     #8,#26, #3,'�','�',#25, #6,#26,#28,'�','�','�','�',#26, #5,'�',#23,
    #26,#12,'�',#16,' ',#14,'�','�','�','�','�','�','�',#26, #6,'�',#24,
     #8,'�',#26, #5,'�','�',' ',' ','�',#23,'�', #7,#16,'�', #8,#26,#27,
    '�', #7,'�','�', #8,#23,'�',#26, #3,'�',#16,#26, #3,'�',#23,#26, #9,
    '�','�','�', #7,#16,#26,#15,'�',#24, #8,'�',#23,'�','�','�', #7,#16,
    '�', #8,#23,'�',#26, #3,'�','�', #7,#16,'�','�', #8,#23,'�','�','�',
    #16,#26, #8,'�',#23,'�','�', #7,#16,'�', #8,#23,'�','�','�',#16,#26,
     #8,'�',#23,'�', #7,#16,#26, #4,'�', #8,#23,'�','�',#16,#26, #3,'�',
    #23,#26, #4,'�','�','�','�', #7,#16,#26,#19,'�',#24, #8,'�',#23,'�',
     #7,#16,#26,#12,'�', #8,#23,'�',#16,#26, #8,'�',#23,'�', #7,#16,'�',
    '�',#23,' ', #8,'�','�','�',#16,#26, #7,'�', #7,#26, #6,'�', #8,#23,
    '�',#16,#26, #3,'�',#23,'�','�','�', #7,#16,#26,#24,'�',#24);

{ TheDraw Pascal Crunched Screen Image.  Date: 02/13/97 }
const
  SHOP_WIDTH=80;
  SHOP_DEPTH=25;
  SHOP_LENGTH=783;
  SHOP : array [1..783] of Char = (
    #15,#20,'�',#26,'(','�','�',#24,'�', #1,#16,'�','�', #7,#17,'�','�',
    '�', #1,#16,'�', #7,#17,'�', #1,#16,'�','�', #7,#17,'�', #1,#16,'�',
     #7,#17,'�','�','�','�', #1,#16,'�', #7,#17,'�','�','�','�', #1,#16,
    '�', #7,#17,'�', #1,#16,#26, #3,'�', #7,#17,'�','�','�', #1,#16,'�',
     #7,#17,'�','�','�','�', #1,#16,'�','�', #7,#17,'�','�','�', #1,#16,
    '�','�',#15,#20,'�',#24,'�', #1,#16,'�','�', #7,#17,'�','�','�', #1,
    #16,'�', #7,#17,'�', #1,#16,'�','�', #7,#17,'�', #1,#16,'�', #7,#17,
    '�','�','�','�', #1,#16,'�', #7,#17,'�','�','�','�', #1,#16,'�', #7,
    #17,'�', #1,#16,#26, #4,'�', #7,#17,'�', #1,#16,'�','�', #7,#17,'�',
    '�', #1,#16,#26, #3,'�', #7,#17,'�','�','�', #1,#16,'�','�',#15,#20,
    '�',#24,'�', #1,#16,'�', #7,#17,'�','�','�','�', #1,#16,'�', #7,#17,
    '�','�','�','�', #1,#16,'�', #7,#17,'�', #1,#16,#26, #3,'�', #7,#17,
    '�', #1,#16,#26, #3,'�', #7,#17,'�','�','�','�', #1,#16,'�', #7,#17,
    '�','�','�', #1,#16,'�', #7,#17,'�','�','�','�', #1,#16,'�', #7,#17,
    '�','�','�','�', #1,#16,'�','�',#15,#20,'�',#24,'�',#26,'(','�','�',
    #24, #6,#16,'�',#25,'(','�',#24,'�',' ', #7,'�', #8,#22,'�', #7,#16,
    '�',#25, #2, #8,'�',#18,'�',#16,'�',' ',' ','�',#17,'�',#16,'�',#25,
     #3, #7,'�', #8,#22,'�', #7,#16,'�',#25, #2, #8,'�',#18,'�',#16,'�',
    ' ',' ','�',#17,'�',#16,'�',#25, #2, #7,'�', #8,#22,'�', #7,#16,'�',
    ' ',' ', #6,'�',#24,'�',' ', #7,#22,'�',' ','�',#16,#25, #2, #8,#18,
    '�',' ','�',#16,' ',' ',#17,'�',' ','�',#16,#25, #3, #7,#22,'�',' ',
    '�',#16,#25, #2, #8,#18,'�',' ','�',#16,' ',' ',#17,'�',' ','�',#16,
    #25, #2, #7,#22,'�',' ','�',#16,' ',' ', #6,'�',#24,'�',#26,'(','�',
    '�',#24,'�',#25, #3, #8,'�',#17,'�',#16,'�',#25, #3, #7,'�', #8,#22,
    '�', #7,#16,'�',#25, #2, #8,'�',#18,'�',#16,'�',' ',' ','�',#17,'�',
    #16,'�',#25, #3, #7,'�', #8,#22,'�', #7,#16,'�',#25, #2, #8,'�',#18,
    '�',#16,'�',#25, #2, #6,'�',#24,'�',#25, #3, #8,#17,'�',' ','�',#16,
    #25, #3, #7,#22,'�',' ','�',#16,#25, #2, #8,#18,'�',' ','�',#16,' ',
    ' ',#17,'�',' ','�',#16,#25, #3, #7,#22,'�',' ','�',#16,#25, #2, #8,
    #18,'�',' ','�',#16,#25, #2, #6,'�',#24,#26,'*','�',#24,#25, #5, #8,
    #26, #5,'�',#24,#25, #4,'�','�',#15,#26, #3,'�', #8,'�','�',#24,#25,
     #3,#26, #9,'�',#24,#25, #3,#26, #9,'�',#24,#25, #3,#26, #9,'�',#24,
    #15,#17,#26,',','�',#24,#16,' ',' ', #6,'�','�','�',#25, #8,'�','�',
    '�',#25, #8,'�','�','�',#25, #8,'�','�','�',#24,' ',' ','�','�','�',
    '�',#25, #5,'�',#26, #3,'�','�',#25, #5,'�',#26, #3,'�','�',#25, #5,
    '�',#26, #3,'�',#24,' ',' ',#26, #4,'�','�',' ',' ','�','�','�','�',
    #26, #4,'�','�',' ',' ','�','�','�','�',#26, #4,'�','�',' ',' ','�',
    '�','�','�','�','�','�',#24,' ',' ','�','�','�',' ','�',#26, #3,'�',
    '�',' ',' ','�','�','�',' ','�',#26, #3,'�','�',' ',' ','�','�','�',
    ' ','�',#26, #3,'�','�',' ',' ','�','�','�',#24,' ',' ','�','�','�',
    ' ','�',#26, #3,'�','�',' ',' ','�','�','�',' ','�',#26, #3,'�','�',
    ' ',' ','�','�','�',' ','�',#26, #3,'�','�',' ',' ','�','�','�',#24,
    ' ',' ','�','�','�','�','�','�',' ',' ','�','�','�','�','�','�','�',
    '�','�','�',' ',' ','�','�','�','�','�','�','�','�','�','�',' ',' ',
    '�','�','�','�','�','�','�',#24,' ',' ','�','�','�','�',#25, #5,'�',
    #26, #3,'�','�',#25, #5,'�',#26, #3,'�','�',#25, #5,'�',#26, #3,'�',
    #24);

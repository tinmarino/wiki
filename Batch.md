:: calculate x^n
SET x=3 
SET n=5 
SET result=1 
FOR /L %%i IN (1,1,%n%) DO SET /A result*=x 
ECHO %result% 

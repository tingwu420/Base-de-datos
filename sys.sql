CREATE USER practica1 IDENTIFIED BY febrero04
       DEFAULT TABLESPACE users  
       TEMPORARY TABLESPACE temp
       QUOTA UNLIMITED ON users;

GRANT DBA TO practica6;

ALTER USER hr IDENTIFIED BY hr ACCOUNT UNLOCK;
/*
  2023-06-07 16:30
  �û�: FxDr
  ������: FXX-LEGION
  ���ݿ�: OS
  Ӧ�ó���: OS 
*/
CREATE TABLE Message
(
    id        INT IDENTITY(1,1) PRIMARY KEY,
    sender    VARCHAR(255) NOT NULL,
    receiver  VARCHAR(255) NOT NULL,
    message   TEXT         NOT NULL,
    timestamp DATETIME DEFAULT GETDATE()
);

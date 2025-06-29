--  Create tables
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    Balance NUMBER(10, 2),
    AccountType VARCHAR2(20)
);

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Employees (
    EmpID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Department VARCHAR2(50),
    Salary NUMBER(10, 2)
);

-- Insert sample data
INSERT INTO Accounts VALUES (1, 'Alice', 1000.00, 'savings');
INSERT INTO Accounts VALUES (2, 'Bob', 2000.00, 'savings');
INSERT INTO Accounts VALUES (3, 'Charlie', 500.00, 'checking');

INSERT INTO Employees VALUES (101, 'Jane', 'IT', 50000.00);
INSERT INTO Employees VALUES (102, 'Mark', 'HR', 45000.00);
INSERT INTO Employees VALUES (103, 'Sara', 'IT', 52000.00);

COMMIT;

-- Procedure to process monthly interest
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountType = 'savings';
END;
/

-- Procedure to update employee bonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    deptName IN VARCHAR2,
    bonusPercent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonusPercent / 100)
    WHERE Department = deptName;
END;
/

-- Procedure to transfer funds
CREATE OR REPLACE PROCEDURE TransferFunds (
    fromAcc IN NUMBER,
    toAcc IN NUMBER,
    amount IN NUMBER
) AS
    fromBalance NUMBER;
BEGIN
    SELECT Balance INTO fromBalance
    FROM Accounts
    WHERE AccountID = fromAcc;

    IF fromBalance >= amount THEN
        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = fromAcc;

        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = toAcc;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance for transfer');
    END IF;
END;
/

-- Test procedure calls
BEGIN
  ProcessMonthlyInterest;
  UpdateEmployeeBonus('IT', 10);
  TransferFunds(1, 2, 300);
END;
/

-- View updated data
SELECT * FROM Accounts;
SELECT * FROM Employees;

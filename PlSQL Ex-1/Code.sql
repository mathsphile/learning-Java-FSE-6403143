-- Enable output
SET SERVEROUTPUT ON;

-- Drop tables if they already exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE loans';
  EXECUTE IMMEDIATE 'DROP TABLE customers';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Create customers table
CREATE TABLE customers (
  customer_id NUMBER,
  name VARCHAR2(100),
  age NUMBER,
  loan_interest NUMBER,
  balance NUMBER,
  isVIP VARCHAR2(5)
);

-- Insert dummy data
INSERT INTO customers VALUES (1, 'Nandini', 65, 7.5, 12000, 'FALSE');
INSERT INTO customers VALUES (2, 'Amit', 45, 8.2, 9500, 'FALSE');
INSERT INTO customers VALUES (3, 'Priya', 70, 6.9, 15000, 'FALSE');

-- Create loans table
CREATE TABLE loans (
  loan_id NUMBER,
  customer_id NUMBER,
  due_date DATE
);

-- Insert dummy loans
INSERT INTO loans VALUES (1, 1, SYSDATE + 10);
INSERT INTO loans VALUES (2, 2, SYSDATE + 40);
INSERT INTO loans VALUES (3, 3, SYSDATE + 25);

-- Scenario 1: Apply 1% interest discount for age > 60
BEGIN
  FOR cust IN (SELECT * FROM customers) LOOP
    IF cust.age > 60 THEN
      UPDATE customers
      SET loan_interest = loan_interest - 1
      WHERE customer_id = cust.customer_id;
    END IF;
  END LOOP;
END;
/

-- Scenario 2: Set IsVIP to TRUE for balance > 10000
BEGIN
  FOR cust IN (SELECT * FROM customers) LOOP
    IF cust.balance > 10000 THEN
      UPDATE customers
      SET isVIP = 'TRUE'
      WHERE customer_id = cust.customer_id;
    END IF;
  END LOOP;
END;
/

-- Scenario 3: Print reminders for loans due in next 30 days
BEGIN
  FOR loan IN (
    SELECT * FROM loans
    WHERE due_date BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DECLARE
      cust_name VARCHAR2(100);
    BEGIN
      SELECT name INTO cust_name
      FROM customers
      WHERE customer_id = loan.customer_id;

      DBMS_OUTPUT.PUT_LINE('Reminder: Loan due soon for customer ' || cust_name);
    END;
  END LOOP;
END;
/

-- Show final customer table
BEGIN
  FOR rec IN (SELECT * FROM customers) LOOP
    DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.name || ', Interest: ' || rec.loan_interest || ', VIP: ' || rec.isVIP);
  END LOOP;
END;
/

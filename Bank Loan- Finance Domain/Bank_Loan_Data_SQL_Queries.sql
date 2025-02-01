---TO check the data imported correctly---
select*from Bank_Loan_Data

---total loan applications---
select COUNT(id) as Total_Loan_Applications from Bank_Loan_Data

---Month to date loan applications---
select COUNT(id) as MTD_Loan_Applications from Bank_Loan_Data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

---Per Month to date loan applications---
select COUNT(id) as PMTD_Loan_Applications from Bank_Loan_Data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

---Total funded amount
select sum(loan_amount) as Total_Funded_Amount from Bank_Loan_Data

--- Month to date total funded amount
select sum(loan_amount) as MTD_Total_Funded_Amount from Bank_Loan_Data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--- Per Month to date total funded amount
select sum(loan_amount) as PMTD_Total_Funded_Amount from Bank_Loan_Data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

---Total Amount Received
select sum(total_payment) as Total_Amount_Received from Bank_Loan_Data

--- Month to date Total Amount Received
select sum(total_payment) as MTD_Total_Amount_Received from Bank_Loan_Data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

--- Per Month to date Total Amount Received
select sum(total_payment) as PMTD_Total_Amount_Received from Bank_Loan_Data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

--- Average Interest Rate
select round(avg(int_rate),2)*100 as Average_Interest_Rate from Bank_Loan_Data

---Month to date Average Interest Rate
select round(avg(int_rate),4)*100 as MTD_Average_Interest_Rate from Bank_Loan_Data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

---Per Month to date Average Interest Rate
select round(avg(int_rate),4)*100  as PMTD_Average_Interest_Rate from Bank_Loan_Data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

---Average DTI
select round(avg(dti),3)*100 as Average_DTI from Bank_Loan_Data

---Month to date Average DTI
select round(avg(dti),3)*100 as MTD_Average_DTI from Bank_Loan_Data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

---Month to date Average DTI
select round(avg(dti),3)*100 as PMTD_Average_DTI from Bank_Loan_Data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

--- Checking the details of loan status
select loan_status from Bank_Loan_Data

--- Good_Loan_Percentage
select 
(count(case when loan_status = 'Fully Paid' OR loan_status = 'Current' Then id END)*100)
/ 
COUNT(id) AS Good_Loan_Percentage
From Bank_Loan_Data

---Good_Loan_Application
select count(id) AS Good_Loan_Applications  from Bank_Loan_Data
where loan_status = 'Fully Paid' OR loan_status = 'Current'

---Good Loan Funded Amount
select sum(loan_amount) as Good_Loan_Funded_Amount from Bank_Loan_Data
where loan_status = 'Fully Paid' OR loan_status = 'Current'

--- Good Loan Received Amount
select sum(total_payment) as Good_Loan_Received_Amount from Bank_Loan_Data
where loan_status = 'Fully Paid' OR loan_status = 'Current'

---Bad Loan Percentage
select 
(count(case when loan_status = 'Charged Off' Then id END)*100.0)
/ 
COUNT(id) AS Bad_Loan_Percentage
From Bank_Loan_Data

---Bad Loan Applications
select count(id) As Bad_Loan_Applications from Bank_Loan_Data
where loan_status = 'Charged off'

---Bad Loan Funded Amount
select sum(loan_amount) as Bad_Loan_Funded_Amount from Bank_Loan_Data
where loan_status = 'Charged Off'

---Bad Loan Amount Received
select sum(total_payment) as Bad_Loan_Received_Amount from Bank_Loan_Data
where loan_status = 'Charged Off'

---Loan Status
select
 loan_status,
 COUNT(id) AS Total_Loan_Applications,
 sum(total_payment) AS Total_Amount_Received,
 sum(loan_amount) AS Total_Funded_Amount,
 AVG(int_rate*100)As Interest_Rate,
 avg(dti*100) AS DTI
 From
 Bank_Loan_Data
 Group BY
 loan_status

 --- Month to date Loan Status
 select
 loan_status,
 SUM(total_payment) as MTD_Total_Amount_Received,
 SUM(loan_amount) as MTD_Funded_Amount
 From Bank_Loan_Data
 where MONTH(issue_date) = 12
 group by loan_status

 --- Monthly Trends by issue date
 select
 MONTH(issue_date)As Month_Number,
 datename(MONTH,issue_date) AS Month_Name,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by  MONTH(issue_date),datename(MONTH,issue_date)
 order by MONTH(issue_date)
 
 ---Regional Analysis by state
select
 address_state,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by address_state
 order by address_state

 ---Loan Term Analysis
 select
 term,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by term
 order by term

 ---Employee Length Analysis
 select
 purpose,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by  purpose
 order by purpose

 ---Loan Purpose Breakdown
 select
 purpose,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by  purpose
 order by purpose

 ---Home Ownership Analysis 
 select
 home_ownership,
 count(id) AS Total_Loan_Application,
 sum(loan_amount) As Total_Funded_Amount,
 sum(total_payment) As Total_Received_Amount
 from bank_loan_data
 group by home_ownership
 order by  home_ownership
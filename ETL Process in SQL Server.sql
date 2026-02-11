-- Data Exploration – Check Distinct Values.
select Gender , count(Gender) as Totalcount,
count(Gender) * 100.0 / (select count(*) from stg_churn) as Percentage
from stg_churn
group by Gender;

select Customer_Status , count(Customer_Status) as TotalCount,
sum(Total_Revenue) / (select sum(Total_Revenue) from stg_churn) * 100.0 as RevPercentage
from stg_churn
group by Customer_Status;

select Contract , count(Contract) as TotalCount,
count(Contract) * 100.0 / (select count(*) from stg_churn)  as Percentage
from stg_churn
group by Contract;

select State , count(State) as TotalCount,
count(State) * 100.0 / (select count(*) from stg_churn) as Percentage
from stg_churn
group by State
order by Percentage desc;

-- Data Exploration – Check Nulls
SELECT
    SUM(CASE WHEN Customer_ID IS NULL OR Customer_ID = '' THEN 1 ELSE 0 END) AS customer_id_null_count,
    SUM(CASE WHEN Gender IS NULL OR Gender = '' THEN 1 ELSE 0 END) AS gender_null_count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS age_null_count,
    SUM(CASE WHEN Married IS NULL OR Married = '' THEN 1 ELSE 0 END) AS married_null_count,
    SUM(CASE WHEN State IS NULL OR State = '' THEN 1 ELSE 0 END) AS state_null_count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_referrals_null_count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS tenure_in_months_null_count,
    SUM(CASE WHEN Value_Deal IS NULL OR Value_Deal = '' THEN 1 ELSE 0 END) AS value_deal_null_count,
    SUM(CASE WHEN Phone_Service IS NULL OR Phone_Service = '' THEN 1 ELSE 0 END) AS phone_service_null_values,
    SUM(CASE WHEN Multiple_Lines IS NULL OR Multiple_Lines = '' THEN 1 ELSE 0 END) AS multiple_lines_null_values,
    SUM(CASE WHEN Internet_Service IS NULL OR Internet_Service = '' THEN 1 ELSE 0 END) AS internet_service_null_values,
    SUM(CASE WHEN Internet_Type IS NULL OR Internet_Type = '' THEN 1 ELSE 0 END) AS internet_type_null_values,
    SUM(CASE WHEN Online_Security IS NULL OR Online_Security = '' THEN 1 ELSE 0 END) AS online_security_null_values,
    SUM(CASE WHEN Online_Backup IS NULL OR Online_Backup = '' THEN 1 ELSE 0 END) AS online_backup_null_values,
    SUM(CASE WHEN Device_Protection_Plan IS NULL OR Device_Protection_Plan = '' THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL OR Premium_Support = '' THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL OR Streaming_TV = '' THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL OR Streaming_Movies = '' THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL OR Streaming_Music = '' THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL OR Unlimited_Data = '' THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL OR Contract = '' THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL OR Paperless_Billing = '' THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL OR Payment_Method = '' THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL OR Customer_Status = '' THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL OR Churn_Category = '' THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL OR Churn_Reason = '' THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM stg_churn;

-- Remove null and insert the new data into Prod table.
DROP TABLE IF EXISTS chrun.prod_churn;

CREATE TABLE chrun.prod_churn AS
SELECT 
  Customer_ID,
  Gender,
  Age,
  Married,
  State,
  Number_of_Referrals,
  Tenure_in_Months,
  COALESCE(NULLIF(TRIM(Value_Deal), ''), 'None') AS Value_Deal,
  Phone_Service,
  COALESCE(NULLIF(TRIM(Multiple_Lines), ''), 'No') AS Multiple_Lines,
  Internet_Service,
  COALESCE(NULLIF(TRIM(Internet_Type), ''), 'None') AS Internet_Type,
  COALESCE(NULLIF(TRIM(Online_Security), ''), 'No') AS Online_Security,
  COALESCE(NULLIF(TRIM(Online_Backup), ''), 'No') AS Online_Backup,
  COALESCE(NULLIF(TRIM(Device_Protection_Plan), ''), 'No') AS Device_Protection_Plan,
  COALESCE(NULLIF(TRIM(Premium_Support), ''), 'No') AS Premium_Support,
  COALESCE(NULLIF(TRIM(Streaming_TV), ''), 'No') AS Streaming_TV,
  COALESCE(NULLIF(TRIM(Streaming_Movies), ''), 'No') AS Streaming_Movies,
  COALESCE(NULLIF(TRIM(Streaming_Music), ''), 'No') AS Streaming_Music,
  COALESCE(NULLIF(TRIM(Unlimited_Data), ''), 'No') AS Unlimited_Data,
  Contract,
  Paperless_Billing,
  Payment_Method,
  Monthly_Charge,
  Total_Charges,
  Total_Refunds,
  Total_Extra_Data_Charges,
  Total_Long_Distance_Charges,
  Total_Revenue,
  Customer_Status,
  COALESCE(NULLIF(TRIM(Churn_Category), ''), 'Others') AS Churn_Category,
  COALESCE(NULLIF(TRIM(Churn_Reason), ''), 'Others') AS Churn_Reason
FROM chrun.stg_churn;

-- Create View for Power BI.
create view vw_churndata as 
select * from prod_churn where Customer_Status in ('churned','stayed');

create view vw_joindata as
select * from prod_churn where Customer_Status = 'joined';
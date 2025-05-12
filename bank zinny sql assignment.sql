CREATE TABLE bank_data (
    age INT,
    job VARCHAR(50),
    marital VARCHAR(20),
    education VARCHAR(30),
    def VARCHAR(10),
    balance INT,
    housing VARCHAR(10),
    loan VARCHAR(10),
    contact VARCHAR(20),
    day INT,
    month VARCHAR(10),
    duration INT,
    campaign INT,
    pdays INT,
    previous INT,
    poutcome VARCHAR(20),
    y VARCHAR(10)
);


-- Total number of records
SELECT COUNT(*) AS total_records FROM bank_data;

-- Count of target variable
SELECT y, COUNT(*) AS count FROM bank_data GROUP BY y;

-- Age distribution buckets
SELECT 
  CASE 
    WHEN age < 30 THEN 'Under 30'
    WHEN age BETWEEN 30 AND 39 THEN '30s'
    WHEN age BETWEEN 40 AND 49 THEN '40s'
    WHEN age BETWEEN 50 AND 59 THEN '50s'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS total,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribed
FROM bank_data
GROUP BY age_group;

SELECT 
  job,
  COUNT(*) AS total_contacts,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
  ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS subscription_rate
FROM bank_data
GROUP BY job
ORDER BY subscription_rate DESC;

-- Average balance for subscribers vs non-subscribers
SELECT 
  y,
  COUNT(*) AS total,
  AVG(balance) AS avg_balance,
  MIN(balance) AS min_balance,
  MAX(balance) AS max_balance
FROM bank_data
GROUP BY y;

-- Housing loan impact
SELECT housing, y, COUNT(*) AS count
FROM bank_data
GROUP BY housing, y;

-- Personal loan impact
SELECT loan, y, COUNT(*) AS count
FROM bank_data
GROUP BY loan, y;

SELECT 
  contact,
  COUNT(*) AS total_contacts,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions,
  ROUND(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS subscription_rate
FROM bank_data
GROUP BY contact;

-- Monthly performance
SELECT 
  month,
  COUNT(*) AS total_contacts,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions
FROM bank_data
GROUP BY month
ORDER BY FIELD(month, 'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec');

-- Effect of number of contacts (campaign) on subscription
SELECT 
  campaign,
  COUNT(*) AS total,
  SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions
FROM bank_data
GROUP BY campaign
ORDER BY campaign;







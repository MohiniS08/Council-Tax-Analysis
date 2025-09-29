CREATE DATABASE council;
USE council;

CREATE TABLE council_tax (
year INT,
region VARCHAR(50),
local_authority VARCHAR(100),
amount_collected_millionGBP DECIMAL(10,2),
requirement_millionGBP DECIMAL(10,2),
avg_bandD_GBP DECIMAL(10,2)
);


-- 1. Collection Rate per Authority per Year
SELECT 
    Local_Authority,
    Year,
    Amount_Collected_MillionGBP,
    Requirement_MillionGBP,
    (Amount_Collected_MillionGBP / Requirement_MillionGBP * 100) AS Collection_Rate_Percent
FROM council_tax
ORDER BY Year, Local_Authority;



-- 2. Total Collection & Average Band D by Year
SELECT 
    Year,
    SUM(Amount_Collected_MillionGBP) AS Total_Collected,
    SUM(Requirement_MillionGBP) AS Total_Requirement,
    AVG(Avg_BandD_GBP) AS Avg_BandD
FROM council_tax
GROUP BY Year
ORDER BY Year;



-- 3. Top 5 Authorities by Collection Rate
SELECT 
    Local_Authority,
    AVG(Amount_Collected_MillionGBP / Requirement_MillionGBP * 100) AS Avg_Collection_Rate
FROM council_tax
GROUP BY Local_Authority
ORDER BY Avg_Collection_Rate DESC
LIMIT 5;



-- 4. Regional Average Collection Rate
SELECT 
    Region,
    AVG(Amount_Collected_MillionGBP / Requirement_MillionGBP * 100) AS Avg_Collection_Rate
FROM council_tax
GROUP BY Region
ORDER BY Avg_Collection_Rate DESC;



-- 5. Collection Gap (Requirement – Collected)
SELECT 
    Local_Authority,
    Year,
    Requirement_MillionGBP - Amount_Collected_MillionGBP AS Collection_Gap
FROM council_tax
ORDER BY Year, Collection_Gap DESC;



-- 6. Correlation Between Avg Band D and Collection Rate
SELECT 
    Local_Authority,
    AVG(Avg_BandD_GBP) AS Avg_BandD,
    AVG(Amount_Collected_MillionGBP / Requirement_MillionGBP * 100) AS Avg_Collection_Rate
FROM council_tax
GROUP BY Local_Authority
ORDER BY Avg_BandD;

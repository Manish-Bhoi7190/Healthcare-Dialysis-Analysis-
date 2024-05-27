create database healthcare_project;
use healthcare_project;
show tables;
SELECT * FROM dialysisdata;
SELECT * FROM dialysis2new;



# 1. Number of patients across various summaries

select sum(transfusionsummary) as total_transfusion_patients,
sum(hypercalcemiasummary) as total_hypercalcemia_patients,
sum(Serumphosphorussummary) as total_serum_phosphorus_patients,
sum(hospitalizationsummary) as total_hospitalization_patients,
sum(survivalsummary) as total_survival_patients,
sum(fistulasummary) as total_fistula_patients,
sum(longtermcathetersummary) as total_long_term_catheter_patients,
sum(nPCRsummary) as total_nPCR_patients
from dialysisdata;


# 2. Profit VS Non-Profit stats

select 
sum(case when ProfitorNonProfit = 'Profit' then 1 else 0 end) as profit_count,
sum(case when ProfitorNonProfit = 'Non-Profit' then 1 else 0 end) as non_profit_count
from dialysisdata;
# OR
select ProfitorNonProfit, count(ProviderNumber) from dialysisdata
group by ProfitorNonProfit;


# 3. Chain Organization W.r.t. Total Performance Score as No Score

select ChainOrganization,count(TotalPerformanceScore = 'No Score') as totalperformancescore_as_No_score
from dialysisdata as DD join dialysis2new D2
on DD.FacilityName = D2.FacilityName
group by ChainOrganization;


# 4. Dialysis station stats

select 
sum(DialysisStations) as total_dialysis_stations
from dialysisdata;


# 5. # of Category Text -As Expected

select
count(case when PatientTransfusioncategorytext = 'As Expected' then 1 end) as transfusion_count,
count(case when Patienthospitalizationcategorytext = 'As Expected' then 1 end) as hospitalization_count,
count(case when PatientHospitalReadmissionCategory = 'As Expected' then 1 end) as hospital_readmission_count,
count(case when PatientSurvivalCategoryText = 'As Expected' then 1 end) as survival_count,
count(case when PatientInfectioncategorytext = 'As Expected' then 1 end) as infection_count,
count(case when FistulaCategoryText = 'As Expected' then 1 end) as fistula_count,
count(case when SWRcategorytext = 'As Expected' then 1 end) as SWR_count,
count(case when PPPWcategorytext = 'As Expected' then 1 end) as PPPW_count
from dialysisdata;


# 6. Average Payment Reduction Rate

select avg(cast(PY2020PaymentReductionPercentage as decimal(5,5))) as average_percentage
from dialysis2new
where PY2020PaymentReductionPercentage != 'No Reduction';

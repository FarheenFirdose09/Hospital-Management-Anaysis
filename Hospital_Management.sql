create database hospital;

use hospital;

select * from Hospital_Management;

# patients admitted after a specific date
select PatientName, AdmissionDate
from hospital_management
where AdmissionDate > '2024-01-01';

# patients who required surgery
select PatientName,SurgeryRequired,SurgeryDate
from hospital_management
where SurgeryRequired = 'Yes';

# patients with pending payment
select PatientName,PendingAmount
from hospital_management
where PendingAmount > 0;

# Total bill, paid amount, and pending amount
select PatientName, TotalBillAmount,AmountPaid,PendingAmount
from hospital_management;

# Total revenue collected by hospital
select sum(AmountPaid) as Total_Revenue
from hospital_management;

# Average consultation fee
select avg(ConsultationFee) as avg_consultation_fee
from hospital_management;

# Feedback rating above 4
select PatientName,FeedbackRating
from hospital_management
where FeedbackRating > 4;

#1 Total Patients(card)
select count(Distinct PatientId) as Total_patient
from hospital_management;

#2 Average Age of Patients(card)
select round(avg(age),2) as AvgAge
from hospital_management;

#3 Total Doctors(card)
select Count(Distinct DoctorName) as TotalDoctors
from hospital_management;

#4 Doctors by Specialization(bar chart)
select Specialization,count(Distinct DoctorName) as DoctorCount
from hospital_management
group by Specialization
order by DoctorCount desc;

#5 Department-wise Patients(disease by patient)
select Department,count(PatientId) as TotalPatients
from hospital_management
group by Department
order by TotalPatients desc;

#6 Total Bill Amount
select sum(TotalBillAmount) as TotalBillAmount
from hospital_management;

#7 Total Amount Paid (card)
select sum(AmountPaid) as AmountPaid
from hospital_management;

#8 Total Amount pending(card)
select sum(AmountPending) as AmountPending
from hospital_management;

#9 Payment Mode wise amount (donut chart)
select PaymentMode,sum(TotalBillAmount) as TotalAmount
from hospital_management
group by PaymentMode;

#10 State-wise Paid vs Pending Amount(stacked chart)
select State, sum(AmountPaid)as PaidAmount,sum(PendingAmount) as PendingAmount
from hospital_management
group by State;

# Rank doctors by number of patients(window Function)
select
DoctorName, count(PatientId) as TotalPatients,
rank() over (order by count(PatientId) desc) as DoctorRank
from hospital_management
group by DoctorName;

# Running total of hospital Revenue(Analytics)
select BillingDate,
sum(AmountPaid) as DailyRevenue,
sum(sum(AmountPaid)) over (order by BillingDate) as RunningRevenue
from hospital_management
group by BillingDate;

# Patients whose bill is above hospital average
select 
    PatientName,TotalBillAmount
from hospital_management
where TotalBillAmount > (
	select avg(TotalBillAmount)
	from hospital_management);
    
# 
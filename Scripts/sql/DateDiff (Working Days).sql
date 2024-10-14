Declare @StartDate DateTime = '20241220';
Declare @EndDate DateTime = '20250105';
SELECT @StartDate startDate, @EndDate endDate, 
DATEPART(WEEK, @StartDate),
(DATEDIFF(YEAR, @StartDate, @EndDate) * 51) + DATEPART(WEEK, @EndDate),
DATEPART(WEEK, @EndDate) , DATEPART(WEEK, @StartDate),
DATEDIFF(DAY, @StartDate, @EndDate) - 
(
    ((DATEPART(WEEK, @EndDate) - DATEPART(WEEK, @StartDate)) * 2) + 
    IIF(DATEPART(WEEKDAY, @StartDate)=1, 1, 0) + 
    IIF(DATEPART(WEEKDAY, @EndDate)=7, 1, 0) 
) + 
IIF(DATEPART(WEEKDAY, @EndDate)=7 OR DATEPART(WEEKDAY, @EndDate)=1, 1, 0) 
TotalWorkingDays,
DATEDIFF(DAY, @StartDate, @EndDate) - 
(
    ((((DATEDIFF(YEAR, @StartDate, @EndDate) * 51) + DATEPART(WEEK, @EndDate)) - DATEPART(WEEK, @StartDate)) * 2) + 
    IIF(DATEPART(WEEKDAY, @StartDate)=1, 1, 0) + 
    IIF(DATEPART(WEEKDAY, @EndDate)=7, 1, 0) 
) + 
IIF(DATEPART(WEEKDAY, @EndDate)=7 OR DATEPART(WEEKDAY, @EndDate)=1, 1, 0) 
TotalWorkingDays_new
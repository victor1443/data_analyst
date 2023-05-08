-- final table reorganization and formatting after reconsideration to export it for further Analysis and transformations
SELECT 
  [Report_ID] as [Report ID],
  FORMAT([Reported_Date] , 'dd-MM-yyyy') AS [Reported Date], -- formatting date values to correspond to widely used European standard of dd-mm-yyyy
  FORMAT([Crime_Period_From], 'dd-MM-yyyy HH:mm') as [Crime Period From],  
  FORMAT([Crime_Period_To], 'dd-MM-yyyy HH:mm') as [Crime Period To],
  DATEDIFF(
    hour, [Crime_Period_From], [Crime_Period_To]
	) AS [Crime Period Duration (Hours)], -- extracting the crime period duration in hours for further analysis for theft timeframes
  [Location_ID] as [Location ID],
  CASE 
    WHEN LOWER([Bike_Type]) = 'diverse' THEN 'other'
	ELSE LOWER([Bike_Type])
	END as [Bike Type], -- reformatting some descriptions and case formatting
  [Stealing_Attempt_Successful] as [Successful Theft],
  [Damage_EUR] as [Damage in EUR] ,
  CONCAT(
    LOWER(
	[Crime_Description]), 
	', ', 
	LOWER(
	  CASE
	    WHEN LOWER([Further_Information]) LIKE 'other%' THEN 'grand theft of bicycles'
	    ELSE [Further_Information]
	    END -- additionally formatting information column to exclude recurring irrelevant word 'other'
	)
  ) AS [Crime Description] -- combining crime description information into a single column to save space and relevancy
FROM 
  [ProjectOneBikeStudy].[dbo].[pbrBikeTheftStats]

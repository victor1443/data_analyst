-- prepare the final table gathering all the necessary data for analysis by merging the columns from two separate tables 
-- on a relation with Location attributes
-- and commenting out irrelevant columns and data
SELECT
  --first the columns from the main table with bike theft information
  [DATE_REPORTED] as [Reported Date],
  --[CRIME_PERIOD_START],
  --[START_HOUR],
  --combine date and time columns in a single one containing the date of the start and the second one for the end of the assumed crime period, to save space
  CONCAT([CRIME_PERIOD_START], ' ',  [START_HOUR], ':00') AS [Crime Period Start],
  --[CRIME_PERIOD_END],
  --[END_HOUR],
  CONCAT([CRIME_PERIOD_END], ' ',  [END_HOUR], ':00') AS [Crime Period End],
  --[LOR],
  [DAMAGES] as [Damage (EUR)],
  --[ATTEMPT], --maybe include later
  [TYPE_OF_BICYCLE] as [Bike Type],
  [OFFENSE] as [Crime Description],
  [REASON_FOR_DETECTION] as [Further Information], 
  --then the columns from the Berlin city planning information table
  --[OBJECTID],
  --[PLR_ID],
  [PLR_NAME] as [Planning Unit],
  --[BZR_ID],
  [BZR_NAME] as [District Region],
  --[PGR_ID],
  [PGR_NAME] as [Area]
  --[BEZ],
  --[FINHALT],
  --[STAND],
  --[SHAPE_Length],
  --[SHAPE_Area]
FROM 
  [ProjectOneBikeStudy].[dbo].[final_eng_Fahrraddiebstahl] f
LEFT JOIN
  [ProjectOneBikeStudy].[dbo].[final_LOR_2_Planung_format] l
ON
  f.LOR = l.PLR_ID -- to have a name of the location we create relation between the tables via location ID
ORDER BY 
  DATE_REPORTED desc -- sorting the data from the newest theft reports to oldest

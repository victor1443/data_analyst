-- create a sorted and ordered table for the territorial planning of Berlin and for its location units

SELECT
  --[OBJECTID],
  [PLR_ID] as [Location ID],
  [PLR_NAME] as [Planning Unit],
  --[BZR_ID],
  [BZR_NAME] as [District Region],
  --[PGR_ID],
  [PGR_NAME] as [Area],
  [BEZ] as [Disctrict No.]
  --[FINHALT],
  --[STAND],
  --[SHAPE_Length],
  --[SHAPE_Area]
FROM 
  [ProjectOneBikeStudy].[dbo].[final_LOR_2_Planung_format]
ORDER BY
  [PLR_ID] asc

-- Set the [PLR_ID] ("Location ID" in the future) as the Primary Key column
ALTER TABLE
  [ProjectOneBikeStudy].[dbo].[final_LOR_2_Planung_format]
ADD CONSTRAINT PK_final_LOR_2_Planung_format PRIMARY KEY ([PLR_ID]);
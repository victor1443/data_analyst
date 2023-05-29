--derive main table for data breach statistics
SELECT 
    --add +1 to each of the entries to make the primary key (ID) to start from 1, and not from 0
	([column1] + 1) AS [Breach_ID], 
    [Entity],
	--use a simple substring to have only the year value remaining, not the year range 
    SUBSTRING([Year], 0, 5) AS [Year],
	--remove all the string values e.g. "unknown" from the numberic column and substitute them with NULL for calculations
    CASE
		WHEN ISNUMERIC([Records]) = 1 THEN [Records]
		ELSE NULL
		END AS [Compromised_Records],
	--format breach type for better data readability and easier distinction 
	CASE 
		WHEN [Method] IS NULL THEN 'unknown'
		WHEN [Method] LIKE 'hacked%' THEN 'hacked'
		WHEN [Method] LIKE 'lost /%' THEN 'lost or stolen device'
		WHEN [Method] = 'publicly accessible Amazon Web Services (AWS) server' OR LOWER([Method]) LIKE 'poor security%' THEN 'poor security'
		ELSE LOWER([Method])
		END AS [Breach_Type], 
	--further formatting of Organization_Type for better readability (e.g. between 'gaming' and 'gambling')
	CASE 
		WHEN [Organization_type] = 'gaming' OR [Organization_type] = 'game' THEN 'video games' 
		WHEN [Organization_type] LIKE 'financ%' OR [Organization_type] LIKE 'banking%' OR [Organization_type] LIKE '%accounting' THEN 'finance and banking'
		WHEN [Organization_type] LIKE '%government%' THEN 'government'
		WHEN [Organization_type] LIKE 'health%' OR [Organization_type] LIKE 'clinical%' THEN 'healthcare'
		WHEN [Organization_type] LIKE 'tech%' OR [Organization_type] LIKE 'software' OR [Organization_type] = 'information technology' THEN 'tech'
		WHEN [Organization_type] LIKE 'telecom%' OR [Organization_type] LIKE 'telephone%' OR [Organization_type] LIKE 'mobile carrier' THEN 'telecommunications'
		WHEN [Organization_type] LIKE 'web%' THEN 'web service'
		WHEN [Organization_type] LIKE 'arts%' THEN 'arts'
		WHEN [Organization_type] LIKE '%demographic%' THEN 'demographic'
		WHEN [Organization_type] LIKE 'military%' THEN 'military'
		WHEN [Organization_type] LIKE '%marketing%' OR [Organization_type] LIKE 'market a%' THEN 'marketing'
		WHEN [Organization_type] = 'academic' OR [Organization_type] LIKE 'education%' THEN 'education'
		WHEN [Organization_type] LIKE 'social %' OR [Organization_type] = 'dating' OR [Organization_type] = 'messaging app' THEN 'social media'
		ELSE LOWER([Organization_type]) 
		END AS [Organization_Type]
    --[Sources]
FROM 
	[CyberSec].[dbo].[df_1]

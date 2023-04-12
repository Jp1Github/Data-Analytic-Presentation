/*This is a practice learning data cleaning from AlextheAnalyst Youtube.
Using MicroSoft SQL Server Management Studio */

USE PortfolioProject

SELECT * FROM [dbo.NashvilleHousing]

-------------------------------------------------------------------
-- Standardize Date column from DATETIME to DATE
-------------------------------------------------------------------
SELECT SaleDate, CONVERT(DATE, SaleDate)
FROM [dbo.NashvilleHousing]

-- Below code does same as above code
SELECT CAST(SaleDate AS DATE)
FROM [dbo.NashvilleHousing]

-- Since the above code show another temporary column.
-- To make it permanent is to create another column for SaleDate as SaleDateConverted

-- Create the table SaleDateConverted by using CONVERT OR CAST.
ALTER TABLE [dbo.NashvilleHousing]
ADD SaleDateConverted DATE

UPDATE [dbo.NashvilleHousing]
SET SaleDateConverted = CAST(SaleDate AS DATE)

/* What additional learned 
- Comparing with MySQL adding a column requires to specify the ADD COLUMN statement.
  MicroSoft SQL does not require the COLUMN statement.

- However when deleting a column, in MicroSoft SQL it needs the DROP COLUMN
  ALTER TABLE [dbo.NashvilleHousing] DROP COLUMN SaleDateConverted.Same with MySQL

- When the SaleDateConverted was created it was at the very far end.
  Solution found is to go to OPTION -> Design Tab -> Table and Database Designers
  and uncheck "Prevent saving changes that require table re-creation."

  Then go to the dbo.dbo.NashvilleHousing and right click Design and a new tab will pop out.
  Then choose the SaleDateConverted row and drag it beside the SaleDate
*/

-------------------------------------------------------------------
-- Some of the data in the propert address is missing.
-- Going to write a script to populate field / rows
-- There are 112,954 rows  and 112896 data entry
-------------------------------------------------------------------
SELECT PropertyAddress FROM [dbo.NashvilleHousing]
WHERE PropertyAddress IS NULL

-- There are 58 rows under the PropertyAddress missing data
SELECT count(*) - count(PropertyAddress) PropertyAddressNull FROM [dbo.NashvilleHousing]

TODO - FIND TO COUNT ROW AND DIVIDE WITH ANOTHER COUNT ROW.

SELECT (COUNT(b.PropertyAddress) - count(a.PropertyAddress))/COUNT(a.UniqueID)
FROM [dbo.NashvilleHousing] a
	JOIN [dbo.NashvilleHousing] b
	ON a.[PropertyAddress] = b.[PropertyAddress]
WHERE a.PropertyAddress IS NOT NULL AND b.PropertyAddress IS NULL

SELECT COUNT(a.PropertyAddress) - count(b.PropertyAddress) 
FROM [dbo.NashvilleHousing] a
	FULL JOIN [dbo.NashvilleHousing] b
	ON a.[PropertyAddress] = b.[PropertyAddress]
WHERE a.PropertyAddress IS NOT NULL AND b.PropertyAddress IS NULL

SELECT a.PropertyAddress/count(*)
FROM [dbo.NashvilleHousing]
WHERE (
SELECT count(*) - count(PropertyAddress) PropertyAddressNull FROM [dbo.NashvilleHousing]
) a


-- Doing a self join by creating alias which equals to the ParcelID but not equal to the UniqueID
-- Then use the ISNULL(#if a.property is null, populate b.propertyAddress)

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(b.PropertyAddress, a.PropertyAddress)
FROM [dbo.NashvilleHousing] a
	JOIN [dbo.NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE b.PropertyAddress IS NULL

-- After confirmation that it populate a column then do the code below
-- to update the empty property rows.
-- with the table alias
UPDATE a 
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [dbo.NashvilleHousing] a
	JOIN [dbo.NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

-------------------------------------------------------------------
-- Splitting the Address into three columns (Address, City and State)
-- It can be done in two ways using the SUBSTRING or PARSENAME
-------------------------------------------------------------------

-- Using SUBSTRING
SELECT PropertyAddress FROM [dbo.NashvilleHousing]

SELECT PropertyAddress, 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) AS Address
FROM [dbo.NashvilleHousing]


SELECT PropertyAddress, 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Address2
FROM [dbo.NashvilleHousing]
	-- Note on above code when Alias it does not want to start in a number like 2ndAddress

	-- Add columns
ALTER TABLE [dbo.NashvilleHousing]
ADD PropertySplitAddress Nvarchar(255), 
    PropertySplitCity Nvarchar(255)

	-- Populate the rows
UPDATE [dbo.NashvilleHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

UPDATE [dbo.NashvilleHousing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


-- Using PARSENAME But it is looking for period thus need the REPLACE statement within the bracket.
-- Splitting the OwnerAddress column / fields

SELECT OwnerAddress FROM [dbo.NashvilleHousing] WHERE OwnerAddress IS NOT NULL

SELECT
	PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
	PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
	PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM [dbo.NashvilleHousing] WHERE OwnerAddress IS NOT NULL

	-- Add columns
ALTER TABLE [dbo.NashvilleHousing]
ADD OwnerSplitAddress Nvarchar(255),
	OwnerSplitCity Nvarchar(255),
	OwnerSplitState Nvarchar(255)

	-- Drop remove below code before posting in portfolio
ALTER TABLE [dbo.NashvilleHousing]
DROP COLUMN OwnerSplitAddress, 
			OwnerSplitCity,
			OwnerSplitState

	-- Populate the rows
UPDATE [dbo.NashvilleHousing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

	-- Populate the rows
UPDATE [dbo.NashvilleHousing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

	-- Populate the rows
UPDATE [dbo.NashvilleHousing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

SELECT * FROM [dbo.NashvilleHousing]

/* The PARSENAME AND REPLACE seems a better choice the code is easier to read than the SUBSTRING and CHARINDEX */

-------------------------------------------------------------------
-- The "Sold as Vacant" column or field has inconsistent entry.
-- Standardize data from Y to Yes and N to No.
-------------------------------------------------------------------
-- Query the column to see any discrepancies and how many
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [dbo.NashvilleHousing]
GROUP BY SoldAsVacant
ORDER BY 2 -- COUNT(SoldAsVacant)

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
END
FROM [dbo.NashvilleHousing]


UPDATE [dbo.NashvilleHousing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
					 WHEN SoldAsVacant = 'N' THEN 'No'
END

/* Other alternative using COALESCE */

-------------------------------------------------------------------
-- Removing Duplicates. Not recommended to remove data in a raw database.
-- Recommend to get a copy of the database and make changes on there.
-------------------------------------------------------------------

-- Below code causing issue
-- Msg 102, Level 15, State 1, Line 222
-- Incorrect syntax near ')'
WITH RowNumCTE AS(
SELECT * ,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference

				 ORDER BY
				 UniqueID
				 ) row_num
FROM [dbo.NashvilleHousing]
)

-- Below code works!
SELECT * ,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference

				 ORDER BY
				 UniqueID
				 ) row_num
FROM [dbo.NashvilleHousing]
ORDER BY ParcelID

SELECT *
FROM RowNumCTE
ORDER BY ParcelID

-- Delete
--DELETE
FROM RowNumCTE
WHERE row_num > 1
ORDER BY ParcelID

-------------------------------------------------------------------
-- Delete Unused Columns
-------------------------------------------------------------------

SELECT * 
FROM [dbo.NashvilleHousing]

ALTER TABLE [dbo.NashvilleHousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
















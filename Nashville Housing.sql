select*
from salesproject..NashvilleHousing;
 --there is a problem at the date datatype so i had to convert it
 select saledate 
 from salesproject..NashvilleHousing;

 alter table nashvillehousing
 alter column saledate date;

  select saledate 
 from salesproject..NashvilleHousing;

 --the problem has been solved

 select*
from salesproject..NashvilleHousing
where PropertyAddress is null;

--i need to foundout if i can replace all these nulls
--to do this i will join the table to itself in order to a deeper look
 select a.ParcelID, b.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress,b.PropertyAddress)
from salesproject..NashvilleHousing a
join salesproject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null 


update a
set propertyaddress =  isnull(a.propertyaddress,b.PropertyAddress)
from salesproject..NashvilleHousing a
join salesproject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.UniqueID<>b.UniqueID
where a.PropertyAddress is null ;


--null values have benn handeld


--sperate address column to make a city column
Select PropertyAddress
From salesproject..NashvilleHousing;


select
SUBSTRING(propertyaddress, 1, CHARINDEX(',',PropertyAddress) -1 ) as address 
from salesproject..NashvilleHousing;

--i foundout that there are some addresses with no ',' so i had to do a case

SELECT
    CASE 
        WHEN CHARINDEX(', ', PropertyAddress) > 0 
        THEN SUBSTRING(PropertyAddress, 1, CHARINDEX(', ', PropertyAddress) - 1)
        ELSE PropertyAddress
    END AS address
FROM salesproject..NashvilleHousing;



SELECT
CASE 
        WHEN CHARINDEX(', ', PropertyAddress) > 0 
        THEN SUBSTRING(PropertyAddress, 1, CHARINDEX(', ', PropertyAddress) - 1)
        ELSE PropertyAddress
    END AS address,
 SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
From salesproject..NashvilleHousing



alter table NashvilleHousing
add splitpropertyaddress nvarchar(255);
update NashvilleHousing
set splitpropertyaddress =  CASE 
        WHEN CHARINDEX(', ', PropertyAddress) > 0 
        THEN SUBSTRING(PropertyAddress, 1, CHARINDEX(', ', PropertyAddress) - 1)
        ELSE PropertyAddress
    END;




	alter table NashvilleHousing
add splitpropertycity nvarchar(255);


update NashvilleHousing
set splitpropertycity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))
;



select*
from..NashvilleHousing;


--the column is seperated successfully


--there is another column that needs to be sperated, i'll use a differente way

select OwnerAddress
from..NashvilleHousing;


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from..NashvilleHousing;




	alter table NashvilleHousing
add splitownercity nvarchar(255);
update NashvilleHousing
set splitownercity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


	alter table NashvilleHousing
add splitowneraddress nvarchar(255);
update NashvilleHousing
set splitowneraddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

	alter table NashvilleHousing
add splitownerstate nvarchar(255);
update NashvilleHousing
set splitownerstate =PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--the problem has been solved

--transforming 0,1 in a bit column into yes,no in a nvarchar column.

select  SoldAsVacant,
case when convert(nvarchar(255),SoldAsVacant) = 0 then 'no'
     when convert(nvarchar(255),SoldAsVacant)= 1 then 'yes'
	 else convert(nvarchar(255),SoldAsVacant)
	 end
from salesproject..NashvilleHousing;


ALTER TABLE salesproject..NashvilleHousing
ALTER COLUMN SoldAsVacant NVARCHAR(10);

update salesproject..NashvilleHousing
set SoldAsVacant = 
case when SoldAsVacant = 0 then 'no'
     when SoldAsVacant= 1 then 'yes'
	 else SoldAsVacant
	 end; 


	 
---remove duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From salesproject.dbo.NashvilleHousing
--order by ParcelID
)
delete
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress

------------------------------------------------------
--delete unused column 

alter table salesproject.dbo.NashvilleHousing
drop column owneraddress, propertyaddress, taxdistrict




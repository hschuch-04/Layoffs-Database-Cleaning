# Database Cleaning - Layoffs Dataset

## Introduction
The Layoffs Dataset is a collection of data, beginning in the early 2020s, which holds information about the amount of employees layoffed across different companies within their industries. Using this data we can identify that the most important information for future visualization are the columns 'total_laid_off' and 'percentage_laid_off', and without them the other information is worthless.

At a glance, the dataset has varying inconsistences ranging from typos, extra spacing, duplicate rows, and empty datafields.

## The Process

A meticulous approach was taken following a step by step starting with the most important changes first, then continuing onto the next step. 

The first step approach was to identify if the dataset had any duplicate rows. By creating a Partition with ROW_NUMBER, I was able to to label all rows, so if any rows matched it would increase the row number incrementally, making it very easy to search for duplicate rows. Then using this query within a CTE allowed me to identify that there was infact multiple duplicate rows.
<details>
<summary>DUPLICATE ROWS</summary>
<img width="931" height="280" alt="Image" src="https://github.com/user-attachments/assets/ffcb51f2-f86c-4d17-bc41-ba9baeee0dfc" />
</details>
To remove these duplicates, I created a new staging table and used the query within the CTE to insert the information with the new 'row_num' column. This was done as it is easier to do this than add a new column to the already existing table. Afterwards, I simply removed any rows that were greater than 1 in row_num, and then deleted 'row_num' column as it was no longer needed.
<details>
<summary>PREVIOUS</summary>
<img width="574" height="256" alt="Image" src="https://github.com/user-attachments/assets/8ea8152f-0581-4c94-95c7-fcedd5d0bbec" />
</details>
<details>
<summary>NEW</summary>
<img width="787" height="236" alt="Image" src="https://github.com/user-attachments/assets/95e7f939-5c2a-4dce-aa78-68de0cc1f36c" />
</details>

After removing duplicates, it was now time to cleanup any obvious typos or incorrect inputs into the dataset. After making all the inputed data was correct and free from errors, the next noticeable change in the dataset needed to be empty fields. When looking into the information it appeared most of the empty fields appeared in the 'Industry' field. By using an Inner Join, and comparing both results on the company, if one had the 'Industry' filled and the other didn't it would populate remedying the data.
<details>
<summary>Inner Join Query</summary>
<img width="491" height="181" alt="Image" src="https://github.com/user-attachments/assets/1bb4e5e2-381f-4497-a097-6419c7b51860" />
</details>

Now it was to move onto the final step, which was to remove any rows which didn't hold any important data for visualization. If neither columns 'total_laid_off' and 'percentage_laid_off' had any information, they would be removed from the dataset as there was very little reason to keep and bloat the dataset. Using the query below, and altering to a delete statement removed all the rows from the dataset.
<details>
  <summary>Rows with no layoff data</summary>
  <img width="772" height="404" alt="Image" src="https://github.com/user-attachments/assets/59373ecc-71a1-491d-aceb-93bc3f3ea492" />
</details>

With those steps completed, it was now time to have another exploration of the data incase of any missing inconsistences, but in this case, everything major appeared to have been resolved.

## Development Experience
As this was my first time cleaning a dataset, it was very informative on certain common errors that can be in a dataset from either input error, or poor management. It also gave me a very strong foundation of searching the data manually using 'Select Statements' to find errors in the dataset, and creating duplicates of the dataset to create a risk free environment to make changes and then updating the original result when it meets standards. When starting my next data cleaning project, I will take a similar approach of creating a plan/list of importance, as I believe that was very beneficial and made the changes concises and reduce backtracking.

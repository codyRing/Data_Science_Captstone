$CSV= @()
gci ".\Data\Daily_Summaries\*.CSV"  |
    ForEach-Object {$CSV +=  Import-Csv $_ |
                    Select-Object "STATION","NAME","LATITUDE","LONGITUDE","ELEVATION","DATE","PRCP","TAVG","TMAX","TMIN" }

$CSV |Export-CSV  ".\Data\Daily_Summaries\Daily_Summaries_Merged.csv"  -NoTypeInformation -Force


gci ".\Data\Daily_Summaries\*.CSV" | 
   % { $_ | select name, @{n="lines";e={
       get-content $_ | 
         measure-object -line |
             select -expa lines }
                                       } 
     } | Set-Content ".\Data\Daily_Summaries\Daily_Summary_Row_Count.txt"
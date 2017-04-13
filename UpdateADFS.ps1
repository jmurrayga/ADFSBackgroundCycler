Import-Module adfs

function ToArray{
  begin
  {
    $output = @();
  }
  process
  {
    $output += $_;
  }
  end
  {
    return ,$output;
  }
}

#Sets the season or generic folder based on this value
$CurrentTheme = Get-Content "$PSScriptRoot\CurrentTheme.txt"

$TodaysDate = (Get-Date)

$ThisYear = (Get-Date).Year
$LastYear = (Get-Date).Year-1
$NextYear = (Get-Date).Year+1

#Automatically selects season if set to seasonal
if($CurrentTheme -eq "seasonal"){

    if($TodaysDate -gt (Get-Date -Day 1 -Month 3 -Year $ThisYear) -and $TodaysDate -lt (Get-Date -Day 31 -Month 5 -Year $ThisYear)){

        $CurrentTheme = "Spring"

    }

    if($TodaysDate -gt (Get-Date -Day 1 -Month 6 -Year $ThisYear) -and $TodaysDate -lt (Get-Date -Day 31 -Month 8 -Year $ThisYear)){

        $CurrentTheme = "Summer"

    }

    if($TodaysDate -gt (Get-Date -Day 1 -Month 9 -Year $ThisYear) -and $TodaysDate -lt (Get-Date -Day 30 -Month 11 -Year $ThisYear)){

        $CurrentTheme = "Fall"

    }

    if($TodaysDate -gt (Get-Date -Day 1 -Month 12 -Year $ThisYear) -and $TodaysDate -lt (Get-Date -Day 29 -Month 2 -Year $NextYear)){

        $CurrentTheme = "Winter"

    }

    if($TodaysDate -gt (Get-Date -Day 1 -Month 12 -Year $LastYear) -and $TodaysDate -lt (Get-Date -Day 29 -Month 2 -Year $ThisYear)){

        $CurrentTheme = "Winter"
    }

}

$Files = Get-ChildItem "$PSScriptRoot\$CurrentTheme\" | ToArray

$selectedFile = $Files[(Get-Random -Minimum 0 -Maximum $Files.Length)]

if($selectedFile -ne $null){

    $log = "Setting to :" + $selectedFile.FullName + " @ " + $TodaysDate

    Add-Content "$PSScriptRoot\UpdateLog.txt" $log

    Set-AdfsWebTheme -TargetName default -Illustration @{path=$selectedFile.FullName}

}
else
{

    $log = "selected file was null"

    Add-Content "$PSScriptRoot\UpdateLog.txt" $log

}





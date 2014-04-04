param(
    [string]$positionFileName = "splunk.log",
    [string]$logName = "Application",
    [int]$numEventsToRead = 100
)

$output = ""          # holds the output of a single event
$splunk_output = ""    # holds the output of all events


$positionFilePath = Join-Path -Path $env:SPLUNK_HOME "etc\apps\TA-XD7-VDA\bin\powershell"
$positionFile = Join-Path $positionFilePath $positionFileName

# If the position file does not exist, create it
if(!(Test-Path $positionFile))
{
    try
    {
        Set-Content -Value "-1" -Path $positionFile -ErrorAction Stop
    }
    catch
    {
        Write-Error('{0:MM/dd/yyyy HH:mm:ss} GMT - {1} {2}' -f (Get-Date).ToUniversalTime(), "Could not create position file: ", $_.Exception.Message)
        exit
    }
}


try
{
    # Get the RecordId of the last event we read
    $lastRecordID = Get-Content -Path $positionFile -ErrorAction Stop
    Write-Debug("{0} - Info - Position file contains {1}" -f (Get-Date), $lastRecordID)

    # Get events since the last time the script was run
    $events = Get-WinEvent -LogName $logName | Where-Object {$_.RecordId -gt $lastRecordID} | Sort-Object RecordId

    if(!$events)
    {
        Write-Debug("No new events found since last run.")
        exit
    }

    if($events.Length -lt $numEventsToRead)
    {
        $numEventsToRead = $events.Length
    }

    $greatestRID = $events[-1].RecordId
    
    # Loop through all the EventRecords
    for($i = 0; $i -lt $numEventsToRead; $i++)
    {
        $event = $events[$i]

        # Loop through all the member properties of the current EventRecord
        $output = $event | Get-Member -MemberType Properties | ForEach-Object {

            $key = $_.Name
        
            # We will handle the Properties list after the loop
            if($key -ine "Properties")
            {
                $value = $event.$key
                '{0}="{1}"' -f $key,$value
            }
        }

        # To loop through all the EventData properties, we need to access the event's raw XML
        $eventXML = [xml]$event.ToXml()

        for($j = 0; $j -lt $eventXML.Event.EventData.Data.Count; $j++)
        {
            $output += '{0}="{1}"' -f $eventXML.Event.EventData.Data[$j].Name, $eventXML.Event.EventData.Data[$j].'#text'
        }    

        $splunk_output += "{0:MM/dd/yyyy HH:mm:ss} GMT - {1}`n" -f ($event.TimeCreated.ToUniversalTime()), ($output -join " ")
    }
}
catch [System.Exception]
{
    Write-Error('{0:MM/dd/yyyy HH:mm:ss} GMT - {1} {2}' -f (Get-Date).ToUniversalTime(), "Fatal exception: ", $_.Exception.Message)
    exit
}

# Try to write the largest Record ID to the postion file
try
{
    Set-Content -Path $positionFile -Value $greatestRID -ErrorAction Stop
    Write-Host $splunk_output
}
catch [System.Exception]
{
    Write-Error('{0:MM/dd/yyyy HH:mm:ss} GMT - {1} {2}' -f (Get-Date).ToUniversalTime(), "Fatal exception: ", $_.Exception.Message)
    exit
}
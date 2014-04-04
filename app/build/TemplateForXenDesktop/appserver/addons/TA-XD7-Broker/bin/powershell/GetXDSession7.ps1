$snapins  = Get-PSSnapin Citrix.Broker.Admin.* -ea 0

if ($snapins -eq $null)
{
   Get-PSSnapin -Registered "Citrix.Broker.Admin.*" | Add-PSSnapin
}

$SiteName = Get-BrokerSite | select -ExpandProperty Name

Get-BrokerSession | foreach-object {

    $Session = $_
	if($Session)
	{
		$output = $Session | Get-Member -MemberType Properties | foreach-object {
			$Key = $_.Name
			$Value = $Session.$Key -join ";" 

			if($Key -eq "StartTime") {
		            $Value = "{0:MM/dd/yyyy HH:mm:ss} GMT" -f ([datetime]$Value).ToUniversalTime();
		        }

			'{0}="{1}"' -f $Key,$Value
		}


		$output += '{0}="{1}"' -f "SiteName",$SiteName
		Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
	}
} 
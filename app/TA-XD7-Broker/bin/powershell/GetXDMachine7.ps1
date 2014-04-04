$snapins  = Get-PSSnapin Citrix.Broker.Admin.* -ea 0

if ($snapins -eq $null)
{
   Get-PSSnapin -Registered "Citrix.Broker.Admin.*" | Add-PSSnapin
}

$SiteName = Get-BrokerSite | select -ExpandProperty Name

Get-BrokerMachine | foreach-object {

    $Machine = $_
	if($Machine)
	{
		$output = $Machine | Get-Member -MemberType Properties | foreach-object {
			$Key = $_.Name
			$Value = $Machine.$Key -join ";" 
			'{0}="{1}"' -f $Key,$Value
		}

		$output += '{0}="{1}"' -f "SiteName",$SiteName
		Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
	}
} 

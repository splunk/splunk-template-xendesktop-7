$snapins  = Get-PSSnapin Citrix.Broker.Admin.* -ea 0

if ($snapins -eq $null)
{
   Get-PSSnapin -Registered "Citrix.Broker.Admin.*" | Add-PSSnapin
}

$SiteName = Get-BrokerSite | select -ExpandProperty Name

Get-BrokerController | foreach-object {

    $Controller= $_
	if($Controller)
	{
		$output = $Controller | Get-Member -MemberType Properties | foreach-object {
			$Key = $_.Name
			$Value = $Controller.$Key -join ";" 
			'{0}="{1}"' -f $Key,$Value
		}

		$output += '{0}="{1}"' -f "SiteName",$siteName
		Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
	}
} 
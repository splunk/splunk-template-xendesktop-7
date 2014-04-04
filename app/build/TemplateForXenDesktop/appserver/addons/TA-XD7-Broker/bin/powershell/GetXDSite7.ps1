$snapins  = Get-PSSnapin Citrix.Broker.Admin.* -ea 0

if ($snapins -eq $null)
{
   Get-PSSnapin -Registered "Citrix.Broker.Admin.*" | Add-PSSnapin
}

$Hosts = Get-BrokerMachine  | measure-object | select -ExpandProperty count
$Applications = Get-BrokerApplication  | measure-object | select -ExpandProperty count
$Controllers = Get-BrokerController  | measure-object | select -ExpandProperty count

Get-BrokerSite | foreach-object {

    $Site= $_
	if($Site)
	{
		$output = $Site | Get-Member -MemberType Properties | foreach-object {
			$Key = $_.Name
			$Value = $Site.$Key -join ";" 
			'{0}="{1}"' -f $Key,$Value
		}
		
		$output += '{0}="{1}"' -f "Machines",$Hosts
		$output += '{0}="{1}"' -f "Applications",$Applications
		$output += '{0}="{1}"' -f "Controllers",$Controllers
		
		Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
	}
} 
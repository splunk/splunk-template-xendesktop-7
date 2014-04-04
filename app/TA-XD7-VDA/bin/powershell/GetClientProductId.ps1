$Parent = Split-Path $MyInvocation.MyCommand.Path -Parent
$Path = "{0}\GetCliProdId.exe" -f $Parent
$output = (& $Path) -split "\,"
$MyOutput = @()

if($output)
{
    switch -regex ($output)
    {
        "^ClientProductId"  { $MyOutput += '{0}="{1}"' -f $_.split("=") ; continue }
    }

   if($MyOutput) {
       Write-Host ('{0:MM/dd/yyyy HH:mm:ss} GMT - {1}' -f ((get-date).ToUniversalTime()),($MyOutput -join " "))
   }
}

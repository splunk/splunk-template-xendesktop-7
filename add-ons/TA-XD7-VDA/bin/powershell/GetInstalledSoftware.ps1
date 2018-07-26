Param($Computer = $ENV:ComputerName)   

$ScriptRunTime = (get-date).ToFileTime()
  
$RemoteRegistry = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$Computer)   

$RegKey = $RemoteRegistry.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\")
if($RegKey)
{
    foreach($key in $RegKey.GetSubKeyNames())   
    {
        $output = @()
        $SubKey = $RegKey.OpenSubKey($key)
        $DisplayName = $SubKey.GetValue("DisplayName")
        if($DisplayName)
        {
            $output += 'Name="{0}"'            -f $DisplayName
            $output += 'Version="{0}"'         -f ($SubKey.GetValue("DisplayVersion"))  
            $output += 'InstallLocation="{0}"' -f ($SubKey.GetValue("InstallLocation")) 
            $output += 'Vendor="{0}"'          -f ($SubKey.GetValue("Publisher")) 
            $output += 'ScriptRunTime="{0}"'   -f $ScriptRunTime
        }
        
        if($output.count -gt 0)
        {
            Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
        }
    }   
}

$RegKey = $RemoteRegistry.OpenSubKey("SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall")
if($RegKey)
{
    foreach($key in $RegKey.GetSubKeyNames())   
    {
        $output = @()
        $SubKey = $RegKey.OpenSubKey($key)   
        $DisplayName = $SubKey.GetValue("DisplayName")
        if($DisplayName)
        {
            $output += 'Name="{0}"'            -f $DisplayName
            $output += 'Version="{0}"'         -f ($SubKey.GetValue("DisplayVersion")) 
            $output += 'InstallLocation="{0}"' -f ($SubKey.GetValue("InstallLocation"))
            $output += 'Vendor="{0}"'          -f ($SubKey.GetValue("Publisher"))
            $output += 'ScriptRunTime="{0}"'   -f $ScriptRunTime
        }
        
        if($output.count -gt 0)
        {
            Write-Host ("{0:MM/dd/yyyy HH:mm:ss} GMT - {1}" -f ((get-date).ToUniversalTime()),( $output -join " " ))
        }
    }   
}
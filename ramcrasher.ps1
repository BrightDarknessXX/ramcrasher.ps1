
$memoryAllocationScript = {
    $array = @()
    for ($i = 0; $i -lt 10000000; $i++) {
    $array += (New-Object Byte[] 10240KB)
    Start-Sleep -Milliseconds 10  # Slow down to prevent immediate system lag
    }
}

# Instance number
$instances = 10

# Loop to create multiple instances
for ($i = 1; $i -le $instances; $i++)
{
    Start-Job -ScriptBlock $memoryAllocationScript
    Start-Sleep -Milliseconds 100
}

Write-Host "Launched $instances instances of the memory allocation script."

# Wait for user input to trigger the kill switch
Write-Host "Press Enter to terminate all memory allocation jobs..."
Read-Host

# Kill Switch
Get-Job | Remove-Job -Force

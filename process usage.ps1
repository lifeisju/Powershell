$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$Samples = (Get-Counter "\Process($Processname*)\% Processor Time").CounterSamples
#$Samples = (Get-Counter "\Processor Information(_Total)\% Processor Time").CounterSamples
$CPUUsages = $Samples | Select InstanceName, @{Name="CPU %";Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 1)}}

$List = $CPUUsages | Select-Object -First 5 -Last 1

    if($list[0].InstanceName -eq 'WmiPrvSE' -and [int]$List[0].'CPU %' -ge '99'){
    Stop-Process -Name 'WmiPrvSE' -Force
    }

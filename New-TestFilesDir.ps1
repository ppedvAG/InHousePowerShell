[cmdletBinding()]
param(
    [ValidateScript({Test-Path -Path $PSItem})]
    [Parameter(Mandatory=$true)]
    [string]$path,

    [validateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateRange(1,20)]
    [int]$DirCount = 2,

    [switch]$Force
)

if(Test-Path -Path ("$path\TestFiles"))
{
    
    if($Force)
    {
        Remove-Item -Path "$path\TestFiles" -force -Recurse
    }
    else
    {
        Write-Host -Object "Ordner bereits vorhanden" -ForegroundColor Red
        exit
    }
}
    New-Item -Path $path -Name "TestFiles" -ItemType Directory


$path = "$path\TestFiles"

for($i = 1;$i -le $FileCount; $i++)
{
    New-Item -Path $path -Name "File$i.txt" -ItemType File
}

for($i =1; $i -le $DirCount; $i++)
{
    New-Item -Path $path -Name "Ordner$i" -ItemType Directory

    for($j = 1; $j -le $FileCount; $j ++)
    {
        New-Item -Path "$path\Ordner$i" -Name ("Ordner$i" + "File$j.txt")
    }
}
param([string]$pass="DefultPassword@1234")
Write-host ""
Write-host ""
foreach($line in [System.IO.File]::ReadLines(".\pass.txt")){ 

try {


$email_regex = "(?:[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|`"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*`")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"
$email = [regex]::match($line, $email_regex).Value
$email = ($email -split '@',3)[0]
if ($email){


Set-ADAccountPassword -Identity $email -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $pass -Force);
Enable-ADAccount -Identity $email ; 
Unlock-ADAccount -Identity $email ;
Clear-ADAccountExpiration -Identity $email
Write-host "$email  : Successfully Reset" -ForegroundColor Green

}catch{

Write-host "$email  : Password Reset Failed" -ForegroundColor Red

}

}
Write-host ""
Write-host "Password =  $pass" -ForegroundColor Yellow -BackgroundColor Black
Write-host ""
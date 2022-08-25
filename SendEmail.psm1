Add-Type -path "C:\Program Files\PackageManagement\NuGet\Packages\MimeKit.3.4.0\lib\netstandard2.0\MimeKit.dll"
Add-Type -path "C:\Program Files\PackageManagement\NuGet\Packages\MailKit.3.3.0\lib\netstandard2.0\MailKit.dll"



function Send-Email {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string]$From,
        [Parameter()]
        $to,
        [Parameter()]
        $attachments,
        [Parameter()]
        [string]$smtp_server,
        [Parameter()]
        [string]$port = "587",
        [Parameter()]
        [string]$subject,
        [Parameter()]
        [string]$body,
        [Parameter()]
        [switch]$bodyashtml

    )
    
    $smtp = New-Object  MailKit.Net.Smtp.SmtpClient
    $message = New-Object MimeKit.MimeMessage
    $builder = New-Object MimeKit.BodyBuilder

    # Get-Credential | Export-Clixml -Path ".\gmail.xml"
    # $account =  Import-Clixml -Path ".\gmail.xml"

    $username = "omerandriaminah@gmail.com"

    $password = "gkvyzzlsfsucywnm" | ConvertTo-SecureString -AsPlainText -Force

    $account = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
    $username
    $password
    $account
    $message.From.Add($username)

    if($to)
        {
            foreach ($destination in $to)
            {
                $message.To.Add($destination)
            }
        }
    # $message.To.Add($to)
    $message.Subject=$subject

    if($bodyashtml){

        $builder.HtmlBody=$body
    }else {
        $builder.MessageBody=$body
    }

    if($attachments){
        foreach($object in $attachments){
            $builder.Attachments.Add($object)
        }
    }

    # $builder.TextBody=$body
    $message.Body = $builder.ToMessageBody()

    $smtp.Connect($smtp_server, $port, $false)

    if($account){
        $smtp.Authenticate($account)
    }else{
        Write-Host "no account"
    }

    
    $smtp.Send($message)
    $smtp.Disconnect($true)
    $smtp.Dispose()

}


Import-Module C:\Users\Omer\Git_projects\SendEmail\SendEmail.psm1

$Attribs=@{
    from="omerandriaminah@gmail.com"
#    user_password="gkvyzzlsfsucywnm"
    to=@("omerandriaminah@gmail.com", "xolanindebele76@gmail.com")
    smtp_server="smtp.mail.com"
    subject="send email with powershell module"
    body="<h1>Powershell send mail</h1> <body> hello, this is an email from powershell</body>"
    bodyashtml=$true
}
Send-Email @Attribs
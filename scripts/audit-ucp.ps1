$ErrorActionPreference = "Continue"

$root = "C:\Projects\ucp-mvp"
$auditDir = Join-Path $root "docs\audit"
$report = Join-Path $auditDir "PROJECT-AUDIT.md"

New-Item -ItemType Directory -Force -Path $auditDir | Out-Null

$exclude = '\\node_modules\\|\\.venv\\|\\venv\\|__pycache__|\\.git\\|\\dist\\|\\build\\|\\docs\\audit\\'

function Add-Section($title, $content) {
    Add-Content -Path $report -Value "`n## $title`n" -Encoding utf8
    Add-Content -Path $report -Value $content -Encoding utf8
}

"# UCP MVP Project Audit" | Out-File $report -Encoding utf8
"Date: $(Get-Date)" | Add-Content $report -Encoding utf8

$docker = docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" 2>&1
Add-Section "Docker containers" ($docker | Out-String)

$folders = @("backend\src", "services", "frontend\src", "scripts", "docs", "db")
$tree = foreach ($folder in $folders) {
    $path = Join-Path $root $folder
    if (Test-Path $path) {
        "### $folder"
        Get-ChildItem $path -Recurse -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notmatch $exclude } |
            Select-Object -ExpandProperty FullName
    }
}
Add-Section "Project structure" ($tree | Out-String)

$ps1Files = Get-ChildItem $root -Recurse -Filter *.ps1 -File -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $exclude }

$ps1List = foreach ($file in $ps1Files) {
    $file.FullName.Replace("$root\", "")
}
Add-Section "PowerShell scripts" ($ps1List | Out-String)

$backendRoutes = Get-ChildItem "$root\backend\src", "$root\services" -Recurse -Include *.js,*.ts,*.py -File -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $exclude } |
    Select-String -Pattern "app\.(get|post|put|delete|patch)|router\.(get|post|put|delete|patch)|@app\.(get|post|put|delete|patch)|@router\.(get|post|put|delete|patch)" |
    ForEach-Object { "$($_.Path):$($_.LineNumber): $($_.Line.Trim())" }
Add-Section "Backend API routes" ($backendRoutes | Out-String)

$frontendCalls = Get-ChildItem "$root\frontend\src" -Recurse -Include *.js,*.jsx -File -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch $exclude } |
    Select-String -Pattern "fetch\(|axios|API_BASE|localhost:8090|/api/" |
    ForEach-Object { "$($_.Path):$($_.LineNumber): $($_.Line.Trim())" }
Add-Section "Frontend API calls" ($frontendCalls | Out-String)

$checks = @(
    "http://localhost:8090/docs",
    "http://localhost:8090/api/ai/chat",
    "http://localhost:8090/api/appointments",
    "http://localhost:8081/api/v1/Appointments",
    "http://localhost:5173"
)

$apiResults = foreach ($url in $checks) {
    try {
        $response = Invoke-WebRequest -Uri $url -Method GET -UseBasicParsing -TimeoutSec 5
        "$url => $($response.StatusCode)"
    } catch {
        $status = "ERROR"
        if ($_.Exception.Response) {
            $status = [int]$_.Exception.Response.StatusCode
        }
        "$url => $status"
    }
}
Add-Section "API checks" ($apiResults | Out-String)

$databases = docker exec ucp_database mariadb --protocol=TCP -h 127.0.0.1 -u ucp_user -p"QXJREEcYtQ8R9Jw8" -e "SHOW DATABASES;" 2>&1
Add-Section "MariaDB databases" ($databases | Out-String)

Start-Process code -ArgumentList "-n", "`"$report`""

Write-Host "Audit complete: $report"

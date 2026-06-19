Add-Type -AssemblyName System.Net.Http

$url = "http://localhost:8801/g3pix-cms/"
#$url = "http://localhost:8801/manual/"
$totalRequests = 2000 # Simultaneous requests 

Write-Host "Starting requests $totalRequests for $url..." -ForegroundColor Cyan

$client = New-Object System.Net.Http.HttpClient

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

$tasks = foreach ($i in 1..$totalRequests) {
    $client.GetAsync($url)
}

try {
    [System.Threading.Tasks.Task]::WaitAll($tasks)
}
catch {
    Write-Host "Some requests failed." -ForegroundColor Yellow
}

$stopwatch.Stop()

$successCount = 0
$errorCount = 0

# Check HTTP status for tasks
foreach ($task in $tasks) {
    if ($task.Status -eq 'RanToCompletion') {
        if ($task.Result.IsSuccessStatusCode) {
            $successCount++
        }
        else {
            $errorCount++
        }
        $task.Result.Dispose()
    }
    else {
        $errorCount++
    }
}

$client.Dispose()

Write-Host "`n--- Tests results ---" -ForegroundColor White
Write-Host "Total time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor White
Write-Host "Success requests (HTTP 200): $successCount" -ForegroundColor Green

if ($errorCount -gt 0) {
    Write-Host "Failed requests: $errorCount" -ForegroundColor Red
}
else {
    Write-Host "Failed requests: $errorCount" -ForegroundColor Green
}
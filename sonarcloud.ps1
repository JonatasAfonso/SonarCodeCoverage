param(
    [string] $sonarSecret
)


Install-package BuildUtils -Confirm:$false -Scope CurrentUser -Force
Import-Module BuildUtils

$runningDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
Write-host $runningDirectory 

$testOutputDir = "$runningDirectory/TestResults"
Write-host $testOutputDir

Write-host "Ok ate 15"

if (Test-Path $testOutputDir) 
{
    Write-host "Cleaning temporary Test Output path $testOutputDir"
    Remove-Item $testOutputDir -Recurse -Force
}

Write-host "Ok ate 23"
$version = Invoke-Gitversion
$assemblyVer = $version.assemblyVersion 

Write-host "Ok ate 27"
$branch = git branch --show-current
Write-host "Ok ate 29"
Write-Host "branch is $branch"

dotnet tool restore
Write-host "Ok ate 33"
dotnet tool run dotnet-sonarscanner begin /k:"JonatasAfonso_SonarCodeCoverage" /v:"$assemblyVer" /o:"alkampfergit-github" /d:sonar.login="$sonarSecret" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.cs.vstest.reportsPaths=TestResults/*.trx /d:sonar.cs.opencover.reportsPaths=TestResults/*/coverage.opencover.xml /d:sonar.coverage.exclusions="**Test*.cs" /d:sonar.branch.name="$branch"
Write-host "Ok ate 35"

dotnet restore src
Write-host "Ok ate 38"
dotnet build src --configuration release
Write-host "Ok ate 40"
dotnet test "./ProjetoTests/ProjetoTests.csproj" --collect:"XPlat Code Coverage" --results-directory TestResults/ --logger "trx;LogFileName=unittests.trx" --no-build --no-restore --configuration release -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover
Write-host "Ok ate 42"
dotnet tool run dotnet-sonarscanner end /d:sonar.login="$sonarSecret"
Write-host "Ok ate 44"

param(
    [string] $sonarSecret
)


Install-package BuildUtils -Confirm:$false -Scope CurrentUser -Force
Import-Module BuildUtils

$runningDirectory = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$testOutputDir = "$runningDirectory/TestResults"

if (Test-Path $testOutputDir) 
{
    Write-host "Cleaning temporary Test Output path $testOutputDir"
    Remove-Item $testOutputDir -Recurse -Force
}


# .\.sonar\scanner\dotnet-sonarscanner begin /k:"JonatasAfonso_SonarCodeCoverage" /o:"rumosamazonia" /d:sonar.login="${{ secrets.SONAR_TOKEN }}" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.cs.vstest.reportsPaths=TestResults/*.trx /d:sonar.cs.opencover.reportsPaths=TestResults/*/coverage.opencover.xml /d:sonar.coverage.exclusions="**Test*.cs"
# dotnet restore
# dotnet build --no-restore
# dotnet test --no-build --verbosity normal 
# .\.sonar\scanner\dotnet-sonarscanner end /d:sonar.login="${{ secrets.SONAR_TOKEN }}"

		  
# dotnet tool restore
# dotnet tool run dotnet-sonarscanner begin /k:"JonatasAfonso_SonarCodeCoverage" /o:"alkampfergit-github" /d:sonar.login="$sonarSecret" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.cs.vstest.reportsPaths=TestResults/*.trx /d:sonar.cs.opencover.reportsPaths=TestResults/*/coverage.opencover.xml /d:sonar.coverage.exclusions="**Test*.cs"
.\.sonar\scanner\dotnet-sonarscanner begin /k:"JonatasAfonso_SonarCodeCoverage" /o:"rumosamazonia" /d:sonar.login="$sonarSecret" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.cs.vstest.reportsPaths=TestResults/*.trx /d:sonar.cs.opencover.reportsPaths=TestResults/*/coverage.opencover.xml /d:sonar.coverage.exclusions="**Test*.cs"

dotnet restore
dotnet build --configuration release
# dotnet test "./ProjetoTests/ProjetoTests.csproj" --collect:"XPlat Code Coverage" --results-directory TestResults/ --logger "trx;LogFileName=unittests.trx" --no-build --no-restore --configuration release -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover
dotnet test --no-build --verbosity normal --collect:"XPlat Code Coverage" --results-directory TestResults/ --logger "trx;LogFileName=unittests.trx" -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover
# dotnet tool run dotnet-sonarscanner end /d:sonar.login="$sonarSecret"
.\.sonar\scanner\dotnet-sonarscanner end /d:sonar.login="$sonarSecret"


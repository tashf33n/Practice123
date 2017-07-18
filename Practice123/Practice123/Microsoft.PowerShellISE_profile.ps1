function buildVS {

        param
        (
        
        [parameter(Mandatory=$true)]
        [String] $path,

        [parameter(Mandatory=$false)]
        [bool] $nuget = $true,

        [parameter(Mandatory=$false)]
        [bool] $clean = $true
        
        )

        process 
        {
            $msBuildExe = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe'

            if ($nuget) {
            Write-Host "Restoring NuGet packages" -ForegroundColor Green
            nuget restore "$($path)"            
            }

            if ($clean) {
            Write-Host "Cleaning $($path)" -ForegroundColor Green
            & "$($msBuildExe)" "$($path)" /t:Clean /m
            }

            Write-Host "Building $($path)" -ForegroundColor Green
            & "$($msBuildExe)" "$($path)" /t:Build /m

        }

}
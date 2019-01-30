# --- Expose each Public and Private function as part of the module
foreach ($Function in Get-ChildItem -Path "$($PSScriptRoot)\Functions\*.ps1" -Recurse -Verbose:$VerbosePreference) {

    . $Function.FullName
}

# --- Clean up variables on module removal
$ExecutionContext.SessionState.Module.OnRemove = {

    Remove-Variable -Name vLCMConnection -Force -ErrorAction SilentlyContinue

}

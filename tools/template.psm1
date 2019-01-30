<#
____                              _     ____ __  __
|  _ \ _____      _____ _ ____   _| |   / ___|  \/  |
| |_) / _ \ \ /\ / / _ \ '__\ \ / / |  | |   | |\/| |
|  __/ (_) \ V  V /  __/ |   \ V /| |__| |___| |  | |
|_|   \___/ \_/\_/ \___|_|    \_/ |_____\____|_|  |_|

#>

# --- Clean up vRAConnection variable on module remove
$ExecutionContext.SessionState.Module.OnRemove = {

    Remove-Variable -Name vLCMConnection -Force -ErrorAction SilentlyContinue

}

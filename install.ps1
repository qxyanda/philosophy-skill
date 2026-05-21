# ============================================================
# philosophy-skill installer — Windows (PowerShell)
# Seven philosophers. One PowerShell script. No excuses.
# ============================================================

param(
    [switch]$Force = $false
)

$ErrorActionPreference = "Stop"

$SkillName = "philosophy"
$SkillSrc = Join-Path $PSScriptRoot "philosophy"
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$SkillsDir = Join-Path $ClaudeDir "skills"
$SkillDest = Join-Path $SkillsDir $SkillName
$SettingsPath = Join-Path $ClaudeDir "settings.json"
$PluginKey = "philosophy@local-skills"

Write-Host "  The philosophers are arriving..." -ForegroundColor Yellow
Write-Host ""

# --- Pre-flight checks ---
if (-not (Test-Path $SkillSrc)) {
    Write-Host "Error: Cannot find philosophy/ directory at: $SkillSrc" -ForegroundColor Red
    Write-Host "Run this script from the repository root."
    exit 1
}

if (-not (Test-Path (Join-Path $SkillSrc "SKILL.md"))) {
    Write-Host "Error: philosophy/SKILL.md not found. Repository may be corrupted." -ForegroundColor Red
    exit 1
}

# --- Create .claude directories if needed ---
New-Item -ItemType Directory -Force -Path $ClaudeDir | Out-Null
New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

# --- Copy skill files ---
Write-Host "Installing skill to: $SkillDest"
if (Test-Path $SkillDest) {
    Remove-Item -Recurse -Force $SkillDest
}
Copy-Item -Recurse -Path $SkillSrc -Destination $SkillDest
Write-Host "  Skill files copied." -ForegroundColor Green

# --- Register in settings.json ---
Write-Host ""
Write-Host "Registering in settings.json..."

$LocalSkillsPath = $SkillsDir -replace '\\', '\\'

if (-not (Test-Path $SettingsPath)) {
    # Create fresh settings.json
    $settings = @{
        enabledPlugins = @{
            "philosophy@local-skills" = $true
        }
        extraKnownMarketplaces = @{
            "local-skills" = @{
                source = @{
                    source = "directory"
                    path   = $SkillsDir
                }
            }
        }
    }
    $settings | ConvertTo-Json -Depth 5 | Set-Content -Path $SettingsPath -Encoding UTF8
    Write-Host "  Created settings.json with philosophy skill enabled." -ForegroundColor Green
} else {
    try {
        $settings = Get-Content -Raw -Path $SettingsPath | ConvertFrom-Json
    } catch {
        Write-Host "Error: Failed to parse settings.json. Is it valid JSON?" -ForegroundColor Red
        Write-Host "Manually add this to your settings.json enabledPlugins:"
        Write-Host "  `"philosophy@local-skills`": true"
        exit 1
    }

    # Ensure properties exist (ConvertFrom-Json returns PSCustomObject)
    $settings = $settings | ConvertTo-Json -Depth 10 | ConvertFrom-Json

    if (-not (Get-Member -InputObject $settings -Name "enabledPlugins" -MemberType Properties)) {
        $settings | Add-Member -MemberType NoteProperty -Name "enabledPlugins" -Value (@{} | ConvertFrom-Json)
    }
    if (-not (Get-Member -InputObject $settings -Name "extraKnownMarketplaces" -MemberType Properties)) {
        $settings | Add-Member -MemberType NoteProperty -Name "extraKnownMarketplaces" -Value (@{} | ConvertFrom-Json)
    }

    # Add the plugin entry
    $enabledPlugins = $settings.enabledPlugins
    if (-not (Get-Member -InputObject $enabledPlugins -Name "philosophy@local-skills" -MemberType Properties)) {
        $enabledPlugins | Add-Member -MemberType NoteProperty -Name "philosophy@local-skills" -Value $true
    } else {
        $enabledPlugins."philosophy@local-skills" = $true
    }

    # Ensure local-skills marketplace
    $marketplaces = $settings.extraKnownMarketplaces
    if (-not (Get-Member -InputObject $marketplaces -Name "local-skills" -MemberType Properties)) {
        $localSkills = [PSCustomObject]@{
            source = [PSCustomObject]@{
                source = "directory"
                path   = $SkillsDir
            }
        }
        $marketplaces | Add-Member -MemberType NoteProperty -Name "local-skills" -Value $localSkills
    }

    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsPath -Encoding UTF8
    Write-Host "  settings.json updated." -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  Installation complete." -ForegroundColor Green
Write-Host ""
Write-Host "  Schopenhauer, Diogenes, Nietzsche, Wittgenstein,"
Write-Host "  Wilde, Sartre, and Camus now reside in your terminal."
Write-Host ""
Write-Host "  Start Claude Code and type: /philosophy"
Write-Host "============================================================" -ForegroundColor Green

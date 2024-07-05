# 设置全局输出编码为 UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Show UTF-8 Content Correctly: https://chatgpt.com/share/6e748c3a-2a51-4bed-87f9-0c55a7bb1a71 
Remove-Item Alias:cat

function Get-ContentUtf8 {
    param (
        [string]$Path
    )
    Get-Content -Path $Path -Encoding UTF8
}

Set-Alias cat Get-ContentUtf8
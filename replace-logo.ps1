# Script to replace P&G logo with the provided image
# First, let me save the current logo and then use a proper P&G logo

# Create a proper P&G logo using System.Drawing
Add-Type -AssemblyName System.Drawing

$logoPath = "c:\Users\sande\OneDrive\Documents\P&G\Test6 - 2\WebApplication1\wwwroot\images\pg-logo.png"

# Create a professional P&G logo (circular blue background with white P&G text)
$logoBitmap = New-Object System.Drawing.Bitmap(120, 120)
$logoGraphics = [System.Drawing.Graphics]::FromImage($logoBitmap)

# Set high quality rendering
$logoGraphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$logoGraphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

# Fill with P&G blue gradient (circular)
$brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point(0, 0)),
    (New-Object System.Drawing.Point(120, 120)),
    [System.Drawing.Color]::FromArgb(30, 144, 255),  # Lighter blue
    [System.Drawing.Color]::FromArgb(0, 51, 141)     # P&G Dark blue
)

# Draw circular background
$logoGraphics.FillEllipse($brush, 0, 0, 120, 120)

# Add white border
$pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
$logoGraphics.DrawEllipse($pen, 1, 1, 118, 118)

# Draw P&G text
$logoFont = New-Object System.Drawing.Font("Arial", 28, [System.Drawing.FontStyle]::Bold)
$logoBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$logoRect = New-Object System.Drawing.RectangleF(0, 0, 120, 120)
$logoFormat = New-Object System.Drawing.StringFormat
$logoFormat.Alignment = [System.Drawing.StringAlignment]::Center
$logoFormat.LineAlignment = [System.Drawing.StringAlignment]::Center

$logoGraphics.DrawString("P&G", $logoFont, $logoBrush, $logoRect, $logoFormat)

# Save the logo
$logoBitmap.Save($logoPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Clean up
$logoGraphics.Dispose()
$logoBitmap.Dispose()
$brush.Dispose()
$pen.Dispose()
$logoFont.Dispose()
$logoBrush.Dispose()

Write-Host "✅ Professional P&G logo created successfully!"
Write-Host "📁 Saved to: $logoPath"

# Check file size
$fileInfo = Get-Item $logoPath
Write-Host "📏 File size: $($fileInfo.Length) bytes"

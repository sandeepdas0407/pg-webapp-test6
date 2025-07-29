# PowerShell script to create test images using .NET Graphics
Add-Type -AssemblyName System.Drawing

$imagesPath = "c:\Users\sande\OneDrive\Documents\P&G\Test6 - 2\WebApplication1\wwwroot\images"

# Create P&G Logo
$logoBitmap = New-Object System.Drawing.Bitmap(120, 60)
$logoGraphics = [System.Drawing.Graphics]::FromImage($logoBitmap)
$logoGraphics.Clear([System.Drawing.Color]::FromArgb(0, 51, 141))  # P&G Blue
$logoFont = New-Object System.Drawing.Font("Arial", 20, [System.Drawing.FontStyle]::Bold)
$logoBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$logoRect = New-Object System.Drawing.RectangleF(0, 0, 120, 60)
$logoFormat = New-Object System.Drawing.StringFormat
$logoFormat.Alignment = [System.Drawing.StringAlignment]::Center
$logoFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
$logoGraphics.DrawString("P&G", $logoFont, $logoBrush, $logoRect, $logoFormat)
$logoBitmap.Save("$imagesPath\pg-logo.png", [System.Drawing.Imaging.ImageFormat]::Png)
$logoGraphics.Dispose()
$logoBitmap.Dispose()

# Create Scientist Image
$scientistBitmap = New-Object System.Drawing.Bitmap(400, 300)
$scientistGraphics = [System.Drawing.Graphics]::FromImage($scientistBitmap)
$scientistGraphics.Clear([System.Drawing.Color]::LightGray)
$scientistFont = New-Object System.Drawing.Font("Arial", 16)
$scientistBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::DarkBlue)
$scientistRect = New-Object System.Drawing.RectangleF(0, 120, 400, 60)
$scientistFormat = New-Object System.Drawing.StringFormat
$scientistFormat.Alignment = [System.Drawing.StringAlignment]::Center
$scientistFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
$scientistText = "Scientist in Laboratory" + [System.Environment]::NewLine + "Testing Ingredients"
$scientistGraphics.DrawString($scientistText, $scientistFont, $scientistBrush, $scientistRect, $scientistFormat)
$scientistBitmap.Save("$imagesPath\scientist-lab.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
$scientistGraphics.Dispose()
$scientistBitmap.Dispose()

# Create Laundry Image  
$laundryBitmap = New-Object System.Drawing.Bitmap(400, 300)
$laundryGraphics = [System.Drawing.Graphics]::FromImage($laundryBitmap)
$laundryGraphics.Clear([System.Drawing.Color]::LightBlue)
$laundryFont = New-Object System.Drawing.Font("Arial", 16)
$laundryBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::DarkBlue)
$laundryRect = New-Object System.Drawing.RectangleF(0, 120, 400, 60)
$laundryFormat = New-Object System.Drawing.StringFormat
$laundryFormat.Alignment = [System.Drawing.StringAlignment]::Center
$laundryFormat.LineAlignment = [System.Drawing.StringAlignment]::Center
$laundryText = "Woman Doing Laundry" + [System.Environment]::NewLine + "Fragrance Experience"
$laundryGraphics.DrawString($laundryText, $laundryFont, $laundryBrush, $laundryRect, $laundryFormat)
$laundryBitmap.Save("$imagesPath\woman-laundry.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
$laundryGraphics.Dispose()
$laundryBitmap.Dispose()

Write-Host "Test images created successfully!"
Write-Host "Location: wwwroot/images/"
Write-Host "Files: pg-logo.png, scientist-lab.jpg, woman-laundry.jpg"

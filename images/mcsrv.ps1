# Navigate to the server directory
Set-Location server

# SportPaper and PGM setup
if (-Not (Test-Path "sportpaper.jar")) {
    # Download SportPaper jar
    Invoke-WebRequest -Uri "https://github.com/PGMDev/PGM/releases/download/v0.15/SportPaper.jar" -OutFile "sportpaper.jar"
    # Create plugins directory
    New-Item -ItemType Directory -Path "plugins"
    # Download PGM jar zip
    Invoke-WebRequest -Uri "https://nightly.link/PGMDev/PGM/workflows/deploy/dev/PGM.jar.zip" -OutFile "PGM.jar.zip"
    # Unzip PGM jar
    Expand-Archive -Path "PGM.jar.zip" -DestinationPath "."
    # Move PGM jar to plugins directory
    Move-Item -Path "PGM.jar" -Destination "plugins"
    # Remove the zip file
    Remove-Item -Path "PGM.jar.zip"
}

# Mars
Copy-Item -Path "/workspace/mars/build/libs/Mars-*-SNAPSHOT-all.jar" -Destination "plugins"

# Mars Config
New-Item -ItemType Directory -Path "plugins/Mars" -Force
if (-Not (Test-Path "plugins/Mars/config.yml")) {
    # Copy the Mars configuration file
    Copy-Item -Path "/workspace/config/config.yml" -Destination "plugins/Mars/config.yml"
}

# Run the server
Start-Process "java" -ArgumentList "-jar", "sportpaper.jar"

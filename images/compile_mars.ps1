if (-Not (Test-Path "mars/.git")) {
    git clone https://github.com/Warzone/mars.git mars
    Set-Location mars
    git checkout -b pgm-0.16 origin/pgm-0.16
    # Checkout commit with no achievements
    git checkout 3c1ea9f275a5129fada75a697d50aeefc6340fe9
    Set-Location ..
}
Set-Location mars
./gradlew --console=plain shadowJar

if (-Not (Test-Path "api/.git")) {
    # Clone the Git repository into 'api' directory
    git clone https://github.com/Warzone/mars-api-rs.git api
}
Set-Location api
cargo build

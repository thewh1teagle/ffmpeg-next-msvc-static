# Download pre build ffmpeg based on https://github.com/wang-bin/avbuild
$name = "ffmpeg-6.1-windows-desktop-vs2022ltl-default"
$url = "https://yer.dl.sourceforge.net/project/avbuild/windows-desktop/$name.7z"
$archivePath = "$name.7z"
$env:FFMPEG_DIR = "$(Get-Location)\ffmpeg"
$env:LIBCLANG_PATH = "C:\Program Files\LLVM\bin"

# Check if the directory already exists
if (-not (Test-Path $env:FFMPEG_DIR)) {
    # Download the archive
    Start-BitsTransfer -Source $url -Destination $archivePath
    # Extract the archive
    & "C:\Program Files\7-Zip\7z.exe" x $archivePath
    # rename to ffmpeg
    Move-Item -Path $name -Destination $env:FFMPEG_DIR
    # move lib/x64/ to lib/
    Copy-Item -Recurse -Path "$env:FFMPEG_DIR\lib\x64\*" -Destination "$env:FFMPEG_DIR\lib\" -ErrorAction SilentlyContinue
    Remove-Item -Path $archivePath
}
# Build the project in release mode 
cargo build --release

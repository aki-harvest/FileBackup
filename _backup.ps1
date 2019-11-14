Write-Host バックアップ処理を開始します.
Set-Location (Convert-Path .)
# ==================================================変数群

# カレントディレクトリ
$CurrentDirectory = (Convert-Path .)

# ==================================================ファイルパス(ファイル名・手動入力)

# コピー元の[ファイル名]
$fromFileName = "拡張子込みでファイル名を入力する"

# コピー先の[フォルダ名]
$toDirName = "コピー先のフォルダ名を入力する"

# ==================================================ファイルパス(変換処理・自動生成)

# コピー元の[ファイルパス](絶対パス)
$fromFilePath = (Join-Path $CurrentDirectory $fromFileName)

# コピー先の[フォルダパス](絶対パス)
$toDirPath = (Join-Path $CurrentDirectory $toDirName)

# ==================================================ファイルパス(変換処理・自動生成)

# コピー元の[ファイル名](拡張子なし)
$fileBaseName = (Get-ChildItem $fromFilePath).BaseName

# コピー元の[ファイル名](拡張子のみ)
$fileExtension = (Get-ChildItem $fromFilePath).Extension

# コピー後の[ファイル名](コピー元ファイル名 + yyyyMMdd + 拡張子)
$afterFileName = $fileBaseName + (Get-Date -Format "yyyyMMdd") + $fileExtension
# ==================================================コピー処理
# バックアップ先のフォルダに、既にファイルが存在している場合は処理を終了する。
# バックアップ前のファイル名と同じファイルが存在している場合
if(Test-Path (Join-Path $toDirPath $fromFileName)){
    Write-Host バックアップ先のフォルダに、既に[$fromFileName]が存在します.
    Write-Host バックアップ処理を終了します.
    Read-Host 続けるにはEnterキーを押してください...
    exit
}

# 本日、既にバックアップを行っていた場合
if(Test-Path (Join-Path $toDirPath $afterFileName)){
    while(1){
        Write-Host 本日は既にバックアップを行っており, 下記のファイルが存在します.
        Write-Host [$afterFileName]
        $res = Read-Host "本日分のバックアップファイルを削除しますか？(y/n)"
        if($res = "y"){
            Remove-Item (Join-Path $toDirPath $afterFileName)
            Write-Host 削除が完了しました.
            Write-Host バックアップ処理を続行します...
            break
        }else{
            Write-Host バックアップ処理を終了します.
            Read-Host 続けるにはEnterキーを押してください...
            exit
        }
    }
}


# ファイルをコピーする
Copy-Item $fromFilePath $toDirPath
Write-Host ファイルのコピーに成功しました. `r`n

# バックアップディレクトリに移動
Set-Location $toDirName

# ファイル名変更 (変更前ファイル名 + yyyyMMdd + 拡張子)
Rename-Item (Join-Path $toDirPath $fromFileName) $afterFileName

Write-Host バックアップ処理が終了しました.
Read-Host 続けるにはEnterキーを押してください...
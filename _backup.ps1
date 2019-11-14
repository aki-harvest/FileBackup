Write-Host �o�b�N�A�b�v�������J�n���܂�.
Set-Location (Convert-Path .)
# ==================================================�ϐ��Q

# �J�����g�f�B���N�g��
$CurrentDirectory = (Convert-Path .)

# ==================================================�t�@�C���p�X(�t�@�C�����E�蓮����)

# �R�s�[����[�t�@�C����]
$fromFileName = "�g���q���݂Ńt�@�C��������͂���"

# �R�s�[���[�t�H���_��]
$toDirName = "�R�s�[��̃t�H���_������͂���"

# ==================================================�t�@�C���p�X(�ϊ������E��������)

# �R�s�[����[�t�@�C���p�X](��΃p�X)
$fromFilePath = (Join-Path $CurrentDirectory $fromFileName)

# �R�s�[���[�t�H���_�p�X](��΃p�X)
$toDirPath = (Join-Path $CurrentDirectory $toDirName)

# ==================================================�t�@�C���p�X(�ϊ������E��������)

# �R�s�[����[�t�@�C����](�g���q�Ȃ�)
$fileBaseName = (Get-ChildItem $fromFilePath).BaseName

# �R�s�[����[�t�@�C����](�g���q�̂�)
$fileExtension = (Get-ChildItem $fromFilePath).Extension

# �R�s�[���[�t�@�C����](�R�s�[���t�@�C���� + yyyyMMdd + �g���q)
$afterFileName = $fileBaseName + (Get-Date -Format "yyyyMMdd") + $fileExtension
# ==================================================�R�s�[����
# �o�b�N�A�b�v��̃t�H���_�ɁA���Ƀt�@�C�������݂��Ă���ꍇ�͏������I������B
# �o�b�N�A�b�v�O�̃t�@�C�����Ɠ����t�@�C�������݂��Ă���ꍇ
if(Test-Path (Join-Path $toDirPath $fromFileName)){
    Write-Host �o�b�N�A�b�v��̃t�H���_�ɁA����[$fromFileName]�����݂��܂�.
    Write-Host �o�b�N�A�b�v�������I�����܂�.
    Read-Host ������ɂ�Enter�L�[�������Ă�������...
    exit
}

# �{���A���Ƀo�b�N�A�b�v���s���Ă����ꍇ
if(Test-Path (Join-Path $toDirPath $afterFileName)){
    while(1){
        Write-Host �{���͊��Ƀo�b�N�A�b�v���s���Ă���, ���L�̃t�@�C�������݂��܂�.
        Write-Host [$afterFileName]
        $res = Read-Host "�{�����̃o�b�N�A�b�v�t�@�C�����폜���܂����H(y/n)"
        if($res = "y"){
            Remove-Item (Join-Path $toDirPath $afterFileName)
            Write-Host �폜���������܂���.
            Write-Host �o�b�N�A�b�v�����𑱍s���܂�...
            break
        }else{
            Write-Host �o�b�N�A�b�v�������I�����܂�.
            Read-Host ������ɂ�Enter�L�[�������Ă�������...
            exit
        }
    }
}


# �t�@�C�����R�s�[����
Copy-Item $fromFilePath $toDirPath
Write-Host �t�@�C���̃R�s�[�ɐ������܂���. `r`n

# �o�b�N�A�b�v�f�B���N�g���Ɉړ�
Set-Location $toDirName

# �t�@�C�����ύX (�ύX�O�t�@�C���� + yyyyMMdd + �g���q)
Rename-Item (Join-Path $toDirPath $fromFileName) $afterFileName

Write-Host �o�b�N�A�b�v�������I�����܂���.
Read-Host ������ɂ�Enter�L�[�������Ă�������...
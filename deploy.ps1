# huashu-motion 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/alchaincyf/huashu-motion#安装
# 更新日期：2026-11-02
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

npx skills add alchaincyf/huashu-motion
Write-Host "装好后对 agent 说：用 huashu-motion 给我的产品做一支 30 秒发布片"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/alchaincyf/huashu-motion#安装'

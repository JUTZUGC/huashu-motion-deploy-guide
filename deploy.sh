#!/usr/bin/env bash
set -euo pipefail
# huashu-motion 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/alchaincyf/huashu-motion#安装
# 更新日期：2026-11-02
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

npx skills add alchaincyf/huashu-motion
echo "装好后对 agent 说：用 huashu-motion 给我的产品做一支 30 秒发布片"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/alchaincyf/huashu-motion#安装"

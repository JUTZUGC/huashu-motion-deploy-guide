# huashu-motion 一键安装指南

> 第三方部署指南 · 非 huashu-motion 官方仓库。官方项目：[alchaincyf/huashu-motion](https://github.com/alchaincyf/huashu-motion)
> 内容来自官方文档（2026-11-02）。项目迭代快，请以[官方文档](https://github.com/alchaincyf/huashu-motion#安装)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 这是 Agent Skill，不是服务。需要 Node 22+、本机 Chrome/Chromium/Edge 与 FFmpeg：渲染、截帧和导出都直接驱动你已装的浏览器。渲染按 CPU 核数并行，机器弱时较慢。4 秒以上的片子默认在结尾加一行「Made with huashu-motion」，可以关掉。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/huashu-motion-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会用 skills CLI 装好 huashu-motion 技能，并检查 Node、Chrome 与 FFmpeg，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## huashu-motion 是什么？

huashu-motion 是开源的说一句产品是什么，agent 自己写分镜、做动画、作曲，还能指着画面改（协议：MIT，<img src="https://img.shields.io/github/stars/alchaincyf/huashu-motion?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

让 coding agent 制作产品发布片：先读产品出三个方向的关键帧，再写节奏单，逐帧生成动画、现场作曲配乐并加音效，最后导出 MP4、透明 MOV、WebM 或 GIF。

- 一句话出片：从产品信息到 30 秒发布片
- 指着画面改：按帧提意见，不必重写提示词
- 现场作曲：按节奏单生成配乐与音效
- 多格式导出：MP4、透明 MOV、WebM、GIF
- 透明叠层：可直接拖进剪映或 Premiere
- MIT，技能与脚本都可改

（来源：[官方仓库](https://github.com/alchaincyf/huashu-motion)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 2040 stars | 名称搜索仅 11 条结果 |
| 从分镜到作曲一条链 | — |
| 可按帧提意见 | 改动成本低 |
| 导出格式覆盖视频与叠层 | — |
| 本地渲染 | 不按次调用收费接口 |
| MIT | 技能可改 |

| 需要注意 | 说明 |
|---|---|
| 依赖 Node 22+、Chrome 与 FFmpeg | — |
| 渲染吃 CPU | 弱机器慢 |
| 成片质量取决于提示与审美 | — |
| 默认带片尾小字 | 需要手动关 |
| 项目很新 | 脚本接口可能变 |

> 以上基于官方文档与社区反馈整理（2026-11-02），以官方最新文档为准。

## 快速部署（官方方式）

```bash
npx skills add alchaincyf/huashu-motion
echo "装好后对 agent 说：用 huashu-motion 给我的产品做一支 30 秒发布片"
```

部署步骤来源：[https://github.com/alchaincyf/huashu-motion#安装](https://github.com/alchaincyf/huashu-motion#安装)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 Node 22+、Chrome 与 FFmpeg 依赖 | 已核对 2026-11-02 |
| 确认导出格式、片尾水印与本地作曲方式 | 已核对 2026-11-02 |
| 未实测安装与出片 | 说明 2026-11-02 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-02 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-02 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

以 Agent Skill 形式接入 Claude Code、Codex 等客户端，本身不含 MCP；本仓库的 MCP 只提供安装步骤、依赖与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-02）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\huashu-motion-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 先装依赖

```powershell
winget install OpenJS.NodeJS.LTS
winget install Gyan.FFmpeg
```

Chrome、Chromium 或 Edge 任选其一，保持可执行文件在默认位置。

## 怎么用

1. 对 agent 说清楚产品与目标时长
2. 它会先读产品，给三个方向的关键帧
3. 选定方向后写节奏单，再逐帧生成画面
4. 配乐与音效在本机生成，不调收费接口
5. 打开内置编辑器，指着某一帧提修改意见

## 导出

| 格式 | 用途 |
|---|---|
| MP4 | 发布片、社交平台 |
| 透明 MOV | 剪映 / Premiere 叠层 |
| WebM | 网页嵌入 |
| GIF | README 头图与预览 |

`om share` 还会生成一个 10 MB 以内的 GIF 与分享文案。

## 注意

- 必须用本机 Chrome 渲染，无头环境要先装浏览器
- 慢机器渲染时间长，可先做 10 秒短片验证风格
- 4 秒以上默认带片尾小字，可让 agent 关掉
- 配乐用合成音色时不需要额外采样包
- 素材版权与商用授权由使用者自行确认

## 常见坑

- 技能找不到：确认装到了当前 agent 客户端并重开会话
- 渲染失败：检查 Chrome 是否在默认路径、能否被无头启动
- 导出没有声音：先确认 FFmpeg 在 PATH，配乐是否生成成功
- 渲染很慢：减少并行浏览器数，或先做短片
- 字体不对：系统缺少片中字体，换字体或让 agent 用本机字体
- 想关片尾：直接告诉 agent 去掉 Made with 水印
- 素材来源不明：发布前确认图片、音乐与字体的授权

## 免责声明

本仓库为第三方指南，与 huashu-motion 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-02），项目迭代快，请以[官方文档](https://github.com/alchaincyf/huashu-motion#安装)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。

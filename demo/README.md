# Demo — 评审 HTML 与原型 Demo

本目录汇集所有评审 HTML、原型 demo，作为产品评审、开发对齐、上线前 review 的本地展示入口。

## 目录结构

```text
demo/
├── index.html                       Demo Hub 入口（评审 + 原型 demo 集合）
├── spec-review-2026-05-15.html      2026-05-15 需求评审 HTML
├── app.html                         移动端 App Demo（本地备份）
├── admin.html                       运营管理后台 Demo（本地备份）
└── README.md                        本文件
```

图片资源**不在 demo 下复制**，HTML 直接通过相对路径 `../asset/...` 引用仓库根的 `asset/` 目录（单一真相源，避免维护两份图片不一致）：

```text
asset/
├── flowchart/                       流程图（业务流程 / 页面流程）
└── prototype/                       原型截图（圈子首页 / 提问页 / ...）
```

## 本地查看

直接用浏览器打开任何一个 HTML 即可（双击文件 / 拖入浏览器）：

- `demo/index.html` — Demo Hub 入口
- `demo/spec-review-2026-05-15.html` — 需求评审单文件 HTML

或起一个本地静态服务器看完整跳转效果：

```bash
python3 -m http.server 8080
# 浏览器访问 http://localhost:8080/demo/
```

## 新增评审 HTML 的流程

由 `spec-review` skill 生成新评审 HTML 时：

1. 输出到 `demo/spec-review-{YYYY-MM-DD}.html`
2. 引用图片用 `../asset/...`（**不要**复制图片到 demo 目录）
3. 在 `demo/index.html` 的卡片列表追加链接（相对路径，如 `spec-review-{date}.html`），把"最新"徽章移到新版本上、旧版徽章移除
4. 引用的图片必须真实存在于仓库根 `asset/<子目录>/` 下

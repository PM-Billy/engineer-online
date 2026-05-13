---
doc_type: "ui_design"
version: "1.0.0"
updated: "2026-05-13"
scope: "Engineer Online 5.1~5.9"
---

# Engineer Online — UI 设计

> **用途**：定义本次需求的业务组件规格和页面模板，驱动前端（Flutter / H5 / 管理后台）页面开发。
>
> **关联文档**：
> - 公共 Design Token 和原子组件：`standard/UI设计规范.md` §1-2
> - 各模块页面元素定义：`requirement/modules/05.x-xxx.md` §5.x.2
> - 原型截图：`asset/prototype/`

---

## 1. Overview（概述）

本文档定义 Engineer Online 功能的 UI 方案，包含业务组件规格和页面模板。

**设计原则**：
- 所有颜色/字号/间距/圆角引用 `standard/UI设计规范.md` 第 1 章 Design Token
- 同一业务组件在 Flutter 和 H5 中视觉一致
- 管理后台遵循 GAC 运营管理后台现有风格

**技术分布**：

| 页面 | 技术 | 对应模块 |
|---|---|---|
| 首页 | Flutter | 5.2 |
| 提问页 | Flutter | 5.3 |
| 问题详情页 | H5 (Vue 3 + Vant) | 5.4 |
| 搜索页 | Flutter | 5.5 |
| 消息通知页 | Flutter | 5.6 |
| 管理后台 | Vue 3 + Ant Design Vue | 5.1/5.7/5.8/5.9 |

---

## 2. Business Components（业务组件）
### 2.1 问题卡片 QuestionCard

```typescript
interface QuestionCardProps {
  question: {
    id: number;
    title: string;
    summary?: string;         // 描述摘要，最多3行
    images: string[];         // 图片URL，最多显示3张缩略图
    author: {
      id: number;
      nickname: string;
      avatar: string;
    };
    answerPreview?: {         // 回答预览，灰色背景区域
      author: {
        nickname: string;
        avatar: string;
        isOfficial: boolean;
        brandLabel?: string;  // 如 "GAC"
        position?: string;    // 如 "Product Manager"
      };
      summary: string;        // 回答摘要，最多3行
      isAdopted: boolean;     // 是否已采纳
    };
    createdAt: string;        // ISO 8601，显示相对时间
    answerCount: number;
    isHot?: boolean;          // 是否热门
  };
  highlightKeyword?: string;  // 搜索高亮关键词
  onPress?: (questionId: number) => void;
}
```

**布局结构**:
```
┌─────────────────────────────────────────┐
│ [Avatar] Author Name                    │  ← 作者区，高度48px
├─────────────────────────────────────────┤
│ Question Title (bold, 2 lines max)      │  ← 标题区
│ Summary text (gray, 3 lines max)        │  ← 摘要区（可选）
├─────────────────────────────────────────┤
│ [Img1] [Img2] [Img3]                    │  ← 图片区，最多3张，100px高
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ [Avatar+V] Wayne [GAC]    [Adopt] │ │  ← 回答预览区，背景 #F5F5F5
│ │ Answer summary text...            │ │
│ └─────────────────────────────────────┘ │
├─────────────────────────────────────────┤
│ 2 days ago              💬 6            │  ← 元数据区
└─────────────────────────────────────────┘
```

**样式规格**:

| 区域 | 属性 | 值 |
|------|------|-----|
| 卡片容器 | 背景 | --color-bg-white |
| | 圆角 | 0（列表项无圆角）或 radius-md（独立卡片） |
| | 下边框 | 1px solid --color-divider |
| | padding | 16px |
| 作者头像 | 尺寸 | 40px |
| | 圆角 | 圆形 |
| 作者昵称 | 字体 | 14px / 500 / --color-text-primary |
| 标题 | 字体 | 16px / 500 / --color-text-primary |
| | 行数 | 最多2行，超出省略 |
| 摘要 | 字体 | 14px / 400 / --color-text-tertiary |
| | 行数 | 最多3行，超出省略 |
| 图片 | 尺寸 | 100px × 100px |
| | 圆角 | radius-md (8px) |
| | 间距 | 8px |
| 回答预览区 | 背景 | #F5F5F5（或 --color-bg-card） |
| | 圆角 | radius-md (8px) |
| | padding | 12px |
| | 上边距 | 12px |
| 工程师头像 | 尺寸 | 32px |
| | V徽章 | 12px，右下角 |
| 工程师昵称 | 字体 | 14px / 500 / --color-text-primary |
| 品牌标签 | 紧跟昵称 | BrandLabel组件 |
| Adopt标记 | 位置 | 预览区右上角 |
| 回答摘要 | 字体 | 14px / 400 / --color-text-tertiary |
| | 行数 | 最多3行 |
| 时间 | 字体 | 12px / 400 / --color-text-tertiary |
| 评论数 | 图标 | 气泡图标 + 数字 |
| | 字体 | 12px / 400 / --color-text-tertiary |

**搜索高亮**:
- 匹配关键词用 `<mark>` 包裹
- 样式：color: --color-search-highlight，background: transparent，font-weight: 500

### 2.2 回答卡片 AnswerCard

```typescript
interface AnswerCardProps {
  answer: {
    id: number;
    content: string;
    images?: string[];        // 最多3张缩略图
    author: {
      id: number;
      nickname: string;
      avatar: string;
      isOfficial: boolean;
      brandLabel?: string;
      position?: string;       // 职位
    };
    isAccepted: boolean;
    isAuthor: boolean;        // 当前用户是否是问题作者（控制Accept按钮）
    upvoteCount: number;
    downvoteCount: number;
    userVote?: 'up' | 'down' | null;  // 当前用户投票状态
    createdAt: string;
    replies?: Reply[];        // 嵌套回复
  };
  onAccept?: (answerId: number) => void;
  onVote?: (answerId: number, type: 'up' | 'down') => void;
  onReply?: (answerId: number) => void;
  onTranslate?: (answerId: number) => void;
}
```

**布局结构**:
```
┌─────────────────────────────────────────┐
│ [Avatar+V] Wayne  [GAC] [Product Mgr]   │  ← 回答者信息
│ [Accept] (仅问题作者可见)               │
├─────────────────────────────────────────┤
│ Answer content text...                  │  ← 回答内容
│ [Img1] [Img2]                           │  ← 回答图片
├─────────────────────────────────────────┤
│ 2 days ago                              │
├─────────────────────────────────────────┤
│ Reply  ·  Translate  ·  👍 12  ·  👎 3  │  ← 操作栏
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ [Avatar] Author ▸ Wayne              │ │  ← 嵌套回复
│ │ Reply content...                     │ │
│ │ 2h ago  ·  Reply  ·  👍 2            │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**样式规格**:

| 区域 | 属性 | 值 |
|------|------|-----|
| 卡片容器 | padding | 16px |
| | 下边框 | 1px solid --color-divider |
| 回答者头像 | 尺寸 | 40px |
| V徽章 | 尺寸 | 16px |
| 昵称 | 字体 | 14px / 500 |
| 品牌标签 | 紧跟昵称 | BrandLabel |
| 职位 | 字体 | 12px / 400 / --color-text-tertiary |
| Accept按钮 | 位置 | 右侧 |
| | 样式 | 主按钮 small |
| | 文字 | "Accept" |
| 内容 | 字体 | 14px / 400 / --color-text-secondary |
| | 行高 | 1.6 |
| 图片 | 尺寸 | 120px × 120px |
| | 圆角 | radius-md |
| 时间 | 字体 | 12px / --color-text-tertiary |
| 操作栏 | 布局 | flex，space-between |
| | 字体 | 14px / 400 / --color-text-tertiary |
| | 点击态 | 颜色变为 --color-primary |
| 投票按钮 | 图标 | 👍 / 👎 |
| | 数字 | 图标右侧 |
| | 已投态 | 图标和数字变为 --color-primary |
| 嵌套回复 | 背景 | transparent |
| | 左边距 | 48px（与头像对齐） |
| | 左边线 | 可选，2px solid --color-divider |
| 回复关系 | 格式 | "Wayne ▸ Billy" |
| Author标签 | 颜色 | --color-author-tag |
| | 字体 | 12px / 500 |

### 2.3 官方号标识 OfficialAccountHeader

```typescript
interface OfficialAccountHeaderProps {
  author: {
    nickname: string;
    avatar: string;
    brandLabel: string;       // 如 "GAC"
    position: string;         // 如 "Engineer" / "Product Manager"
  };
  size?: 'small' | 'medium' | 'large';
}
```

**样式规格**:

| 尺寸 | 头像 | V徽章 | 昵称 | 标签 |
|------|------|-------|------|------|
| small | 32px | 12px | 14px/500 | 10px |
| medium | 40px | 16px | 16px/500 | 10px |
| large | 48px | 20px | 18px/500 | 12px |

**布局**:
```
[Avatar+V]  Wayne  [GAC]  Product Manager
```
- 头像和昵称间距：8px
- 昵称和品牌标签间距：8px
- 品牌标签和职位间距：8px
- 职位颜色：--color-text-tertiary

### 2.4 通知卡片 NotificationCard

```typescript
interface NotificationCardProps {
  notification: {
    id: number;
    type: 'SYSTEM_MESSAGE';
    title: string;
    content: string;
    isRead: boolean;
    createdAt: string;
    targetId?: number;        // 关联的问题ID等
  };
  onPress?: (notification: Notification) => void;
}
```

**样式规格**:

| 属性 | 值 |
|------|-----|
| 容器 | padding 16px，下边框 1px solid --color-divider |
| 未读标识 | 左侧4px宽竖线，--color-primary，或标题前红色圆点8px |
| 标题 | 16px / 500 / --color-text-primary（未读）/ --color-text-secondary（已读） |
| 内容 | 14px / 400 / --color-text-tertiary，最多2行 |
| 时间 | 12px / 400 / --color-text-quaternary |
| 点击态 | 背景 --color-bg-page |

### 2.5 搜索结果卡片 SearchResultCard

```typescript
interface SearchResultCardProps {
  result: {
    questionId: number;
    title: string;
    summary: string;
    thumbnail?: string;       // 第一张图片缩略图
    answerAuthor?: {
      nickname: string;
      avatar: string;
    };
    answerTime: string;
    commentCount: number;
  };
  keyword: string;            // 高亮关键词
  onPress?: (questionId: number) => void;
}
```

**样式规格**:

| 属性 | 值 |
|------|-----|
| 容器 | padding 16px，下边框 |
| 布局 | 左侧文字，右侧缩略图（如有） |
| 标题 | 16px / 500，最多2行，关键词红色高亮 |
| 摘要 | 14px / 400 / --color-text-tertiary，最多3行，关键词红色高亮 |
| 缩略图 | 80px × 80px，radius-md，右侧 |
| 回答者 | 头像24px + 昵称12px |
| 时间 | 12px / --color-text-quaternary |
| 评论数 | 气泡图标 + 数字，12px |

---


---

## 3. Page Templates（页面模板）
### 3.1 首页（问题列表）

**页面结构**:
```
┌─────────────────────────────────────────┐
│ ←  Engineer Online            🔍        │  ← 导航栏，高度44px
├─────────────────────────────────────────┤
│ [Logo] Engineer Online                  │  ← 品牌区
│ Online engineers provide... [Learn more]│
├─────────────────────────────────────────┤
│ 12k        24k         39               │  ← 统计区
│ Cumulative Cumulative  Today's          │
│ Questions  Replies     Post             │
├─────────────────────────────────────────┤
│ Hot    │  Newest  │  My Question        │  ← Tab栏，高度44px
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ QuestionCard 1                      │ │  ← 列表区
│ ├─────────────────────────────────────┤ │
│ │ QuestionCard 2                      │ │
│ └─────────────────────────────────────┘ │
├─────────────────────────────────────────┤
│         [    Ask a Question    ]        │  ← 底部固定按钮
└─────────────────────────────────────────┘
```

**各区域规格**:

#### 导航栏 AppHeader

```typescript
interface AppHeaderProps {
  title?: string;
  showBack?: boolean;
  showSearch?: boolean;
  onBack?: () => void;
  onSearch?: () => void;
}
```

| 属性 | 值 |
|------|-----|
| 高度 | 44px（不含状态栏） |
| 背景 | --color-bg-white |
| 下边框 | 1px solid --color-divider（滚动后显示） |
| 返回按钮 | 左侧，箭头图标，24px |
| 标题 | 居中，16px / 500 / --color-text-primary |
| 搜索图标 | 右侧，24px |

#### 品牌区 BrandSection

| 属性 | 值 |
|------|-----|
| 背景 | --color-bg-white |
| padding | 16px |
| Logo | 左侧，48px × 48px，radius-md |
| 名称 | 右侧，18px / 600 / --color-text-primary |
| 简介 | 右侧，14px / 400 / --color-text-tertiary |
| Learn more | 简介中的链接，--color-primary |

#### 统计区 StatsSection

| 属性 | 值 |
|------|-----|
| 布局 | flex，三等分 |
| 背景 | --color-bg-white |
| 上边框 | 1px solid --color-divider |
| padding | 16px 0 |
| 数字 | 24px / 600 / --color-text-primary，font-family-number |
| 标签 | 12px / 400 / --color-text-tertiary |
| 数字格式化 | >1000: "1.2k", >100万: "1.2M" |

#### Tab栏 TabBar

| 属性 | 值 |
|------|-----|
| 高度 | 44px |
| 背景 | --color-bg-white |
| 布局 | flex，三等分 |
| 文字 | 14px / 500 |
| 未选中 | --color-text-quaternary |
| 选中 | --color-text-primary |
| 指示器 | 底部2px线，--color-text-primary，宽度与文字等宽 |
| 动画 | 切换时指示器滑动过渡，300ms ease |

### 3.2 提问页 AskQuestionPage

**页面结构**:
```
┌─────────────────────────────────────────┐
│ ←  Ask a Question              [Post]   │  ← 导航栏
├─────────────────────────────────────────┤
│ Title *                                 │
│ ┌─────────────────────────────────────┐ │
│ │ Enter a title                       │ │  ← 标题输入
│ └─────────────────────────────────────┘ │
├─────────────────────────────────────────┤
│ Description (Optional)                  │
│ ┌─────────────────────────────────────┐ │
│ │ Please describe the issue...        │ │  ← 描述输入
│ └─────────────────────────────────────┘ │
├─────────────────────────────────────────┤
│ [+] [Img1] [Img2] ...                   │  ← 图片上传
├─────────────────────────────────────────┤
│ Vehicle              AION V        >    │  ← 导航项
├─────────────────────────────────────────┤
│ Total Mileage        1203km        >    │  ← 导航项
└─────────────────────────────────────────┘
```

**Post按钮状态**:
- 标题为空：禁用态，背景 --color-disabled
- 标题有内容：启用态，背景 --color-primary
- 点击后loading态

### 3.3 问题详情页 QuestionDetailPage

**页面结构**:
```
┌─────────────────────────────────────────┐
│ ←  [Share]                              │  ← 导航栏
├─────────────────────────────────────────┤
│ [Avatar] Car Owner                      │  ← 问题作者
├─────────────────────────────────────────┤
│ Question Title                          │  ← 标题
│ Question content...                     │  ← 内容
│ [Img1] [Img2] [Img3]                    │  ← 图片
├─────────────────────────────────────────┤
│ Model: AION V    2025/9/20 18:32        │  ← 车型+时间
├─────────────────────────────────────────┤
│ Translate    [Delete]                   │  ← 操作栏
├─────────────────────────────────────────┤
│ Answers (209)                           │  ← 回答标题
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ AnswerCard 1                        │ │  ← 回答列表
│ ├─────────────────────────────────────┤ │
│ │ AnswerCard 2                        │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**操作栏**:
- Translate: 文字按钮，--color-primary
- Delete: 文字按钮，danger，仅作者/管理员可见，垃圾桶图标
- Share: 导航栏右上角

### 3.4 搜索页 SearchPage

**页面结构**:
```
┌─────────────────────────────────────────┐
│ ┌───────────────────────────────────┐ [Cancel] │
│ │ 🔍 Search...                      │        │  ← 搜索输入
│ └───────────────────────────────────┘        │
├─────────────────────────────────────────┤
│ Search Result                           │
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ SearchResultCard 1                  │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**搜索输入框**:

| 属性 | 值 |
|------|-----|
| 高度 | 40px |
| 背景 | --color-bg-page |
| 圆角 | radius-full |
| 图标 | 左侧搜索图标，--color-text-quaternary |
| 占位符 | "Search..." |
| 取消按钮 | 右侧，14px / --color-primary |
| 自动聚焦 | 进入页面自动获取焦点 |
| 回车触发 | 搜索 |

### 3.5 消息通知页 MessagesPage

**页面结构**:
```
┌─────────────────────────────────────────┐
│ ←  Messages              [🗑️]           │  ← 导航栏
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ ● Engineer reply notification       │ │  ← 通知卡片
│ │ Wayne has replied to your question... │ │
│ │ 2 hours ago                         │ │
│ └─────────────────────────────────────┘ │
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │ ○ Activity notification             │ │  ← 已读通知
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

### 3.6 运营管理后台页面

> **设计基准**：以现有 GAC 运营管理后台 UI 为基准，确保新增模块（问题管理 / 回答管理 / 圈子管理）与已有模块视觉一致。

#### 3.6.1 布局框架

```
┌─────────────────────────────────────────────────────────┐
│ 🍔  GAC Logo    中国香港          🌐 简体中文  👤 admin  🚪退出 │  ← 顶部栏 (64px)
├──────────┬──────────────────────────────────────────────┤
│ 🏠 首页   │ 首页 > 内容管理 > 问题管理                     │  ← 面包屑
│ 📊 数据看板│                                              │
│ 📁 公共模块▾│ 问题管理                                      │  ← 页面标题
│ 📁 运营管理▾├──────────────────────────────────────────────┤
│   👤 用户管理│ 手机号  邮箱  昵称  状态  ...   [🔍搜索] [重置]│  ← 筛选区
│     注册用户├──────────────────────────────────────────────┤
│ 📁 内容管理▾│ 序号  标题  发帖人  状态  时间  操作           │  ← 表格区
│     ❓问题管理│ 1   xxx   GA***  待审核  xx    [查看][更多▼]  │
│     💬回答管理│ 2   xxx   Th***  已通过  xx    [查看][更多▼]  │
│ 📁 车辆管理▾├──────────────────────────────────────────────┤
│ ⚙️ 系统管理▾│                    < 1 2 3 ... 10 >           │  ← 分页
└──────────┴──────────────────────────────────────────────┘
```

#### 3.6.2 顶部栏 Header

| 属性 | 值 | 说明 |
|------|-----|------|
| 高度 | 64px | — |
| 背景 | #FFFFFF | 纯白 |
| 下边框 | 1px solid #f0f0f0 | — |
| **左侧** | | |
| 汉堡菜单 | 图标 20px，#333 | 折叠/展开侧边栏 |
| GAC Logo | 高度 32px，左侧距 16px | 品牌标识 |
| 地区标识 | "中国香港"，14px / #333，Logo 右侧 24px | 当前运营地区 |
| **右侧** | | |
| 语言切换 | 🌐 地球图标 + "简体中文"，14px / #666 | 点击展开语言选项 |
| 用户区 | 头像 32px 圆形 + 昵称 "admin" + 下拉箭头 | 点击展开用户菜单 |
| 退出登录 | 🚪 图标 + "退出登录"，14px / #666 | 右侧距 24px |

#### 3.6.3 侧边栏 Sidebar

| 属性 | 值 | 说明 |
|------|-----|------|
| 宽度 | 200px | — |
| 背景 | #F5F5F5 或 #FAFAFA | 浅灰色（非深色） |
| 文字 | 14px / #333333 | 深灰色 |
| 分组标题 | 12px / #999999，大写或加粗 | 如 "内容管理" |
| **菜单项** | | |
| 高度 | 40px | 单行 |
| 内边距 | 0 16px 0 24px | 左侧缩进区分层级 |
| 图标 | 16px，#666666 | Ant Design 图标，与文字间距 8px |
| 悬停 | 背景 #E8E8E8 | — |
| **选中态** | | |
| 背景 | #E6F7FF | 浅蓝背景 |
| 左边框 | 3px solid #009EFF | 蓝色指示条 |
| 文字 | #009EFF | 主色高亮 |
| 折叠箭头 | ▾ / ▶，12px / #999 | 分组展开/收起 |

> **层级缩进规则**：一级菜单无缩进；二级菜单左缩进 16px；三级菜单左缩进 32px。

#### 3.6.4 面包屑 Breadcrumb

| 属性 | 值 | 说明 |
|------|-----|------|
| 位置 | 内容区顶部，筛选区上方 | — |
| 字体 | 14px / #666666 | — |
| 分隔符 | ">" 或 "/"，两侧间距 8px | — |
| 当前项 | #333333，无下划线 | 不可点击 |
| 可点击项 | #009EFF，hover 下划线 | 跳转上一级 |

#### 3.6.5 页面标题 Page Title

| 属性 | 值 | 说明 |
|------|-----|------|
| 字体 | 20px / 500 / #191A1D | — |
| 下边距 | 20px | 与筛选区间距 |
| 位置 | 面包屑下方 | — |

#### 3.6.6 筛选区 Filter Area

| 属性 | 值 | 说明 |
|------|-----|------|
| 背景 | #FFFFFF | 与表格区同容器或独立卡片 |
| 内边距 | 16px 24px | — |
| 下边距 | 16px | 与表格区间距 |
| **布局** | | |
| 列数 | 4~5 列等宽 | 视字段数量自适应 |
| 行间距 | 16px | 字段间垂直间距 |
| 列间距 | 16px | 字段间水平间距 |
| **输入框 / Select** | | |
| 高度 | 32px | Ant Design 默认 small |
| 边框 | 1px solid #d9d9d9 | — |
| 圆角 | 4px | — |
| 占位符 | 12px / #999999 | — |
| **按钮组** | | |
| 位置 | 筛选字段右侧或下方右对齐 | — |
| 搜索按钮 | 主按钮样式，高度 32px，🔍图标 + "搜索" | — |
| 重置按钮 | 默认按钮样式，高度 32px，↻图标 + "重置" | — |

#### 3.6.7 表格区 Table Area

| 属性 | 值 | 说明 |
|------|-----|------|
| 背景 | #FFFFFF | — |
| 内边距 | 0（表格自带）或 16px 24px | — |
| 表格行高 | 54px | — |
| **表头** | | |
| 背景 | #FAFAFA | 浅灰 |
| 字体 | 14px / 500 / #333333 | 加粗 |
| 边框 | 底部 1px solid #f0f0f0 | — |
| **数据行** | | |
| 字体 | 14px / 400 / #333333 | — |
| 边框 | 底部 1px solid #f0f0f0 | — |
| 悬停 | 背景 #F5F5F5 | — |
| **操作列** | | |
| 查看按钮 | 主按钮样式（蓝色填充），高度 24px，"查看" | 最常用操作 |
| 更多按钮 | 默认按钮样式 + 下拉箭头 ▼，"更多" | 收起次要操作 |
| 下拉菜单 | 审核通过 / 审核驳回 / 编辑 / 删除 / 热门 / 隐藏 | 根据权限动态显示 |
| 危险操作 | 删除项文字红色 #EB0A1E | 二次确认后执行 |

#### 3.6.8 分页 Pagination

| 属性 | 值 | 说明 |
|------|-----|------|
| 位置 | 表格下方，右对齐 | — |
| 上边距 | 16px | — |
| 默认页大小 | 20 条/页 | 可选 10/20/50/100 |
| 总条数 | 显示 "共 X 条" | — |

#### 3.6.9 抽屉 Drawer

| 属性 | 值 | 说明 |
|------|-----|------|
| 位置 | 右侧滑出 | — |
| 宽度 | 600px | 详情/编辑；400px 用于简单确认 |
| 头部 | 标题 + 关闭按钮 × | 标题 16px / 500 |
| 内容区 | padding 24px，可滚动 | — |
| 底部 | 固定操作栏，padding 16px 24px，上边框 | 取消 / 保存 |

#### 3.6.10 后台组件规格汇总

| 组件 | 规格 |
|------|------|
| 顶部栏 | 高度 64px，背景 white，下边框 1px solid #f0f0f0；左侧 Logo+地区，右侧语言+用户+退出 |
| 侧边栏 | 宽度 200px，背景 #F5F5F5，文字 #333；选中态：背景 #E6F7FF + 左边框 3px solid #009EFF |
| 内容区 | padding 24px，背景 #f0f2f5 |
| 筛选区 | 白色背景，padding 16px 24px，4~5 列紧凑布局，输入框高度 32px |
| 表格区 | 白色背景，表头背景 #FAFAFA，行高 54px |
| 操作按钮 | 蓝色填充 "查看" 按钮 + "更多" 下拉按钮（收起次要操作） |
| 分页 | 表格下方右对齐，默认 20 条/页 |
| 抽屉 | 右侧滑出，宽度 600px，头部标题+关闭按钮，底部固定操作栏 |
| 表单 | 标签顶部对齐或右对齐（宽度 100px），输入框占满剩余 |
| 必填 | 标签前红色 * 号 |

---


---

## 4. Change Process（变更流程）

新增/修改业务组件或页面模板必须：

1. 更新本文档对应章节
2. 同步对应模块 PRD 的 §5.x.2 页面元素
3. 如涉及新 Design Token，同步 `standard/UI设计规范.md` §1
4. 更新 `CHANGELOG.md`

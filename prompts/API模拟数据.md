---
doc_type: "prompt_template"
role: "前后端联调 / 测试"
output_artifacts: ["Mock fixtures (JSON)", "MSW handlers", "Postman mocks"]
applicable_modules: ["5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9"]
version: "1.0.0"
updated: "2026-05-13"
---

# Prompt: API Mock 数据集生成

> **适用角色**：前后端联调 / 测试
> **输出工件**：Mock Server fixtures（JSON）/ MSW handlers / Postman mocks

---

## 你需要先读这些文档

1. `tasks/任务清单.md` 中对应任务行（若按任务执行可先看；若按模块直接开发可跳过）
2. `requirement/modules/<目标模块>.md` 5.x.10 节（API 契约 + sample payload）
3. `standard/技术架构.md` §5（接口规范，含 cursor 分页）+ `design/错误码.md`

## 你需要输出

### 1. Fixtures `mocks/fixtures/<entity>.json`

要求：
- 至少 20 条业务真实的样例数据（不要 "test01"/"test02"）
- 数据多样性：覆盖各 enum 状态、各 author 角色、含图/无图、长/短文本、含/不含车型等
- 时间字段：分布在最近 30 天内
- 用户头像/图片 URL 使用 `https://cdn.example.com/...` 占位

### 2. Mock Handlers `mocks/handlers/<module>.ts`（MSW 风格）

要求：
- 每个 5.x.10 接口对应一个 handler
- 基础场景：成功返回
- 异常场景：通过 query `?_mock=error` 触发，返回 PRD EX 中规定的错误
- 慢请求场景：通过 query `?_mock=slow` 延迟 3s 返回
- cursor 分页：根据 cursor 切片返回数据

### 3. 错误样例覆盖

每个接口至少给出以下错误样例：
- 401（未登录）
- 403（无权限）
- 4xx（业务校验失败 → 选 PRD 5.x.5 中的 1-2 个）
- 5xx（系统异常）
- 1003（限流）

## 严格约束

| 项 | 规则 |
|---|------|
| **真实感** | 数据要符合业务情境（车型用真实型号、问题用真实场景） |
| **结构一致** | 严格遵循 PRD 5.x.10 类型定义 |
| **enum 覆盖** | 每个 enum 字段的所有值至少出现 1 次 |
| **i18n** | 文本字段提供 zh/en 各 50% |
| **关联完整** | Question.author_id 在用户 fixture 中存在；Answer.question_id 在问题 fixture 中存在 |

## 自检清单（输出末尾必填）

- [ ] Fixtures 数据条数 ≥ 20
- [ ] 覆盖 enum 字段的所有值
- [ ] 覆盖每个 5.x.10 接口
- [ ] 覆盖每个接口的成功 + ≥1 错误场景
- [ ] cursor 分页 mock 工作正常
- [ ] 文本中英文比例合理

## 反例

```json
// ❌ 假数据
{ "title": "test1", "content": "abc", "author": { "nickname": "user1" } }

// ✅
{
  "title": "AION V 充电时仪表盘显示警告",
  "content": "充电到 80% 后仪表盘出现红色警告图标，请问这是什么原因？",
  "author": { "nickname": "Car Owner", "role": "CAR_OWNER" }
}
```

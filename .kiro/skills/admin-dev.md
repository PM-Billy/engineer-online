---
inclusion: manual
---

# 管理后台开发 Skill

你是 Engineer Online 项目的后台前端开发者。按以下规范生成 Vue 3 + Ant Design Vue 代码。

## 上下文加载

1. `tasks/任务清单.md` — GROUP-*/QM-*/AM-*/USER-* 任务行
2. `requirement/00-需求总览.md` §1.5 角色权限 / §6 全局规则
3. `requirement/modules/<目标模块>.md` — 5.1/5.7/5.8/5.9 之一
4. `design/权限设计.md` — Permission Code（前端 `v-permission`）
5. `design/错误码.md` — 错误处理
6. `standard/技术架构.md` §3.3 后台前端 / §5 接口 / §10.2 脱敏
7. `design/UI设计.md` §3.6 运营管理后台
8. `requirement/多语言文本.md` §7 后台

## 输出规范

- 页面：`views/<module>/<Page>.vue`（列表页 + 筛选 + 分页 + 批量操作）
- 抽屉：右侧 `a-drawer` 600px（编辑/详情）
- API：`api/<module>.ts`（Axios 封装）
- Store：`stores/<module>.ts`（Pinia）
- 类型：`types/admin.d.ts`

## 严格约束

- **Permission Code**：`v-permission="['question:audit:any']"`，无权限不渲染
- **批量操作**：≤100 条，超出前端拦截
- **二次确认**：删除/驳回必须 `Modal.confirm`；驳回需输入原因
- **脱敏**：手机号 `138****1234`、邮箱 `a***@gmail.com`
- **筛选区**：字段 > 6 个时折叠
- **抽屉**：宽度 600px，底部固定操作栏
- **追溯注释**：每个文件顶部注释标注引用的 BR/AC 编号

## 自检清单

- [ ] 实现的 BR 编号
- [ ] 处理的 EX 编号
- [ ] 满足的 AC 编号
- [ ] 使用的 Permission Code
- [ ] 调用的 API 列表
- [ ] 脱敏字段清单
- [ ] 未实现/偏差项 + 原因

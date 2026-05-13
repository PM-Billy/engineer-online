---
inclusion: manual
---

# 后端开发 Skill

你是 Engineer Online 项目的 Java 后端开发者。按以下规范生成 Spring Boot 代码。

## 上下文加载

1. `tasks/任务清单.md` — 对应任务行
2. `requirement/00-需求总览.md` §1.4 术语 / §1.5 角色权限 / §6 全局规则
3. `requirement/modules/<目标模块>.md` — 重点 §5.x.4 BR / §5.x.5 EX / §5.x.6 数据对象 / §5.x.7 状态机 / §5.x.10 API
4. `design/数据模型.md` — 字段类型 ER + 索引 + 状态机
5. `design/权限设计.md` — Permission Code + 角色矩阵
6. `design/错误码.md` — 异常处理
7. `standard/技术架构.md` §4 后端 / §5 接口 / §6 数据存储 / §7 消息事件
8. `standard/安全基线.md` §1 认证 / §3 注入防护

## 输出规范

- Controller：`controller/<Module>Controller.java`（`@RestController` + `@SaCheckPermission`）
- Service：`service/<Module>Service.java` + impl（业务逻辑 + 事务 + 事件发布）
- DTO：`dto/request/*CreateDTO.java`（JSR-303 注解）
- VO：`dto/response/*VO.java`（脱敏 + MapStruct 转换）
- Mapper：`mapper/<Module>Mapper.java`

## 严格约束

- **Permission Code**：使用 `design/权限设计.md` 常量，`@SaCheckPermission("xxx:yyy:zzz")`
- **错误码**：`throw new BusinessException(ErrorCode.XXX)`，来自 `design/错误码.md`
- **分层**：Controller → Service → Mapper，禁止跨层调用
- **事务**：外部调用（UOP/FCM/翻译）放事务外
- **状态机**：枚举 + Service 守门，禁止 Controller 直接 setStatus
- **缓存**：Cache-Aside（写后删），key 遵循 `standard/技术架构.md` §6.2
- **幂等**：投票/采纳/审核需幂等
- **N+1**：禁止；列表用 JOIN 或批量 IN
- **追溯注释**：每个文件顶部注释标注引用的 BR/AC 编号

## 自检清单

- [ ] 实现的 BR 编号
- [ ] 处理的 EX 编号
- [ ] 满足的 AC 编号
- [ ] 使用的 Permission Code
- [ ] 引用的错误码
- [ ] 涉及的 MQ 事件
- [ ] 涉及的 Redis 缓存 key
- [ ] 涉及的状态机转换路径
- [ ] 未实现/偏差项 + 原因

# 配图风格指南

## 封面设计规范

### 尺寸
- **头条封面：** 1800×766px（2.35:1）
- **安全区：** 核心信息在 766×766 正方形内（朋友圈分享裁切区域）

### 风格推荐

#### 教育类 → 暖色专业
```
底色：暖白 #F5F0EB
主色：暖橙 #D97706
强调色：深蓝 #4A90D9
字体：PingFang SC Bold，≥48px
```

#### 亲子类 → 温暖叙事
```
底色：浅粉 #FFF0F0
主色：玫瑰红 #E87171
强调色：米黄 #F5E6CC
字体：PingFang SC，≥42px
```

#### 干货类 → 极简专业
```
底色：浅灰 #F5F5F5
主色：深蓝 #2C3E50
强调色：橙色 #E67E22
字体：PingFang SC Bold，≥52px
```

### 封面 prompt 模板

```markdown
Create a warm, professional WeChat article cover for [主题].
Style: educational, inviting, modern.
Canvas: 2.35:1 ultra-wide, 1800x766px.
Color palette: warm tones (amber, cream, soft blue accents).
Safe zone: center 766×766 square contains all key text.
Text to render:
- Main title: "[核心标题，≤10字]" (centered, large, bold)
- Subtitle: "[副标题]" (smaller, below main title)
Visual: [1-2句画面描述，如"A parent reading with child in warm library"]
```

## 正文插图设计

### 尺寸
- **正文宽图：** 1920×1080px（16:9）
- **正文方图：** 1440×1080px（4:3）

### 配图位置规则

| 文章类型 | 封面 | 第1图 | 第2图 | 第3图 | 第4图 |
|---------|------|-------|-------|-------|-------|
| 观点/分析 | ✅ 必须 | H2前 | H2中 | 金句段 | 可选 |
| 故事型 | ✅ 必须 | 冲突段 | 行动段 | 反思段 | — |
| 干货型 | ✅ 必须 | Step 1 | Step 3 | 避坑段 | — |

### 配图风格统一规则

- 同一篇文章所有配图色调一致
- 封面色板 → 正文配图延用
- 不要混合插画风格和写实风格
- 字体统一用 PingFang SC

## 信息图设计（HTML 渲染）

适用于：精确数据、对比表格、流程图

```html
<!DOCTYPE html>
<html>
<head>
<style>
  * { margin:0; padding:0; box-sizing:border-box; }
  body {
    width: 1080px; padding: 60px 80px;
    font-family: "PingFang SC", "Microsoft YaHei", sans-serif;
    background: #F5F5F5;
  }
  h1 { font-size: 48px; font-weight: 800; color: #1A1A1A; }
  .highlight { color: #D97706; font-weight: 700; }
</style>
</head>
<body>
  <!-- 内容 -->
</body>
</html>
```

截图命令：
```bash
npx playwright screenshot "file:///path/to/info.html" output.png \
  --viewport-size=1080,N --wait-for-timeout=1000
```

## 色彩系统

### 趴爹育儿圈品牌色

| 用途 | 色值 | 说明 |
|------|------|------|
| 主色调 | #D97706 | 温暖琥珀色 |
| 辅助色 | #4A90D9 | 知性蓝 |
| 底色 | #F5F0EB | 暖白 |
| 强调色 | #E87171 | 玫瑰红（亲子） |
| 文字色 | #333333 | 正文 |
| 标题色 | #1A1A1A | 标题 |

### 配色方案快速选择

| 文章类型 | 推荐配色 |
|---------|---------|
| 教育政策/分析 | 暖橙+深蓝（#D97706+#4A90D9） |
| 亲子故事 | 玫瑰红+米黄（#E87171+#F5E6CC） |
| 学习方法 | 深蓝+橙（#2C3E50+#E67E22） |
| 资源推荐 | 绿+白（#27AE60+#FFFFFF） |

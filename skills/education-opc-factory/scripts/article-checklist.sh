#!/bin/bash
# 教育自媒体发布前检查脚本
# Usage: bash article-checklist.sh <article.md>
# 检查文章是否满足发布标准

ARTICLE="${1}"
if [ -z "$ARTICLE" ]; then
  echo "❌ 用法: bash article-checklist.sh <article.md>"
  exit 1
fi

if [ ! -f "$ARTICLE" ]; then
  echo "❌ 文件不存在: $ARTICLE"
  exit 1
fi

TOTAL=$(wc -l < "$ARTICLE")
WORDS=$(wc -m < "$ARTICLE")
ERRORS=0
PASS=0

echo "═══════════════════════════════════════"
echo " 文章发布检查清单"
echo " 文件: $(basename "$ARTICLE")"
echo "═══════════════════════════════════════"
echo ""

# 1. 检查字数
if [ "$WORDS" -gt 5000 ]; then
  echo "⚠️  字数偏多: ${WORDS} 字符 (建议 1500-3000)"
  ((ERRORS++))
elif [ "$WORDS" -lt 1000 ]; then
  echo "⚠️  字数偏少: ${WORDS} 字符 (建议 1500-3000)"
  ((ERRORS++))
else
  echo "✅ 字数合理: ${WORDS} 字符"
  ((PASS++))
fi

# 2. 检查标题
TITLE=$(head -1 "$ARTICLE" | grep -E '^# ')
if [ -z "$TITLE" ]; then
  echo "⚠️  未找到 H1 标题（需以 # 开头）"
  ((ERRORS++))
else
  TITLE_LEN=$(echo "$TITLE" | wc -m)
  if [ "$TITLE_LEN" -gt 30 ]; then
    echo "⚠️  标题偏长: ${TITLE_LEN} 字符（建议 ≤20字）"
    ((ERRORS++))
  else
    echo "✅ 标题: $TITLE"
    ((PASS++))
  fi
fi

# 3. 检查 H2 分段
H2_COUNT=$(grep -c '^## ' "$ARTICLE")
if [ "$H2_COUNT" -lt 2 ]; then
  echo "⚠️  分段不足: 仅 $H2_COUNT 个 H2（至少 2-3 个）"
  ((ERRORS++))
else
  echo "✅ 分段合理: $H2_COUNT 个 H2"
  ((PASS++))
fi

# 4. 检查 CTA（结尾引导）
CTA=$(tail -10 "$ARTICLE" | grep -cE '(关注|转发|在看|留言|加群|收藏|点赞)')
if [ "$CTA" -eq 0 ]; then
  echo "⚠️  未发现 CTA（关注/转发/留言等引导）"
  ((ERRORS++))
else
  echo "✅ 有 CTA 引导"
  ((PASS++))
fi

# 5. 检查 AI 痕迹词
AI_WORDS=("值得注意的是" "不可忽视" "首先" "其次" "最后" "综上所述" "总而言之" "在这个信息" "从某种角度")
for word in "${AI_WORDS[@]}"; do
  COUNT=$(grep -c "$word" "$ARTICLE")
  if [ "$COUNT" -gt 0 ]; then
    echo "⚠️  发现 AI 痕迹词「${word}」出现 ${COUNT} 次"
    ((ERRORS++))
  fi
done

# 6. 检查 Markdown 格式完整性
UNCLOSED_BOLD=$(grep -c '\*\*' "$ARTICLE" | awk '{print $1 % 2}')
if [ "$UNCLOSED_BOLD" -ne 0 ]; then
  echo "⚠️  加粗标记未闭合（** 数量为奇数）"
  ((ERRORS++))
else
  echo "✅ Markdown 粗体格式正确"
  ((PASS++))
fi

echo ""
echo "═══════════════════════════════════════"
echo " 结果: ✅ ${PASS} 通过 | ⚠️  ${ERRORS} 待修复"
echo "═══════════════════════════════════════"

if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi
exit 0

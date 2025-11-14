#!/bin/bash
# 检查 Zcash 构建状态的脚本

echo "=== 构建进程状态 ==="
if ps aux | grep -q "[b]uild.sh"; then
    echo "✓ 构建进程正在运行"
    ps aux | grep "[b]uild.sh" | head -1
else
    echo "✗ 构建进程未运行"
fi

echo ""
echo "=== 构建日志最后20行 ==="
tail -20 build.log 2>/dev/null || echo "构建日志文件不存在"

echo ""
echo "=== 检查编译错误 ==="
if grep -i "error\|failed" build.log 2>/dev/null | tail -5; then
    echo "发现可能的错误，请检查上面的输出"
else
    echo "未发现明显错误"
fi

echo ""
echo "=== 检查是否完成 ==="
if [ -f "src/zcashd" ] || [ -f "src/zcash-cli" ]; then
    echo "✓ 可执行文件已生成！"
    ls -lh src/zcash* 2>/dev/null
else
    echo "构建尚未完成，可执行文件尚未生成"
fi


const express = require('express');
const app = express();

// 模拟 ChatGPT 生成的消息
const messages = ['Hello', 'How are you? ', 'Nice to meet you.\n ', "这是一个中文句子的示例。 ", "这是另一个中文句子的例子。 ",];

// 处理 SSE 连接的路由
app.post('/stream', (req, res) => {
    res.setHeader('Content-Type', 'text/event-stream; charset=utf-8');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Connection', 'keep-alive');

    const msg = [...messages];

    // 定时发送消息
    const interval = setInterval(() => {
        if (msg.length === 0) {
            // 没有更多消息时，关闭 SSE 连接
            res.end("done");
            clearInterval(interval);
        } else {
            // 发送消息给客户端
            res.write(`${msg.shift()}\n`);
        }
    }, 300);
});

// 启动服务器
const port = 3000;
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});

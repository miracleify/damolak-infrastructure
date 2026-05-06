exports.handler = async (event) => {
    const https = require("https");
  
    const message = JSON.stringify({
      text: `🚨 ALERT:\n${JSON.stringify(event, null, 2)}`
    });
  
    const url = process.env.SLACK_WEBHOOK_URL;
    const parsedUrl = new URL(url);
  
    const options = {
      hostname: parsedUrl.hostname,
      path: parsedUrl.pathname + parsedUrl.search,
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Content-Length": message.length
      }
    };
  
    return new Promise((resolve, reject) => {
      const req = https.request(options, (res) => {
        res.on("data", () => {});
        res.on("end", resolve);
      });
  
      req.on("error", reject);
      req.write(message);
      req.end();
    });
  };
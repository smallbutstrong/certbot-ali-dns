# 使用说明

申请免费的letsencrypt泛域名ssl证书，期限只有3个月，一般可以通过snap 安装的certbot自动更新，但是没有docker方式方便好复用。所以制作了这个镜像来使用。

更新证书的可以放在crontab里面自动运行

## 生成证书

```
docker run -it --rm --name certbot  \
          -v "/etc/letsencrypt:/etc/letsencrypt"  \
          -e ALICLOUD_REGION_ID="cn-hangzhou" \
          -e ALICLOUD_ACCESS_KEY_ID="your access key" \
          -e ALICLOUD_ACCESS_KEY_SECRET="your key secret" \
          smallbutstrong/certbot-ali-dns certonly  -d *.example.com --manual \
          --preferred-challenges dns --manual-auth-hook "alidns" \
          --manual-cleanup-hook "alidns clean" --email example@google.com --agree-tos 

```
## 更新证书
```
docker run -it --rm --name certbot  \
          -v "/etc/letsencrypt:/etc/letsencrypt"  \
          -e ALICLOUD_REGION_ID="cn-hangzhou" \
          -e ALICLOUD_ACCESS_KEY_ID="your access key" \
          -e ALICLOUD_ACCESS_KEY_SECRET="your key secret" \
          smallbutstrong/certbot-ali-dns renew --manual \
          --preferred-challenges dns --manual-auth-hook "alidns" \
          --manual-cleanup-hook "alidns clean" --deploy-hook "service nginx reload"
```

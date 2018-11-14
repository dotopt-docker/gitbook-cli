# usage 

-- author: wuxingzhong

```bash
# as server
docker run -v $(pwd):/srv/gitbook --rm docker.sunniwell.net/base/gitbook-cli:3.2.3
# as build system
docker run -v $(pwd):/srv/gitbook --rm docker.sunniwell.net/base/gitbook-cli:3.2.3 \
    gitbook install && gitbook build && gitbook pdf . test.pdf
    
```

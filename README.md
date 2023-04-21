## Bootstrap

```
flux bootstrap github \
    --context=staging \
    --owner=${GITHUB_USER} \
    --repository=blade-config \
    --branch=main \
    --personal \
    --path=clusters/testing/$(hostname)
```


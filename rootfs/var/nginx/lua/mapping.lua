
local mapping = ngx.shared.cache:get('markets-mapping')

if not mapping then
    local res = ngx.location.capture('/data/markets')
    if res.status ~= ngx.HTTP_OK then
        ngx.exit(res.status)
    end

    local data = cjson.decode(res.body)
    mapping = cjson.encode(data.mapping)

    ngx.shared.cache:set('markets-mapping', mapping, 3600)
else
    ngx.log(ngx.INFO, 'Cache hit for mapping')
end

ngx.print(mapping)
# Test scripts for Nx 16

Create projects at `/tmp`:

```shell
./create.sh
```

Next.js and React apps will be created with different permutations of options.


Create UI library and stories + e2e:
```shell
./add-stories.sh
```

Serve all:
```
./shell
./serve-start.sh

# Stop all servers
./serve-stop.sh
```

Run lint/test/e2e:

```shell
# test everything
./test-all.sh

# lint only
./test-lint.sh

# unit test only
./test-unit.sh

# e2e only
./test-e2e.sh
```

Migrate:

```shell
./migrate-16.sh

# re-run all tests
./test-all.sh
```



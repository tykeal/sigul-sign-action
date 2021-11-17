# Sigul-sign action

This action is used to sign build artifacts and git tags using a Sigul server.

# Usage

### Sign an object that is available in the workspace

```yaml
- uses: lfit/sigul-sign@v1
  with:
      sign-type: "sign-data"
      sign-object: ${{ github.workspace }}/artifacts/mypackage.tar.gz
      sigul-key-name: "my-release-key"
      gh-user: automation-username
      gh-key: ${{ secrets.GHA_TOKEN }}
      sigul-ip: ${{ secrets.SIGUL_IP }}
      sigul-uri: ${{ secrets.SIGUL_URI }}
      sigul-conf: ${{ secrets.SIGUL_CONF }}
      sigul-pass: ${{ secrets.SIGUL_PASS }}
      sigul-pki: ${{ secrets.SIGUL_PKI }}

# This should produce an object named ${sign-object}.asc. We will then need to
# upload the artifact.
- uses: actions/upload-artifact@v2
  with:
      name: Signatures
      path: ${{ github.workspace }}/mypackage.tar.gz.asc
```

### Sign multiple objects in the workspace

```yaml
- uses: lfit/sigul-sign@v1
  with:
      sign-type: "sign-data"
      sign-object: |
          file.tar.gz
          artifacts/my-file.jar
          docs/signme.md
      sigul-key-name: "my-release-key"
      gh-user: automation-username
      gh-key: ${{ secrets.GHA_TOKEN }}
      sigul-ip: ${{ secrets.SIGUL_IP }}
      sigul-uri: ${{ secrets.SIGUL_URI }}
      sigul-conf: ${{ secrets.SIGUL_CONF }}
      sigul-pass: ${{ secrets.SIGUL_PASS }}
      sigul-pki: ${{ secrets.SIGUL_PKI }}

# All files will be written to the workspace root. Files such as "dir/subdir/file.ext"
# will create a signature file named "dir-subdir-file.ext.asc".
- uses: actions/upload-artifact@v2
  with:
      name: Signatures
      path: ${{ github.workspace }}/*.asc
```

### Sign a git tag

```yaml
- uses: lfit/sigul-sign@v1
  with:
      sign-type: "sign-git-tag"
      sign-object: "v1.1" # Unsigned annotated tag in repo
      sigul-key-name: "my-release-key"
      gh-user: automation-username
      gh-key: ${{ secrets.GHA_TOKEN }}
      sigul-ip: ${{ secrets.SIGUL_IP }}
      sigul-uri: ${{ secrets.SIGUL_URI }}
      sigul-conf: ${{ secrets.SIGUL_CONF }}
      sigul-pass: ${{ secrets.SIGUL_PASS }}
      sigul-pki: ${{ secrets.SIGUL_PKI }}
```

## Inputs

## `sign-type`

The type of signing to do, either `"sign-data"` or `"sign-git-tag"`.
Default `"sign-data"`

## `sign-object`

**Required** The file or git tag to sign.

## `sigul-ip`

**Required** The IP address of the sigul server being used.

## `sigul-uri`

**Required** The URI of the sigul server. This is used with the IP address to
create a hosts file entry for the server.

## `sigul-conf`

**Required** The sigul config file.

## `sigul-key-name`

**Required** The key name on the server to utilize.

## `sigul-pass`

**Required** The password for the sigul connection (this should be specific to
the key name being used).

## `sigul-pki`

**Required** PKI info for the sigul connection. This expected to be stored in a
GPG armor file, encrypted using the above sigul-pass.

## `gh-user`

For git tag signing, the action requires a user to push the signed tag as.
Default: GITHUB_ACTOR (the name of the person or app that initiated the workflow)

## `gh-key`

An API key for the user specified in `gh-user`. This is not a required field for
sign-data actions, but **MUST** be specified for sign-git-tag actions.

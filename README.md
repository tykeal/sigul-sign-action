# Sigul-sign action

This action is used to sign build artifacts and git tags using a Sigul server.

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
sign-data actions, but *MUST* be specified for sign-git-tag actions.

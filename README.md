- [What is gitpatch](#orgdb3f076)
  - [Installation](#orgec933e1)
  - [Configure](#org0459aee)
  - [Usage](#org943d199)
    - [gitpatch-mail](#org9ebee88)


<a id="orgdb3f076"></a>

# What is gitpatch

Utils of git-format patch file, which include:

1.  \`gitpatch-mail' Quick send a git-format patch file with message-mode or its derived mode.


<a id="orgec933e1"></a>

## Installation

1.  Config melpa source, please read: <http://melpa.org/#/getting-started>
2.  M-x package-install RET gitpatch RET


<a id="org0459aee"></a>

## Configure

    (require 'gitpatch)


<a id="org943d199"></a>

## Usage


<a id="org9ebee88"></a>

### gitpatch-mail

1.  Move the point to the patch-name in magit-status buffer or dired buffer. NOTE: Other buffer type can be supported with the help of \`gitpatch-mail-get-patch-functions'
2.  M-x gitpatch-mail
3.  Select an email address as TO Field, if you set \`gitpatch-mail-database'.
4.  Edit and send email.


Converted from gitpatch.el by [el2org](https://github.com/tumashu/el2org) .
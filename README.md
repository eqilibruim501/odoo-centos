# What is Odoo?

[Odoo](https://www.odoo.com) is a suite of open-source business apps written in Python and released under the AGPL license. This suite of applications covers all business needs, from Website/Ecommerce down to manufacturing, inventory and accounting, all seamlessly integrated. It is the first time ever a software editor managed to reach such a functional coverage. Odoo is the most installed business software in the world. Odoo is used by 2.000.000 users worldwide ranging from very small companies (1 user) to very large ones (300 000 users).

# This image

This Docker image is prepared to be used with [Layershift Jelastic Paas](http://www.layershift.com/hosting/jelastic-paas) Marketplace installation.

## Environment variables and Odoo version

This image is based on Odoo `9.0`c release `20160214`. You can change those by editing variables:

```
ODOO_VERSION
ODOO_RELEASE
```

**NOTE**: Odoo version should use only numeric version representation. `c` (for: community) is hardcoded:

```
RUN wget -q --no-check-certificate -O /tmp/odoo.rpm https://nightly.odoo.com/${ODOO_VERSION}/nightly/rpm/odoo_${ODOO_VERSION}c.${ODOO_RELEASE}.noarch.rpm
```

[List of available releases](https://nightly.odoo.com/9.0/nightly/rpm/)

# Base Docker image

[bbania/centos:base](https://hub.docker.com/r/bbania/centos/)

# Installation

Log into your Layershift Jelastic [Dashboard Panel](https://app.j.layershift.co.uk) and search for *Odoo* in Marketplace.

# LICENSE

Licensed under GNU LGPLv3

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2C3591C2
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 03:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhDIB51 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Apr 2021 21:57:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:22800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhDIB50 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Apr 2021 21:57:26 -0400
IronPort-SDR: FuqNeWDjjvgF1RRk/P/8tYFZ8ja882rFx2WwsJXMJgQMkfb+VsLFASYOeVs+8d2mBa/OHP0scY
 TxGNBKw53W+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173147060"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="173147060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 18:57:13 -0700
IronPort-SDR: 2fUhX4nj3+ZCZ1YN6zU0cOsh7dwDwwdgp0bSc0o14KZS7WodtXjmHJur/1CMoZ3jwUMVq6P+qa
 iBL0EzcWw3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="416049586"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2021 18:57:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 18:57:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 8 Apr 2021 18:57:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 8 Apr 2021 18:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVExiqIzYwzqEz2THuj12sO/jP8XrNQ6Tw0tr23CpSRe/OoTa1U0jWTi4JJ6yM8Qzub5eLeq0uz841qMnnxPZuIWkZTYF8Hruxt0byiEq7VNhlNrNPvQU4Lg1M3F6w4n4qxGpVec0bQomi0/CHpYza8MCzVwrrCJZ3CnbE/dZhKHXO2pilOC6pHpYx7bDq4DYVdJhXuv8M05yLzk/Ds4UN0+lA/+DyEV9qJBONuZ81UN69fhSlgr0cuLxaXB4d35KhqFH/yIQUR3q+5oh/jNlvBgbuxDvYm4HTL3HT2CmWVfOAUhGUr0haWa+ov1j2dqyqqZHBZou0aWziHkPnaoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdir3VlDRl25tnJd8tjilc/c8/upJCUlE3pBjK4ya2g=;
 b=YSM13fOmMLUE/k/MI0ncF3bjDGnJ/UtoW+yhcX84py2n4O7OjZKfIMhwQ+FGeD0rdtUmkNVy4+k/ZmjaVuAGs7phUvB2er12VCiEKetB05Q46kQ7zQw4SFz1+lGAnQR4GnXAprHLjoMq0TG58vr7MAi0Wz7KLl+5ndFfyx/ZtxrCGA0WMHwzjsv2iGRXI3KxUGbFkfaLJWcSvN6yC1vIJwwxSF/imwWCmDpqVOtKpaq/RrWmsyDvDW/ArKv9LtxE961lbKFlyRwSz8MUksPLpIOlbAxkJFgjrjkQ8ASwFD6a3wOEdP13EZK8inYaC8a5rhwC4uGItzqD5IWwI2Ul6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdir3VlDRl25tnJd8tjilc/c8/upJCUlE3pBjK4ya2g=;
 b=mes8oLT0JPFptXEDYXJQE+uvZFhQtoSGfPhuH+SaYAjVaoOcbw+gZC+0+G7Y3VL58unU3AGAiwV6O+cCd3isSMOZzPpdoiX6ROWKa80+UZ6joJwkybuiXkQs8OGH+h5ldQE1FS39TRwt0Rb39Lfu3DZNmxFc37kZXcoXxiWSfWA=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4204.namprd11.prod.outlook.com (2603:10b6:5:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 01:57:09 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.3999.034; Fri, 9 Apr 2021
 01:57:09 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: RE: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Topic: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Index: AQHXKnapzaN+e8jiOUasbNG/fZUbfKqmp0KAgAEBK4CAAAt/AIAChFHwgAAQfwCAAAHe8IAAsUoAgABl7xA=
Date:   Fri, 9 Apr 2021 01:57:08 +0000
Message-ID: <DM6PR11MB3819D31DA5C9B239BA8D1B1685739@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YG9REtNPi4e2hyJK@epycbox.lan>
In-Reply-To: <YG9REtNPi4e2hyJK@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4851b2e-0b76-466c-f772-08d8fafac8d0
x-ms-traffictypediagnostic: DM6PR11MB4204:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4204E15343100C6DD917117485739@DM6PR11MB4204.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EU0B7cY8Wwvu6uXoyDnHuCNCRKBUyBMLZhDPxP2QKnp4Ao3MUweOgmurVVc1DJIj5uo78tFyiPiXiBGmUn6ynISXzkYDjw1REXP8AYj86dPo3mji2tyaR/b1bId5M7w0iui0kYurTUu2rcBfpONxa2Hh+Eh92YbYLpt3e6svV2KbC4YoPVXrVsstwaIZHF3fnaxqiCZtsdDgYYrl79xvNQ50RrxxnBfM4kHgLOgukOmg0Qg43dfhl/WJQ5FfgY2mEUbg7pb6bJ/ZUK2yj7/odoYZ3VDPyXNxEhSYATcM3zB4z7G/zRN1KSQMbwx2keIAgUsNll0aiScR9Jq535ji4JvFWGjss5bBXG0sLLcqpYe1KeeNQ6QuQin2gIndNSwQzklq+eBeYyNhPI32kyn6mOIe1mXhFEFgP99ZmiUw9r8PUt+A+Bpf2HtMM7K8EQhd/H/QYJhPkixxqBlCY/nIP1Kk5r82XKXeho9seb1jN+u1RJg6BivQ5vVJ86+xY5kQIGUSOujWrCym+9r7Dl4VAl79a+7aY2tQnxBuDsJXxMjk8saYQZdSPdRLF3lkTxRi9O7GPDH1Vh8iBxuhf0u+iA2oDRoQxC8xmwK07efoR8eLVq+ashLZHsnnlIJ2OObNv8wwyR0Ve8XaJbkuz8PxIr9/6b3uGj5Es0y7AyqZAA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(346002)(396003)(7416002)(186003)(26005)(55016002)(478600001)(2906002)(71200400001)(8936002)(86362001)(9686003)(66556008)(64756008)(5660300002)(6506007)(83380400001)(316002)(30864003)(66946007)(76116006)(66446008)(8676002)(66476007)(33656002)(6916009)(4326008)(52536014)(54906003)(38100700001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lIzGqfXgRXCXJOmkJh4v5khuuKSfIfW7KisgloiTNBqKaK5tphO7YwBWVXLe?=
 =?us-ascii?Q?FAoTzxwWefkZMcueWoO+OTdfRwUTGX5PXloQkOpfP/wsPrqCUheYi+VTOQDX?=
 =?us-ascii?Q?ez9JCM5JFLhA/XvGYzx1hK+Q5r8RthPpVoMy7t40p0ksA8ZSuOtLfr9CmqIx?=
 =?us-ascii?Q?UJHuKw+sQZi6avH9gcucn+xHjSCg6wZlzBmxjj+cmyKlt8Se6rarvnl4D530?=
 =?us-ascii?Q?HHSiV9YXkVlCR4SUeDSmYH2n2WPk01GyHFfDAxrQVJ3rstgvqqaqR590dX1g?=
 =?us-ascii?Q?Vu2Bugz7bALpGyugRa6/STj+YWHICr4BIKbZO1zWssLiItX3hnkidfccKh6O?=
 =?us-ascii?Q?HdLoINyzjHfpSwsMcF2YbbE2lsWOAYYlONI05SqxN0iuCgELemWfrZNSQeRB?=
 =?us-ascii?Q?+/zDzXCY46vwQZsWu+H3Lh0LOn3UGmgMUm8wfVBWDxRNPnQdlYHCq53S1GI/?=
 =?us-ascii?Q?gAhMK6gp9LvZsg77vkXmU/PiNsPiN0MhK06Uuww3mgQQQMaX8JdDG98boMcz?=
 =?us-ascii?Q?y2NAEmE1sEoESXTXp1QDWy5pwUGz+TETbfs6H0kN4gCk6yQKe5xhZenrra/S?=
 =?us-ascii?Q?HMUjLmdTjCHUc5uNbzFbVVepVHlAHesSfNusRqh6Wz69fJmR+dJ5HkfhxEAD?=
 =?us-ascii?Q?HXwLHoqoqBB6MKBco9goe+wvgf1YQbnf3x7kRJt0NIOVLT/BVcaDR66fq4oE?=
 =?us-ascii?Q?ql9l0xFV/0CWOIwOZgaLLPTyI1foFrBujCwQm1Ce/ld2bd+ydI/XNfG0bTYL?=
 =?us-ascii?Q?gAs7rOAqpLtCz1OQJIU/Jqw846BLEMTAo/nL40DgOHMEY/WpNrKH6K0FC+mc?=
 =?us-ascii?Q?icKNZpd180oSXVZLAWEhyrTpb5mR8mSkJDDDS/vABhpIKV+ucP/EC35xnl1I?=
 =?us-ascii?Q?UjQHHfXH2sO8Ggnm0GpHIjaJ5BTnrQcIxvzRYPzR0DjdWrc88i1STUuPcogF?=
 =?us-ascii?Q?V5cud0726IYPKVmVANDE3ktKl9bPdC45IGRLdNdlk5/d0Zx1g8AG91dHbCeX?=
 =?us-ascii?Q?ixErxWD47FYX4kdqbPkKWGXlMvB4ugJa2N4NWIoLkur2YAni/3V52ZbvF9Dm?=
 =?us-ascii?Q?eFdvLCHaCk/vqnBTVKjBgfqnDv/VxUeGFt0fg3Av3SUZ7Libvw0CSyAFtmw9?=
 =?us-ascii?Q?9U8933mi64oFvSY5soqpNAQsjDQ3Mqe63FdZgD464XcKtUcWurQbf3//KLe9?=
 =?us-ascii?Q?vNU3sWg0tPz1Xnt6sQiE/l9SCa7z7/IfWh7ay+V29F4u7ZQX/ZcuMnkGUGL3?=
 =?us-ascii?Q?6sqwWunblLXXjBvcHGSeJEAp6zxfZ8cOVVu5exdjmJml1CLzBGjC8ZHruBsr?=
 =?us-ascii?Q?i2+P6f7/yYLMAbQz36TMCaFn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4851b2e-0b76-466c-f772-08d8fafac8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 01:57:08.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcqnwjiQQCXBfNiE+vv+qDILLtJpcWMzlzkBcdxHa3hZVSNLfV323rgxPZButskenvCVKInq94b2zgnyRDGPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4204
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Thu, Apr 08, 2021 at 09:20:19AM +0000, Wu, Hao wrote:
> > > On Thu, Apr 08, 2021 at 03:30:15PM +0800, Wu, Hao wrote:
> > > > > > On Mon, 5 Apr 2021, Moritz Fischer wrote:
> > > > > >
> > > > > > > Hi Matthew,
> > > > > > >
> > > > > > > On Mon, Apr 05, 2021 at 04:53:00PM -0700,
> > > > > matthew.gerlach@linux.intel.com wrote:
> > > > > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > > >
> > > > > > > > This patch adds DFL bus driver for the Altera SPI Master
> > > > > > > > controller.  The SPI master is connected to an Intel SPI Sl=
ave to
> > > > > > > > Avalon Master Bridge, inside an Intel MAX10 BMC Chip.
> > > > > > > >
> > > > > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel=
.com>
> > > > > > > > ---
> > > > > > > >  drivers/fpga/Kconfig          |   9 ++
> > > > > > > >  drivers/fpga/Makefile         |   1 +
> > > > > > > >  drivers/fpga/dfl-spi-altera.c | 221
> > > > > ++++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 231 insertions(+)
> > > > > > > >  create mode 100644 drivers/fpga/dfl-spi-altera.c
> > > > > > > >
> > > > > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > > > > index d591dd9..0a86994 100644
> > > > > > > > --- a/drivers/fpga/Kconfig
> > > > > > > > +++ b/drivers/fpga/Kconfig
> > > > > > > > @@ -210,6 +210,15 @@ config
> FPGA_DFL_NIOS_INTEL_PAC_N3000
> > > > > > > >    the card. It also instantiates the SPI master (spi-alter=
a) for
> > > > > > > >    the card's BMC (Board Management Controller).
> > > > > > > >
> > > > > > > > +config FPGA_DFL_SPI_ALTERA
> > > > > > > > +tristate "FPGA DFL Altera SPI Master Driver"
> > > > > > > > +depends on FPGA_DFL
> > > > > > > > +select REGMAP
> > > > > > > > +help
> > > > > > > > +  This is a DFL bus driver for the Altera SPI master contr=
oller.
> > > > > > > > +  The SPI master is connected to a SPI slave to Avalon Mas=
ter
> > > > > > > > +  bridge in a Intel MAX BMC.
> > > > > > > > +
> > > > > > > >  config FPGA_DFL_PCI
> > > > > > > >  tristate "FPGA DFL PCIe Device Driver"
> > > > > > > >  depends on PCI && FPGA_DFL
> > > > > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > > > > > index 18dc9885..58a42ad 100644
> > > > > > > > --- a/drivers/fpga/Makefile
> > > > > > > > +++ b/drivers/fpga/Makefile
> > > > > > > > @@ -45,6 +45,7 @@ dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-=
region.o
> dfl-
> > > > > afu-dma-region.o
> > > > > > > >  dfl-afu-objs +=3D dfl-afu-error.o
> > > > > > > >
> > > > > > > >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)+=3D dfl-n3000-
> > > > > nios.o
> > > > > > > > +obj-$(CONFIG_FPGA_DFL_SPI_ALTERA)+=3D dfl-spi-altera.o
> > > > > > > >
> > > > > > > >  # Drivers for FPGAs which implement DFL
> > > > > > > >  obj-$(CONFIG_FPGA_DFL_PCI)+=3D dfl-pci.o
> > > > > > > > diff --git a/drivers/fpga/dfl-spi-altera.c b/drivers/fpga/d=
fl-spi-
> altera.c
> > > > > > > > new file mode 100644
> > > > > > > > index 0000000..9bec25fd
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/fpga/dfl-spi-altera.c
> > > > > > > > @@ -0,0 +1,221 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +/*
> > > > > > > > + * DFL bus driver for Altera SPI Master
> > > > > > > > + *
> > > > > > > > + * Copyright (C) 2020 Intel Corporation, Inc.
> > > > > > > > + *
> > > > > > > > + * Authors:
> > > > > > > > + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#include <linux/types.h>
> > > > > > > > +#include <linux/kernel.h>
> > > > > > > > +#include <linux/module.h>
> > > > > > > > +#include <linux/stddef.h>
> > > > > > > > +#include <linux/errno.h>
> > > > > > > > +#include <linux/platform_device.h>
> > > > > > > > +#include <linux/io.h>
> > > > > > > > +#include <linux/bitfield.h>
> > > > > > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > > > > > > +#include <linux/regmap.h>
> > > > > > > > +#include <linux/spi/spi.h>
> > > > > > > > +#include <linux/spi/altera.h>
> > > > > > > > +#include <linux/dfl.h>
> > > > > > > > +
> > > > > > > > +struct dfl_altera_spi {
> > > > > > > > +void __iomem *base;
> > > > > > > > +struct regmap *regmap;
> > > > > > > > +struct device *dev;
> > > > > > > > +struct platform_device *altr_spi;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +#define SPI_CORE_PARAMETER      0x8
> > > > > > > > +#define SHIFT_MODE              BIT_ULL(1)
> > > > > > > > +#define SHIFT_MODE_MSB          0
> > > > > > > > +#define SHIFT_MODE_LSB          1
> > > > > > > > +#define DATA_WIDTH              GENMASK_ULL(7, 2)
> > > > > > > > +#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
> > > > > > > > +#define CLK_POLARITY            BIT_ULL(14)
> > > > > > > > +#define CLK_PHASE               BIT_ULL(15)
> > > > > > > > +#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
> > > > > > > > +#define SPI_CLK                 GENMASK_ULL(31, 22)
> > > > > > > > +#define SPI_INDIRECT_ACC_OFST   0x10
> > > > > > > > +
> > > > > > > > +#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0=
)
> > > > > > > > +#define INDIRECT_WR             BIT_ULL(8)
> > > > > > > > +#define INDIRECT_RD             BIT_ULL(9)
> > > > > > > > +#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8=
)
> > > > > > > > +#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
> > > > > > > > +#define INDIRECT_DEBUG          BIT_ULL(32)
> > > > > > > > +#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x1=
0)
> > > > > > > > +#define INDIRECT_TIMEOUT        10000
> > > > > > > > +
> > > > > > > > +static int indirect_bus_reg_read(void *context, unsigned i=
nt reg,
> > > > > > > > + unsigned int *val)
> > > > > > > > +{
> > > > > > > > +struct dfl_altera_spi *aspi =3D context;
> > > > > > > > +void __iomem *base =3D aspi->base;
> > > > > > > > +int loops;
> > > > > > > > +u64 v;
> > > > > > > > +
> > > > > > > > +writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
> > > > > > > > +
> > > > > > > > +loops =3D 0;
> > > > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
> > > > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > > > +cpu_relax();
> > > > > > > > +
> > > > > > > > +if (loops >=3D INDIRECT_TIMEOUT) {
> > > > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > > > +return -ETIME;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +v =3D readq(base + INDIRECT_RD_DATA);
> > > > > > > > +
> > > > > > > > +*val =3D v & INDIRECT_DATA_MASK;
> > > > > > > > +
> > > > > > > > +return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static int indirect_bus_reg_write(void *context, unsigned =
int reg,
> > > > > > > > +  unsigned int val)
> > > > > > > > +{
> > > > > > > > +struct dfl_altera_spi *aspi =3D context;
> > > > > > > > +void __iomem *base =3D aspi->base;
> > > > > > > > +int loops;
> > > > > > > > +
> > > > > > > > +writeq(val, base + INDIRECT_WR_DATA);
> > > > > > > > +writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
> > > > > > > > +
> > > > > > > > +loops =3D 0;
> > > > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
> > > > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > > > +cpu_relax();
> > > > > > > > +
> > > > > > > > +if (loops >=3D INDIRECT_TIMEOUT) {
> > > > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > > > +return -ETIME;
> > > > > > > > +}
> > > > > > > > +return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct regmap_config indirect_regbus_cfg =3D =
{
> > > > > > > > +.reg_bits =3D 32,
> > > > > > > > +.reg_stride =3D 4,
> > > > > > > > +.val_bits =3D 32,
> > > > > > > > +.fast_io =3D true,
> > > > > > > > +
> > > > > > > > +.reg_write =3D indirect_bus_reg_write,
> > > > > > > > +.reg_read =3D indirect_bus_reg_read,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static struct spi_board_info m10_bmc_info =3D {
> > > > > > > > +.modalias =3D "m10-d5005",
> > > > > > > > +.max_speed_hz =3D 12500000,
> > > > > > > > +.bus_num =3D 0,
> > > > > > > > +.chip_select =3D 0,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static struct platform_device *create_cntrl(struct device =
*dev,
> > > > > > > > +    void __iomem *base,
> > > > > > > > +    struct spi_board_info *m10_info)
> > > > > > > > +{
> > > > > > > > +struct altera_spi_platform_data pdata;
> > > > > > > > +struct platform_device_info pdevinfo;
> > > > > > > > +u64 v;
> > > > > > > > +
> > > > > > > > +v =3D readq(base + SPI_CORE_PARAMETER);
> > > > > > > > +
> > > > > > > > +memset(&pdata, 0, sizeof(pdata));
> > > > > > > > +pdata.mode_bits =3D SPI_CS_HIGH;
> > > > > > > > +if (FIELD_GET(CLK_POLARITY, v))
> > > > > > > > +pdata.mode_bits |=3D SPI_CPOL;
> > > > > > > > +if (FIELD_GET(CLK_PHASE, v))
> > > > > > > > +pdata.mode_bits |=3D SPI_CPHA;
> > > > > > > > +
> > > > > > > > +pdata.num_chipselect =3D FIELD_GET(NUM_CHIPSELECT, v);
> > > > > > > > +pdata.bits_per_word_mask =3D
> > > > > > > > +SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> > > > > > > > +
> > > > > > > > +pdata.num_devices =3D 1;
> > > > > > > > +pdata.devices =3D m10_info;
> > > > > > > > +
> > > > > > > > +dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> > > > > > > > +pdata.num_chipselect, pdata.bits_per_word_mask,
> > > > > > > > +pdata.mode_bits);
> > > > > > > > +
> > > > > > > > +memset(&pdevinfo, 0, sizeof(pdevinfo));
> > > > > > > > +
> > > > > > > > +pdevinfo.name =3D "subdev_spi_altera";
> > > > > > > > +pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> > > > > > > > +pdevinfo.parent =3D dev;
> > > > > > > > +pdevinfo.data =3D &pdata;
> > > > > > > > +pdevinfo.size_data =3D sizeof(pdata);
> > > > > > > > +
> > > > > > > > +return platform_device_register_full(&pdevinfo);
> > > > > > >
> > > > > > > Should this be a SPI driver? I think looking at the UIO case =
we had
> > > > > > > decided against this pattern?
> > > > > >
> > > > > > This driver is similar in function to drivers/fpga/dfl-n3000-ni=
os.c which
> > > > > > uses this design pattern.  Is it okay to keep this design patte=
rn for
> > > > > > consistency?
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > +}
> > > > > > > > +static int dfl_spi_altera_probe(struct dfl_device *dfl_dev=
)
> > > > > > > > +{
> > > > > > > > +struct device *dev =3D &dfl_dev->dev;
> > > > > > > > +struct dfl_altera_spi *aspi;
> > > > > > > > +
> > > > > > > > +aspi =3D devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
> > > > > > > > +
> > > > > > > > +if (!aspi)
> > > > > > > > +return -ENOMEM;
> > > > > > > > +
> > > > > > > > +dev_set_drvdata(dev, aspi);
> > > > > > > > +
> > > > > > > > +aspi->dev =3D dev;
> > > > > > > > +
> > > > > > > > +aspi->base =3D devm_ioremap_resource(dev, &dfl_dev->mmio_r=
es);
> > > > > > > > +
> > > > > > > > +if (IS_ERR(aspi->base)) {
> > > > > > > > +dev_err(dev, "%s get mem resource fail!\n", __func__);
> > > > > > > > +return PTR_ERR(aspi->base);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +aspi->regmap =3D devm_regmap_init(dev, NULL, aspi,
> > > > > &indirect_regbus_cfg);
> > > > > > > > +if (IS_ERR(aspi->regmap))
> > > > > > > > +return PTR_ERR(aspi->regmap);
> > > > > > > > +
> > > > > > > > +aspi->altr_spi =3D create_cntrl(dev, aspi->base, &m10_bmc_=
info);
> > > > > > > > +
> > > > > > > > +if (IS_ERR(aspi->altr_spi)) {
> > > > > > > > +dev_err(dev, "%s failed to create spi platform driver\n",
> > > > > > > > +__func__);
> > > > > > > > +return PTR_ERR(aspi->base);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_d=
ev)
> > > > > > > > +{
> > > > > > > > +struct dfl_altera_spi *aspi =3D dev_get_drvdata(&dfl_dev->=
dev);
> > > > > > > > +
> > > > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > > > +
> > > > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[] =3D=
 {
> > > > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > > > +{ }
> > > > > > > > +};
> > > > > > >
> > > > > > > Maybe you can extend the Altera SPI driver with this part?
> > > > > >
> > > > > > The file, drivers/spi/spi-altera.c, already has platform MODULE=
_
> related
> > > > > > code.  Wouldn't moving this code to that file produce conflicts=
?
> > > > >
> > > > > I've seen other drivers support multiple busses, so it should be
> > > > > possible, there might be nuances I'm missing in my brief look at =
this,
> > > > > though.
> > > > >
> > > > > I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> > > > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > > > >
> > > > > See drivers/i2c/busses/i2c-designware-platdrv.c for an example (t=
hough
> > > > > they might be guarding against what you describe with CONFIG_OF v=
s
> > > > > CONFIG_ACPI)
> > > > >
> > > > > If that doesn't work we could split it up into
> > > > >
> > > > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > > > or something of that sort?
> > > > >
> > > > > My point being, now that we have a bus, let's use it and develop =
drivers
> > > > > according to the Linux device model where possible :)
> > > >
> > > > Agree. This does make sense from my side too. DFL core provides the
> > > mechanism
> > > > to enumerate different IPs on FPGA, but each function driver needs =
to go
> to
> > > > related subsystem for review.  : )
> > > >
> > > > I understand that for FPGA case, it may have some additional logics=
 for
> specific
> > > > purposes based on common altera spi master IP, then additional code=
 for
> > >
> > > I'm wondering if the additional logics are extensions for common spi-=
altera.
> Like
> > > the
> > > SPI_CORE_PARAMETER register, it is not within the register space of
> > > spi-altera,
> > >
> > >
> > >   |   |      +-------------+
> > >   |DFL|------| +--------+  |
> > >   |BUS|      | |SPI CORE|  |
> > >   |   |      | |PARAM   |  |
> > >   |   |      | +--------+  |
> > >   |   |      |             |
> > >   |   |      | +--------+  |   +-------+
> > >              | |Indirect|  |   |spi    |
> > >              | |access  +--+---|altera |
> > >              | |master  |  |   +-------+
> > >              | +--------+  |
> > >              +-------------+
> > > > a specific product still can be put into altera-spi-xxxx.c or alter=
a-spi-dfl-
> xxxx.c
> > >
> > > So is it proper we integrate this feature into spi-altera? Previously
> > > we have merged the dfl-n3000-nios, its spi part is very similar as
> > > this driver. The dfl-n3000-nios make the spi-altera as a sub device.
> > > Could we borrow the idea, or could we just integrate this driver in
> > > dfl-n3000-nios?
> >
> > Looks like those are enhancements of the IP. They can be applied even
> > other buses are used, not only for DFL, like PCI device or platform dev=
ice,
> > right? then why not put related code together with the original IP?
>=20
> Do you maybe need to extend struct dfl_device to have multiple mmio_res,
> then?
>=20
> Can DFL describe such a scenario?
>=20
> That seems the logical step to support what's been drawn up there?

Current DFH version 0 only supports 1 mmio range, then everything has to
be put into the same mmio range but different offsets I think. DFH doesn't
care about what are inside this range, even it's possible to put multiple I=
Ps
into one range ( DFH doesn't prevent this usage, but then mfd or something
similar need to be used in device driver on DFL bus).

It's should be fine to add multiple mmio ranges support for one DFH device
which requires a new version DFH, so that it can match the platform devices
which have multiple mmio resources or just like pci devices which have mult=
iple
bars, but it is not something must to have for above case I think. : )

Thanks
Hao

>=20
> >
> > The reason I suggested that function drivers which use DFL bus, still n=
eed
> > to go to related subsystem, because we know DFL quite well but may
> > not be the experts for every subsystem (e.g. SPI), and every IPs (e.g.
> > Altera SPI Master). Altera SPI Master driver maintainer could give more
> > valuable suggestions on your question if this feature can be integrated
> > into spi-altera or not. : )
> >
> > Hao
> >
> > >
> > > Thanks,
> > > Yilun
> > >
> > > >
> > > > Thanks
> > > > Hao
> > > >
> > > > >
> > > > > Cheers,
> > > > > Moritz
>=20
> Cheers,
> Moritz

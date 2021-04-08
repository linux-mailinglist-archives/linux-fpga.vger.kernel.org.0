Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D157A357D65
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhDHHaf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Apr 2021 03:30:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:22808 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhDHHac (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Apr 2021 03:30:32 -0400
IronPort-SDR: 8BYlb2Gf7xX/12KjvlmkCXYK+tDPwH71GR9f8MhfIHpmhf10/flMWjeWuwNTrzuuLbLOjDhk3x
 HH/5OqoWZ9uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524371"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="193524371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 00:30:21 -0700
IronPort-SDR: 1YpKBYZF3QxwIJkTYG4t8C9gMfzy9RzVxRrk6ZgyKVAIv+FjqGwSWBNIHmZOzR7SI2g1bAr5mU
 E/a34sO401xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="598670998"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2021 00:30:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 00:30:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 00:30:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 8 Apr 2021 00:30:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 8 Apr 2021 00:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFZWaP9SDx9CL4Qyd2izxuxWkU8NzGjvWQZiDeAe5XFaS5JrQG04p1bXbbSPVUYXyAj0Ke4BOjSZPR+ATCdgP5W1AQs3KibUhOK2VvwhaQxd6vBYtMfKB6UMYAluLPK4fp3Uct+lDi+L6Ow33ftCHjDY5WLCFf61zQhbBwi3i3wCgtz4I8Bk+vd8rvjjJIBzWDAkzI9e8uDWjeVBY9TJK7eN5wbJq3/r9LCRHQwZ3cRZgB7buPtZRduJI6f0x/kL2HFLpV226Fc0lstWK6bMyF0j/0LLVzqnZkG6mN5TIfExz49YWtbd6/ff23EUwQT/tPoxaDX6a8LVfmGIJpg+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO+v5+nyGndxh/MpM9FgQ1T3aB7+vOZPLt+NUZuZQ7s=;
 b=Zc/s7Ism72Cpp4+KH6oYYYMPWYxRfhVinkLrUsLnoC28lT2sw0Df2HJAvH8iu82uL9j7WEXFY5FF1dxMYuX0F/0h3IYvFozUYxbwvqtNMpveitZzIJw4MmazFO+nS4p5wn846d1uZLHoAUIJHj3a7qX0nG1eZTdWbxeUYGTimj92gsWpH4a9loObKGDPnTMNeD+4s13f/4OPq8As60BF4YcgxbbLUNa4Ne0079lQ8SL9yD6yytex8P+21CsTJX6sA5gOTJxnlKg90Vm9hLemvFGGUkL+YAK2uvuUqQog9XpLB/zT5h6OtiTyXe7Jn4NdIyFPVR+L1JaQniD2OLwUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO+v5+nyGndxh/MpM9FgQ1T3aB7+vOZPLt+NUZuZQ7s=;
 b=T8l0/oO3xRkZxtK6msaYSKIsvuCPEwLfmFTr6IIx89NMGbdsdKbu7C7RGEJ8vpI2IYXqSeYkK56xYg5ZB54Kpi4W7Ska6ttHa8FLEYAG7afyWYnur8L+vFPM7uB7W0PB6Z2V29ftRwSWO6wCfKbK10VHHkoFSgkDNI7kCqLF+zo=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2890.namprd11.prod.outlook.com (2603:10b6:5:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 07:30:15 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 07:30:15 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: RE: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Topic: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Index: AQHXKnapzaN+e8jiOUasbNG/fZUbfKqmp0KAgAEBK4CAAAt/AIAChFHw
Date:   Thu, 8 Apr 2021 07:30:15 +0000
Message-ID: <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
In-Reply-To: <YGyQdN9uS/niyFDP@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6afc7263-5914-4b4e-3683-08d8fa60272c
x-ms-traffictypediagnostic: DM6PR11MB2890:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2890D2F8EEBFD8B604DC194385749@DM6PR11MB2890.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z9tKcenNDtpneub5XlMW8U1456CWhgTcV9mxjG9qE6RXiTKuWMfIoRW2Q6mMl/p9D0xHwPND08aYz/DdQpWFbJqZjdEe+YuQFmHY2jP88WdDtT8UpJdgLcCR5mg0QlByQkceAzKi4sLbA3nCNlIN8KCDpxqPliLcrgVX4AtBPOmVXwY9zVgYbBUT1StvAT7QfSMUft5w3USrdhOIDWqgH7enzUh7W4d342Dbi7oWM1UNpKKjdLzRp1zbOGoPmgAQB0w/I0NbTk3k63J/PX9NL32J2yTUcfQ02D/+kYIaHU0TMA3mXrCbV7ChmmvHfutgU/feGPwxgPKXW23EljgFK8boKO+4pmQDmSHl41EeNx4p6eqosOWzWgys1ZVq2rsHDUWSpnVF7YAyf8TGT7H8YhvrTgoD7x16cioo2z5SG0dw3CWA8mccnAJ1vwbg/FxHP7PKTncvpNLe52hTCEXU5QdspcmBpfngv5kJDC3bVdtIfwJ+CAzbf6p0MriEhrFFg7Sa/BZPCmS2RLi/ToWysRdQBvxln/Az9UiMNjXsKs7QDdNGbXtDskSdU6fyq3B8EjV9N+qjqiu5f5+mObxPXGuTmnP+PFDMWKWUJYVFvFA4ao4Xj8URDn6zbQ7tc6P67gCf3GSIpAqKekqrylP3ygvOQuMi5k/BMPIsfxgb6jc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(366004)(136003)(478600001)(52536014)(8676002)(38100700001)(7416002)(2906002)(26005)(86362001)(6506007)(186003)(8936002)(5660300002)(54906003)(9686003)(7696005)(110136005)(4326008)(30864003)(66946007)(66446008)(71200400001)(66476007)(64756008)(66556008)(55016002)(33656002)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9xcfm4CsgUgpA+oeIVZoMz3cjztxnnGbJZQ0DmYPdnGv2SEAOC2wD0ayjvGB?=
 =?us-ascii?Q?J9RBr8gkaE20r8qvx7vS5L9cmrUTHY/9reNcu9BhKOD5A6hNRNdeO1weR8OT?=
 =?us-ascii?Q?+sAI7IemN8mZd61gPvUNbRC/1DF4CmXKW27ua0J03IMldfmQuInU3wkqGCxk?=
 =?us-ascii?Q?Ci8LtvwlnvfBj8l2jge6qv/XBhLhJ2sFKSBHfefw8jBSMFQtSHmPngXDCMQg?=
 =?us-ascii?Q?m25FdAMDKQzmfyh6wiGJnpdB1k98d1Qe8Pnm8lkv3SQJ5yFivPdOf6K32A2m?=
 =?us-ascii?Q?r9KpSSuH4I1nKWNxcxrS8t8bI8JkV3g8hVOw4bFvrdrcXVxKCAmPErZUNCkx?=
 =?us-ascii?Q?APbSuC8t25BU6KHrFKELXOO0NlmKaUFePSi5z2iGfEt28cs1YSvfsK9C0Vyp?=
 =?us-ascii?Q?YmyLMRg1DdrS/S7QfzyZPL8BKfUONiuj6+fAFeKbqS0tI5p102KPjE+EF+j1?=
 =?us-ascii?Q?P96LKT1sfP6dGR9A6W8q7B1+Wxpm24FWxrkiYUekKgiXENxn6sOSIK7iZoYM?=
 =?us-ascii?Q?1H6IefCjd/XIhlooH4JRXvTfy0kiX42RIPrjOv4i2u7GeTIgnPaDJ3REatW1?=
 =?us-ascii?Q?zANKzK/K6a26ZjB9yMzuWT/8TmWViRW45Dbx37/mOR6pw5EVFkTEtg3fOk2Y?=
 =?us-ascii?Q?8w7+KFKrAwMM50mqoP0r6qdllhCJBRSpa1a35wFk7rflOQFeyP7erSU8JPJs?=
 =?us-ascii?Q?NHmW6OISvuJ74t4h8a/g4d2aXDhY3CYGEOP5lKtu3w09LHp7On0wS9B6rGEV?=
 =?us-ascii?Q?zLJoCRq+cTfdTbMjLt35qTI48stGLUCM4kV0/a2VuRZaSQ9QAzx6+Z6s8b3J?=
 =?us-ascii?Q?4An0JAe2SeW9gxDB8llQaIQBLXB1ESKwKszmwiQUpaKBaDYdJ819gkCSNSJ5?=
 =?us-ascii?Q?ztzLWJfGN+QBcajJZ5Q6Fv24O4zTzYtIvd3ZaqXx44IAZnVclO6EJkAA2w5T?=
 =?us-ascii?Q?sd+IhAFYieFW+taQd7UFTRQ4/ZsRnk8JXCID9IouBSuMTE7gWgpgNVOOHL3c?=
 =?us-ascii?Q?/oYRz0WjGq8S+5sXcIBZYzfNkwEoHS/Uh8cotD6tXx+SpYDTE69r1rlzO0mp?=
 =?us-ascii?Q?7AguLbryBDNzQZbK0hvrXqn6GvGkquhLjfgw+PV6gWRm3LlAx+McAstrQbNj?=
 =?us-ascii?Q?mRughRZE+JgoJGIB+kNkHBF+nVpcA01evLGryYm2cZ6z3e5BjRQ+DLkqKo/Y?=
 =?us-ascii?Q?VV8BbgU2N59C+ZBnpudZgvZgSlbnllH017dR0hz/qGeOTEJKOFDzORgxGCl4?=
 =?us-ascii?Q?N/BXI9jHhdQZKzxv/ItA7TDORpGFyXC31vaOvucYERkN1pAUpskre2DXxfsF?=
 =?us-ascii?Q?sbB0J8B+1mIOMrPS1MGky6NF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afc7263-5914-4b4e-3683-08d8fa60272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 07:30:15.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgoplmKLsWXmf7jr6X2aqfcixMZy9tQpF51zL6lYthLNnsHeiFPBWTp0apBl02V+gpuIrWpysp7Iuing0D5owA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2890
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > On Mon, 5 Apr 2021, Moritz Fischer wrote:
> >
> > > Hi Matthew,
> > >
> > > On Mon, Apr 05, 2021 at 04:53:00PM -0700,
> matthew.gerlach@linux.intel.com wrote:
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >
> > > > This patch adds DFL bus driver for the Altera SPI Master
> > > > controller.  The SPI master is connected to an Intel SPI Slave to
> > > > Avalon Master Bridge, inside an Intel MAX10 BMC Chip.
> > > >
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > ---
> > > >  drivers/fpga/Kconfig          |   9 ++
> > > >  drivers/fpga/Makefile         |   1 +
> > > >  drivers/fpga/dfl-spi-altera.c | 221
> ++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 231 insertions(+)
> > > >  create mode 100644 drivers/fpga/dfl-spi-altera.c
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index d591dd9..0a86994 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -210,6 +210,15 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> > > >  	  the card. It also instantiates the SPI master (spi-altera) for
> > > >  	  the card's BMC (Board Management Controller).
> > > >
> > > > +config FPGA_DFL_SPI_ALTERA
> > > > +	tristate "FPGA DFL Altera SPI Master Driver"
> > > > +	depends on FPGA_DFL
> > > > +	select REGMAP
> > > > +	help
> > > > +	  This is a DFL bus driver for the Altera SPI master controller.
> > > > +	  The SPI master is connected to a SPI slave to Avalon Master
> > > > +	  bridge in a Intel MAX BMC.
> > > > +
> > > >  config FPGA_DFL_PCI
> > > >  	tristate "FPGA DFL PCIe Device Driver"
> > > >  	depends on PCI && FPGA_DFL
> > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > index 18dc9885..58a42ad 100644
> > > > --- a/drivers/fpga/Makefile
> > > > +++ b/drivers/fpga/Makefile
> > > > @@ -45,6 +45,7 @@ dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o=
 dfl-
> afu-dma-region.o
> > > >  dfl-afu-objs +=3D dfl-afu-error.o
> > > >
> > > >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+=3D dfl-n3000-
> nios.o
> > > > +obj-$(CONFIG_FPGA_DFL_SPI_ALTERA)	+=3D dfl-spi-altera.o
> > > >
> > > >  # Drivers for FPGAs which implement DFL
> > > >  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> > > > diff --git a/drivers/fpga/dfl-spi-altera.c b/drivers/fpga/dfl-spi-a=
ltera.c
> > > > new file mode 100644
> > > > index 0000000..9bec25fd
> > > > --- /dev/null
> > > > +++ b/drivers/fpga/dfl-spi-altera.c
> > > > @@ -0,0 +1,221 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * DFL bus driver for Altera SPI Master
> > > > + *
> > > > + * Copyright (C) 2020 Intel Corporation, Inc.
> > > > + *
> > > > + * Authors:
> > > > + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > + */
> > > > +
> > > > +#include <linux/types.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/stddef.h>
> > > > +#include <linux/errno.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/spi/spi.h>
> > > > +#include <linux/spi/altera.h>
> > > > +#include <linux/dfl.h>
> > > > +
> > > > +struct dfl_altera_spi {
> > > > +	void __iomem *base;
> > > > +	struct regmap *regmap;
> > > > +	struct device *dev;
> > > > +	struct platform_device *altr_spi;
> > > > +};
> > > > +
> > > > +#define SPI_CORE_PARAMETER      0x8
> > > > +#define SHIFT_MODE              BIT_ULL(1)
> > > > +#define SHIFT_MODE_MSB          0
> > > > +#define SHIFT_MODE_LSB          1
> > > > +#define DATA_WIDTH              GENMASK_ULL(7, 2)
> > > > +#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
> > > > +#define CLK_POLARITY            BIT_ULL(14)
> > > > +#define CLK_PHASE               BIT_ULL(15)
> > > > +#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
> > > > +#define SPI_CLK                 GENMASK_ULL(31, 22)
> > > > +#define SPI_INDIRECT_ACC_OFST   0x10
> > > > +
> > > > +#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0)
> > > > +#define INDIRECT_WR             BIT_ULL(8)
> > > > +#define INDIRECT_RD             BIT_ULL(9)
> > > > +#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8)
> > > > +#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
> > > > +#define INDIRECT_DEBUG          BIT_ULL(32)
> > > > +#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x10)
> > > > +#define INDIRECT_TIMEOUT        10000
> > > > +
> > > > +static int indirect_bus_reg_read(void *context, unsigned int reg,
> > > > +				 unsigned int *val)
> > > > +{
> > > > +	struct dfl_altera_spi *aspi =3D context;
> > > > +	void __iomem *base =3D aspi->base;
> > > > +	int loops;
> > > > +	u64 v;
> > > > +
> > > > +	writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
> > > > +
> > > > +	loops =3D 0;
> > > > +	while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
> > > > +	       (loops++ < INDIRECT_TIMEOUT))
> > > > +		cpu_relax();
> > > > +
> > > > +	if (loops >=3D INDIRECT_TIMEOUT) {
> > > > +		pr_err("%s timed out %d\n", __func__, loops);
> > > > +		return -ETIME;
> > > > +	}
> > > > +
> > > > +	v =3D readq(base + INDIRECT_RD_DATA);
> > > > +
> > > > +	*val =3D v & INDIRECT_DATA_MASK;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int indirect_bus_reg_write(void *context, unsigned int reg,
> > > > +				  unsigned int val)
> > > > +{
> > > > +	struct dfl_altera_spi *aspi =3D context;
> > > > +	void __iomem *base =3D aspi->base;
> > > > +	int loops;
> > > > +
> > > > +	writeq(val, base + INDIRECT_WR_DATA);
> > > > +	writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
> > > > +
> > > > +	loops =3D 0;
> > > > +	while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
> > > > +	       (loops++ < INDIRECT_TIMEOUT))
> > > > +		cpu_relax();
> > > > +
> > > > +	if (loops >=3D INDIRECT_TIMEOUT) {
> > > > +		pr_err("%s timed out %d\n", __func__, loops);
> > > > +		return -ETIME;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct regmap_config indirect_regbus_cfg =3D {
> > > > +	.reg_bits =3D 32,
> > > > +	.reg_stride =3D 4,
> > > > +	.val_bits =3D 32,
> > > > +	.fast_io =3D true,
> > > > +
> > > > +	.reg_write =3D indirect_bus_reg_write,
> > > > +	.reg_read =3D indirect_bus_reg_read,
> > > > +};
> > > > +
> > > > +static struct spi_board_info m10_bmc_info =3D {
> > > > +	.modalias =3D "m10-d5005",
> > > > +	.max_speed_hz =3D 12500000,
> > > > +	.bus_num =3D 0,
> > > > +	.chip_select =3D 0,
> > > > +};
> > > > +
> > > > +static struct platform_device *create_cntrl(struct device *dev,
> > > > +					    void __iomem *base,
> > > > +					    struct spi_board_info *m10_info)
> > > > +{
> > > > +	struct altera_spi_platform_data pdata;
> > > > +	struct platform_device_info pdevinfo;
> > > > +	u64 v;
> > > > +
> > > > +	v =3D readq(base + SPI_CORE_PARAMETER);
> > > > +
> > > > +	memset(&pdata, 0, sizeof(pdata));
> > > > +	pdata.mode_bits =3D SPI_CS_HIGH;
> > > > +	if (FIELD_GET(CLK_POLARITY, v))
> > > > +		pdata.mode_bits |=3D SPI_CPOL;
> > > > +	if (FIELD_GET(CLK_PHASE, v))
> > > > +		pdata.mode_bits |=3D SPI_CPHA;
> > > > +
> > > > +	pdata.num_chipselect =3D FIELD_GET(NUM_CHIPSELECT, v);
> > > > +	pdata.bits_per_word_mask =3D
> > > > +		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> > > > +
> > > > +	pdata.num_devices =3D 1;
> > > > +	pdata.devices =3D m10_info;
> > > > +
> > > > +	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> > > > +		pdata.num_chipselect, pdata.bits_per_word_mask,
> > > > +		pdata.mode_bits);
> > > > +
> > > > +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> > > > +
> > > > +	pdevinfo.name =3D "subdev_spi_altera";
> > > > +	pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> > > > +	pdevinfo.parent =3D dev;
> > > > +	pdevinfo.data =3D &pdata;
> > > > +	pdevinfo.size_data =3D sizeof(pdata);
> > > > +
> > > > +	return platform_device_register_full(&pdevinfo);
> > >
> > > Should this be a SPI driver? I think looking at the UIO case we had
> > > decided against this pattern?
> >
> > This driver is similar in function to drivers/fpga/dfl-n3000-nios.c whi=
ch
> > uses this design pattern.  Is it okay to keep this design pattern for
> > consistency?
> >
> >
> > >
> > > > +}
> > > > +static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> > > > +{
> > > > +	struct device *dev =3D &dfl_dev->dev;
> > > > +	struct dfl_altera_spi *aspi;
> > > > +
> > > > +	aspi =3D devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
> > > > +
> > > > +	if (!aspi)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	dev_set_drvdata(dev, aspi);
> > > > +
> > > > +	aspi->dev =3D dev;
> > > > +
> > > > +	aspi->base =3D devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> > > > +
> > > > +	if (IS_ERR(aspi->base)) {
> > > > +		dev_err(dev, "%s get mem resource fail!\n", __func__);
> > > > +		return PTR_ERR(aspi->base);
> > > > +	}
> > > > +
> > > > +	aspi->regmap =3D devm_regmap_init(dev, NULL, aspi,
> &indirect_regbus_cfg);
> > > > +	if (IS_ERR(aspi->regmap))
> > > > +		return PTR_ERR(aspi->regmap);
> > > > +
> > > > +	aspi->altr_spi =3D create_cntrl(dev, aspi->base, &m10_bmc_info);
> > > > +
> > > > +	if (IS_ERR(aspi->altr_spi)) {
> > > > +		dev_err(dev, "%s failed to create spi platform driver\n",
> > > > +			__func__);
> > > > +		return PTR_ERR(aspi->base);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
> > > > +{
> > > > +	struct dfl_altera_spi *aspi =3D dev_get_drvdata(&dfl_dev->dev);
> > > > +
> > > > +	platform_device_unregister(aspi->altr_spi);
> > > > +}
> > > > +
> > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > +
> > > > +static const struct dfl_device_id dfl_spi_altera_ids[] =3D {
> > > > +	{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > +	{ }
> > > > +};
> > >
> > > Maybe you can extend the Altera SPI driver with this part?
> >
> > The file, drivers/spi/spi-altera.c, already has platform MODULE_ relate=
d
> > code.  Wouldn't moving this code to that file produce conflicts?
>=20
> I've seen other drivers support multiple busses, so it should be
> possible, there might be nuances I'm missing in my brief look at this,
> though.
>=20
> I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> and the other one MODULE_DEVICE_TABLE(dfl, ...)
>=20
> See drivers/i2c/busses/i2c-designware-platdrv.c for an example (though
> they might be guarding against what you describe with CONFIG_OF vs
> CONFIG_ACPI)
>=20
> If that doesn't work we could split it up into
>=20
> altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> or something of that sort?
>=20
> My point being, now that we have a bus, let's use it and develop drivers
> according to the Linux device model where possible :)

Agree. This does make sense from my side too. DFL core provides the mechani=
sm
to enumerate different IPs on FPGA, but each function driver needs to go to
related subsystem for review.  : )

I understand that for FPGA case, it may have some additional logics for spe=
cific
purposes based on common altera spi master IP, then additional code for=20
a specific product still can be put into altera-spi-xxxx.c or altera-spi-df=
l-xxxx.c

Thanks
Hao

>=20
> Cheers,
> Moritz

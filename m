Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626822DDF5E
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Dec 2020 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgLRIGZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Dec 2020 03:06:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:27133 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgLRIGZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 18 Dec 2020 03:06:25 -0500
IronPort-SDR: FiL2a7yHDTqBRkS4vHB9fHZLgRgUPVzaV68RQfOBlSdzV22M13BkAaaGyeN1M+iN1IUAhUjFbm
 pE6+NAfUMrGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="155201517"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="155201517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 00:05:44 -0800
IronPort-SDR: rD8RyL6Rjdj3yDeg4jtsl23revPuXfiJoM/iWQyvyxNMPYhdf81mDfOBm0cxeYPlzvyRlPrdJt
 32POz5+A5pmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="453747487"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2020 00:05:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Dec 2020 00:05:40 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Dec 2020 00:05:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Dec 2020 00:05:39 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 18 Dec 2020 00:05:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/KE4SykSH3UWpx8Ey8NPVcUy415Y7T1HxsKplSpvFvxv9+u2yMmXQDIS8p/LDTVJnA3PhVoz/ibqyvaLxe4yUFb/q4wlgayatL5OXtfMf1gO6Asjv9zKXE9BynyMrLH9G7RWQC0w55UxNOHD2Onxxh6MQKEh8qEM+R+s0JsMAeH/DsTU4LRRkTPJd3DkRNmWFx7T7mGA/AdFK9pV/2RYEghiMenZiDaOOwwxJnsUGKMMi80HVPRtzV8kSJ0Wl3zPfFC3hrmeLvKbt8ABBhVC+c8icHDOAkd/5sAfDjk9fBa2fJpE5TkMZZ/IVggc9W/ewx5FQkIb0NPnPY04mtAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdS4MdD2rSw3d/YyZVoYlmvj/3aUOT2Dn3J+m92uxUw=;
 b=jzJnVYiasOtjExNLg/zoc2TZW7uH5N7YDLgqyrRwludpw59TsUFDZGfCIQet7YsVc1wpHUr1I3ihzS5EinZHeNceGYfNVlUIw94hDbHd35AhLt8Qx5fkZJJjrLvBrJ+xP94ZcDMaummYlhsQ0NlaqturSXvKvI2if1wsZ3hpo0UF3cM4GyZ0ODX/IqJiO+A6fI+0fsp626Hpei8DPumDx/p90k+/BZod4eKSxlgdqovE7UjAAlQ0KC/gOx7HOvoyMwTCspXIvgJmmC3gNuqFrmlxuO261IthKDJXAvPF+l+usrCqqzq/IJ/Ap/6LcfREvX4RkUb+K9iqCOmtSUb/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdS4MdD2rSw3d/YyZVoYlmvj/3aUOT2Dn3J+m92uxUw=;
 b=qRzoNp46DPvdnWGcOp6BoF2oO+rAhpzBx3kSYbtlwIlxUa3k1XZe4jigTNQsTw9O/0OYr3Vbx/QFBL3fgjuWYhTIqzESB6JODpEr8VNJQElGdlondlI4ljF//K0MOEp1dA+gvD0YGJ2mt3WW1vxvf0Q4PmqBP4LeOPRJLjyJaV8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR1101MB2076.namprd11.prod.outlook.com (2603:10b6:4:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Fri, 18 Dec
 2020 08:05:28 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 08:05:27 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Topic: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Index: AQHW1DhiFXQvRNubJU6hP8U7m1i7W6n8ewGg
Date:   Fri, 18 Dec 2020 08:05:27 +0000
Message-ID: <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0966a67-f4ef-48b4-7e5f-08d8a32bae7d
x-ms-traffictypediagnostic: DM5PR1101MB2076:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2076BA721F93E91A3EF2431385C30@DM5PR1101MB2076.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M3ZzUGbmvDQZxlp7cXkVWOzD9RXlKCAqv6UjSoieyyA2JaIUeFQ8p7avBltCAlDY6o+x659lKlb99mwdH04J7EHwMKCLpYvBMabv2XtQFefhhTPMSNDm4pdknCjZh7Rw9v8O23wYbHE2OsX9gR58V8w6yr7tHY7TPNNKuIXey0rftln0VqG0tjFaht8/TkVXeC91yBDb9AgsgzExdURkEb9VVQAQVAXLoq65jpv0DQfqX8Kjn36tfsKGwazPeYSueclq4VuGebWgiKIKKLdZyR3mdiiGyVxQRIPGRtmDHBBHD20k6c2zGNhIV1xtT9xxMYwjhnLvEhIMDST0wdzJxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66946007)(66476007)(66446008)(64756008)(76116006)(316002)(7696005)(8676002)(55016002)(71200400001)(66556008)(4326008)(5660300002)(86362001)(52536014)(33656002)(8936002)(110136005)(186003)(9686003)(478600001)(6506007)(54906003)(2906002)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ikUHm7WBcI2u3dGAskWF8yZduAj8k/6YXiJ+icF8fo95Ob1B4H7SNHCvZJkW?=
 =?us-ascii?Q?FgSkBO8+1m6nWfPjz5FOBOUKILvWluNL2zVuSNLyvVI7kbk2QNvXlO+zrS+9?=
 =?us-ascii?Q?3smPSvuG+zFyMSqvLJE4soQ2oCueKiMRf9mJzMIGfwSotf837BIzAlTO3E/E?=
 =?us-ascii?Q?jir5O0y57ovIveCTEUxVj2vW+fUlihHL5h5qEv21dWVWX7RkIcH+U7aGdx5e?=
 =?us-ascii?Q?vOOaTm0HOXIS2MBMLbuY8koshsQwf4gLZdAXlSYZuWws0GLM0TaRTWFGZ8Gs?=
 =?us-ascii?Q?aY9s88lMpxKAONfvuagVxxOw/H84US/hnMpfWk+RtEe7lkRTEmRr7docrP1C?=
 =?us-ascii?Q?5Ce77hmOj9DgDxAGXWkExPrARcfv/6Oj1fLyjlku2MU9DefH4mJ7Map286+1?=
 =?us-ascii?Q?YdYcj4ycGG95ENgO5DtQoWYI5NT051y/4upBSpASzyiDTxrmFMSM7y6j4ava?=
 =?us-ascii?Q?TN9NPrNHG7jZnTT/0JsGlCZSyXGghvHAFgiBww9J8NYJdJdUxzUXHJCUaudy?=
 =?us-ascii?Q?SgPhNcjs1R4q8YrE/LTtexHumvcXvFYyzGz9IVt4yVF1vPQq1gkFM5bvxJOO?=
 =?us-ascii?Q?484dFHo/goxlVHlYSdGxAOamZRrrrX0WGHmWN1MDryY9VJu/SyE+ywMh6PYq?=
 =?us-ascii?Q?cCyqLkLabzUPeOmbSUCOiSTLavAQnWpCDH+GqlQZHY1E11DPHU2NqAu/E/en?=
 =?us-ascii?Q?Wkn1DKIll/K/cDiYDGBamiD5CFn8FGnrdSr221I8REOMY8BsXtPqNtvtX7+1?=
 =?us-ascii?Q?kulIq4nKqcH3fkXY3CS3h/STqc/+El9nefuyO6ioTgJ2lPntwhDNIM/aktJj?=
 =?us-ascii?Q?DRxlk40qGoPG+8d00FaGCWRUl8u0sAUBFK4/yAhw/Z3MrDQlcvIpDLbRzAT2?=
 =?us-ascii?Q?EFSjJyb9RH1dD2naHSfYdx02Y8YHpyFk4O1xjUd2Ofo757exYKhD1n1K3IC5?=
 =?us-ascii?Q?oU7JhTElW2t7CPzt1D3+L4lTvDZlU+pPCUd4I2OC5zc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0966a67-f4ef-48b4-7e5f-08d8a32bae7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 08:05:27.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AncBp/a08JiyXzWLsf8q4gOcPeqn+hlA4tAe2S0YYTXuQ8xURQeVfdVYLRW2OUNeAuVSsy/r/uVoM2+xUp/sYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2076
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support f=
or
> DFL devices
>=20
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
>=20
> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> platform device with the DFL device's resources, and let the generic UIO
> platform device driver provide support to userspace access to kernel
> interrupts and memory locations.
>=20
> The driver matches DFL devices in a different way. It has no device id
> table, instead it matches any DFL device which could not be handled by
> other DFL drivers.

Looks like we want to build UIO driver as the default/generic driver for DF=
L,
it seems fine but my concern is that UIO has its own limitation, if some da=
y,
dfl device is extended, but UIO has limitation, then we may need to select=
=20
another one as the default driver.. or we can just match them using=20
id_table as we know UIO meets the requirement for those DFL devices?

>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: switch to the new matching algorithem. It matches DFL devices which
>      could not be handled by other DFL drivers.
>     refacor the code about device resources filling.
>     fix some comments.
> v3: split the dfl.c changes out of this patch.
>     some minor fixes
> ---
>  drivers/fpga/Kconfig        |  10 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-uio-pdev.c | 110
> ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5d7f0ae..7a88af9 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>  	  the card. It also instantiates the SPI master (spi-altera) for
>  	  the card's BMC (Board Management Controller).
>=20
> +config FPGA_DFL_UIO_PDEV
> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> +	help
> +	  Enable this to allow some DFL drivers be written in userspace. It
> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
> +	  resources, and lets the generic UIO platform device driver provide
> +	  support for userspace access to kernel interrupts and memory
> +	  locations.

If we consider this as a default driver for everybody in DFL, then we could
consider build it into the core, otherwise it always requires to be loaded
manually, right?

> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885..8847fe0 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -45,6 +45,7 @@ dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o dfl-a=
fu-
> dma-region.o
>  dfl-afu-objs +=3D dfl-afu-error.o
>=20
>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+=3D dfl-n3000-nios.o
> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+=3D dfl-uio-pdev.o
>=20
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> new file mode 100644
> index 0000000..8c57233
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL driver for Userspace I/O platform devices
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + */
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uio_driver.h>
> +
> +#include "dfl.h"
> +
> +#define DRIVER_NAME "dfl-uio-pdev"
> +
> +static struct dfl_driver dfl_uio_pdev_driver;
> +
> +static int check_for_other_drv_match(struct device_driver *drv, void *da=
ta)
> +{
> +	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> +	struct dfl_device *ddev =3D data;
> +
> +	/* skip myself */
> +	if (ddrv =3D=3D &dfl_uio_pdev_driver)
> +		return 0;
> +
> +	return dfl_match_device(ddev, ddrv);
> +}
> +
> +static int dfl_uio_pdev_match(struct dfl_device *ddev)
> +{
> +	/*
> +	 * If any other driver wants the device, leave the device to this other
> +	 * driver.
> +	 */
> +	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev,
> check_for_other_drv_match))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> +{
> +	struct device *dev =3D &ddev->dev;
> +	struct platform_device_info pdevinfo =3D { 0 };
> +	struct uio_info uio_pdata =3D { 0 };
> +	struct platform_device *uio_pdev;
> +	struct resource *res;
> +	int i;
> +
> +	pdevinfo.name =3D "uio_pdrv_genirq";
> +
> +	res =3D kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res[0].parent =3D &ddev->mmio_res;
> +	res[0].flags =3D IORESOURCE_MEM;
> +	res[0].start =3D ddev->mmio_res.start;
> +	res[0].end =3D ddev->mmio_res.end;
> +
> +	/* then add irq resource */
> +	for (i =3D 0; i < ddev->num_irqs; i++) {
> +		res[i + 1].flags =3D IORESOURCE_IRQ;
> +		res[i + 1].start =3D ddev->irqs[i];
> +		res[i + 1].end =3D ddev->irqs[i];
> +	}

How many interrupts UIO could support? or we need some
warning or just even return error here?

Thanks
Hao

> +
> +	uio_pdata.name =3D DRIVER_NAME;
> +	uio_pdata.version =3D "0";
> +
> +	pdevinfo.res =3D res;
> +	pdevinfo.num_res =3D ddev->num_irqs + 1;
> +	pdevinfo.parent =3D &ddev->dev;
> +	pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> +	pdevinfo.data =3D &uio_pdata;
> +	pdevinfo.size_data =3D sizeof(uio_pdata);
> +
> +	uio_pdev =3D platform_device_register_full(&pdevinfo);
> +	if (!IS_ERR(uio_pdev))
> +		dev_set_drvdata(dev, uio_pdev);
> +
> +	kfree(res);
> +
> +	return PTR_ERR_OR_ZERO(uio_pdev);
> +}
> +
> +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
> +{
> +	struct platform_device *uio_pdev =3D dev_get_drvdata(&ddev->dev);
> +
> +	platform_device_unregister(uio_pdev);
> +}
> +
> +static struct dfl_driver dfl_uio_pdev_driver =3D {
> +	.drv	=3D {
> +		.name       =3D DRIVER_NAME,
> +	},
> +	.match	=3D dfl_uio_pdev_match,
> +	.probe	=3D dfl_uio_pdev_probe,
> +	.remove	=3D dfl_uio_pdev_remove,
> +};
> +module_dfl_driver(dfl_uio_pdev_driver);
> +
> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4


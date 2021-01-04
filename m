Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C62E8FC7
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Jan 2021 05:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhADERX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Jan 2021 23:17:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:12344 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbhADERX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 3 Jan 2021 23:17:23 -0500
IronPort-SDR: +2B57PQvRpJvItshljIr+ydzOps1ti0zfh0jiMcWlcy9Xlifuad1yZm6kNEmvlHrHRyvldXCV3
 mmIxrH74sGMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="164613979"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="164613979"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 20:16:40 -0800
IronPort-SDR: wGiuTsuX0nfRmGHFy4Xella8ZvlYLLwxVghbe0uqV4jQe3Aiu063QcCXz0S5u1B0oLjw45QKuH
 82ce14jlYFxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="564981101"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2021 20:16:40 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 3 Jan 2021 20:16:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 3 Jan 2021 20:16:40 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 3 Jan 2021 20:16:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEAUPxj41etv/Z8KiwxGNDgnozNo8WkCOLRX4Og4P7WAYaaASSc1clCjg5TZx79IfPbzwcG4QXIMe91QiU1XFogX9XZ5DTrP9DOb5Fa7SQjM3cceSO6aPJBU+eKpg8E610kURE0+fGzrLmpKRyVYxy/cm5OE6NC/c0cAH3leaTChRdlGf/GhPjD0IPGKDzdPB1t8h7xRECkZ31rjstj0W231lr1u0BwI6kGsNWO1eo/gPhMNsrMX+1ZOiC59cT63+Vw0SxjaVHORCfws3UKPZLrzcWsAH7QLYfkSeGZcdSIiozBjiuOLo1A3GVBY9XDHt/gqZOSE4Ujkl1jb3hGl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T49irbvEa5BbEqw5ab7AF227UTVYjq711gEKGG4K/VM=;
 b=ESnvKliVeyB8gDw7UZMmMVJSn2AKAvYxZgK2jJeEU2QLDTgCejddnGO9qWZFsIhZj0j2RmdcB0ohlEN0Vr7wgUrAEFzqblGPcSNO1FsUDPuRq6mIJArnKXRGqwJZhLgDdDrUVKw4PVZ5pXc6pjyBQIHdlSx/OodJvqfBTk1bvJPhTQHnL2O6f3qRjRCx7KVKq4lot2su9DPVoYYx0N+QkOHjuVOT3xyguQtq2pKIn7UffyjxM+MBsjFBwDCqEQIAZCcwkIZvCfzYoAbq9p4slP3UmGeoEj2aTFAJGn6uQIJtO4PjtXSU7wek2DhPHnJWnpf7051x7LuJgnHQazx8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T49irbvEa5BbEqw5ab7AF227UTVYjq711gEKGG4K/VM=;
 b=J81ZcUDj79ClOfkD85W0J8stfjDM1Sy20rL+Rq+ZKUq0htt/fivf//uuMUMcRqAgZaiFQ/f8FxubChC4gRF/9B0mUBMC5lrDh76jDGu+salvXHSgDwmN66QLrh39xIEMD+XkwuD5NVUI6ax8JqAOYHbEvEH6QWxnNOTLYRyom88=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1946.namprd11.prod.outlook.com (2603:10b6:3:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 04:16:30 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 04:16:30 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Topic: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Thread-Index: AQHW4LXe3nonxx0vVECVxOQy3msn7KoW3Q0g
Date:   Mon, 4 Jan 2021 04:16:30 +0000
Message-ID: <DM6PR11MB3819CD80A065FC474128454B85D20@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c72bdabd-dadd-4c40-a67a-08d8b0678394
x-ms-traffictypediagnostic: DM5PR11MB1946:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1946DA3B7380B2AF454789DC85D20@DM5PR11MB1946.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqXnCZ1lQsvBE94sTa8RpMclrd/BXEEFK6ActuHJe1HJKjqagOPj4R7uYUQMVW2SSPahsEO+t8vlueFVhZgrgbehHn+HbTa4AY6GRiTT5Xd4n1/YNOjF5lfsmy2WfHrtK24On0Bfwm+bj0qwT7qnmEhUUZlTexJLh3v9sP0vVtGrOZZsyUlrmdf1UYC+xkeqIBrHCGVVBOTy/9TympHf0JbXr8T1wRjyK/9KzQO2o1nsAclI+DQsDua/aHHJPa8w5Rk2VUpuk+62jAeufoWNa3YKQYHv4bWUvF+xK7R52EAEXqdo5EopY7h5Ir/zYZlh4MIU0pFqGZ1RG+nua5v64pTlj+AbyQHLOC31Ge/20PpNkGX/aVy7yDtRJdEhpwgZPYc6ZJa8fcSbSIsrsMTGtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(76116006)(64756008)(66476007)(66556008)(66446008)(66946007)(55016002)(9686003)(478600001)(26005)(110136005)(52536014)(186003)(316002)(86362001)(2906002)(5660300002)(33656002)(54906003)(71200400001)(8676002)(7696005)(6506007)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UQIGm5PkelcSnGh3YTz2yx/zEZCZ4GpZ46Jx8f24xjk1rgyojzvzQVEXYXDs?=
 =?us-ascii?Q?/hAEztQ6cqPD7TAia/raztux8z5e14dqPq+U3BzTFxVBnsoUyNaA3KeYlJLt?=
 =?us-ascii?Q?SxH4+MxDuZWpHisCj5Nfg8pYi0ZFKLWx69BOfOblz5E2DVJoI3ruu2lR+QIl?=
 =?us-ascii?Q?nMXsXvnMOJKu9eXzLuM31giXIEg3326YJgeCAI46CDGXBlw9NEOYRiiOiaPJ?=
 =?us-ascii?Q?UUmz0MXFcTV4+5oxpwC8SBzg7MhzK1m0YYYRlq+G/rQFI3d4Wh+wiCsQhE+C?=
 =?us-ascii?Q?LcrxEnxUeb+MM47jbyekL5DpqlfKcGB/6ifOZPY7mGunnafBg5zX0k3i7fy/?=
 =?us-ascii?Q?hXuuJXEBUsITqbHHohfZELcFMNiDiVkIBTtyBxeyMXVBgv9jSABh3/fb7QXP?=
 =?us-ascii?Q?wyHj38rToyNl6B0aiWkyVu7F0HVR6t7uUQkqd8sXST7Vb4RwYbA8CSO8nlTc?=
 =?us-ascii?Q?GgE4vnoWjYdRK2U7pSbKcD6X787Mk9cNIxgtlhqmuAHqvPAO/VSynAutfvpR?=
 =?us-ascii?Q?OxK8ayv0fGCtcvy3xAmuldhWN8XIoX9pcvICMiL/yCZ7ErAqk0mDvVScbfXh?=
 =?us-ascii?Q?f1Bd2bM2zi1rfCUccaKNUI2T1jexJMvQb0orUcmyWR2/n4C5Cn6zolMC/C9k?=
 =?us-ascii?Q?61wOjw5vQL/GK9FPSwUXd3R58PaATFoWSLo+cEdKCzbFQPGDZK0MBdjHVjTS?=
 =?us-ascii?Q?LzH4t2Y8xJrRe3Aj8gkpkOZixBL57SsBlh2/PXIM7xvrcf+bVx+eNz5eQAZz?=
 =?us-ascii?Q?TbPvyZW8TgRpZtwwpk9xmSlEbQ3zaB5+1tTtCTElWuIamQdAyYv18dGhfG2K?=
 =?us-ascii?Q?5NYr44BqBoxASFLB3n9qT4I1z7idFW4eipEjB+OVfvYZUb+sZKnX6KYkUlcH?=
 =?us-ascii?Q?y+FtLFp+1gJbvNtTDAEpSWYWci+2/Q0sbcYFjL3sVmq6i6JBhulqn7P93JIm?=
 =?us-ascii?Q?5frmm/1qOCrj/J5bUo2pmngNsDD/iYsRt5LP5guMMJU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72bdabd-dadd-4c40-a67a-08d8b0678394
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 04:16:30.7613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3TeDXuvrgK+VhioANG6dDNK7tTwqCoEKe0P4DW4p8XBUxmBf4QB8egHh6u5IUAJxxorpo9cXitxcLYrCogu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1946
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support f=
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
> The driver now supports the ether group feature. To support a new DFL
> feature been directly accessed via UIO, its feature id should be added to
> the driver's id_table.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: switch to the new matching algorithem. It matches DFL devices which
>      could not be handled by other DFL drivers.
>     refacor the code about device resources filling.
>     fix some comments.
> v3: split the dfl.c changes out of this patch.
>     some minor fixes
> v4: drop the idea of a generic matching algorithem, instead we specify
>      each matching device in id_table.
>     to make clear that only one irq is supported, the irq handling code
>      is refactored.
> v5: refactor the irq resource code.
> ---
>  drivers/fpga/Kconfig        | 10 +++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 91
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5ff9438..61445be 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
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
> index 0000000..a4cd581
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,91 @@
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
> +#define DRIVER_NAME "dfl-uio-pdev"
> +
> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> +{
> +	struct platform_device_info pdevinfo =3D { 0 };
> +	struct uio_info uio_pdata =3D { 0 };
> +	struct platform_device *uio_pdev;
> +	struct device *dev =3D &ddev->dev;
> +	unsigned int num_res =3D 1;
> +	struct resource res[2];
> +
> +	res[0].parent =3D &ddev->mmio_res;
> +	res[0].flags =3D IORESOURCE_MEM;
> +	res[0].start =3D ddev->mmio_res.start;
> +	res[0].end =3D ddev->mmio_res.end;
> +
> +	if (ddev->num_irqs) {
> +		if (ddev->num_irqs > 1)
> +			dev_warn(&ddev->dev,
> +				 "%d irqs for %s, but UIO only supports the
> first one\n",
> +				 ddev->num_irqs, dev_name(&ddev->dev));
> +
> +		res[1].flags =3D IORESOURCE_IRQ;
> +		res[1].start =3D ddev->irqs[0];
> +		res[1].end =3D ddev->irqs[0];

Looks like res[] needs to be zeroed for other fields not used here.
other places look good to me.

Hao

> +		num_res++;
> +	}
> +
> +	uio_pdata.name =3D DRIVER_NAME;
> +	uio_pdata.version =3D "0";
> +
> +	pdevinfo.name =3D "uio_pdrv_genirq";
> +	pdevinfo.res =3D res;
> +	pdevinfo.num_res =3D num_res;
> +	pdevinfo.parent =3D &ddev->dev;
> +	pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> +	pdevinfo.data =3D &uio_pdata;
> +	pdevinfo.size_data =3D sizeof(uio_pdata);
> +
> +	uio_pdev =3D platform_device_register_full(&pdevinfo);
> +	if (!IS_ERR(uio_pdev))
> +		dev_set_drvdata(dev, uio_pdev);
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
> +#define FME_FEATURE_ID_ETH_GROUP	0x10
> +
> +static const struct dfl_device_id dfl_uio_pdev_ids[] =3D {
> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +
> +	/* Add your new id entries here to support uio for more dfl features
> */
> +
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, dfl_uio_pdev_ids);
> +
> +static struct dfl_driver dfl_uio_pdev_driver =3D {
> +	.drv	=3D {
> +		.name       =3D DRIVER_NAME,
> +	},
> +	.id_table =3D dfl_uio_pdev_ids,
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


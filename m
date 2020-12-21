Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25B22DF939
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Dec 2020 07:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgLUGYZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Dec 2020 01:24:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:30633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgLUGYY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Dec 2020 01:24:24 -0500
IronPort-SDR: L0jTgr5WXVY7EJR+PhjgQwbGLO8dFJfX7W2aWSId7Nq9ZCGI9t0bUQV1w0MtetaJp4vZFCkjRW
 ITIzvU4i4YDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="154901593"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="154901593"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 22:23:42 -0800
IronPort-SDR: 6fRL5YIie7ZH8qs95+H0gFqvcmcx9ABSBvArZoUpWoDym5FV7bmYGVf2MI/3A9qJiSWeUMAvgN
 21zMfoI6hn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="560555022"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2020 22:23:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Dec 2020 22:23:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Dec 2020 22:23:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Dec 2020 22:23:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 20 Dec 2020 22:23:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBr3SWMrxYEtbHpq/K3R/vTltq/UdFmwLqe6ODgrSkgPdEWPPTfLAQ3Z8OBPSgroAbxjIW7zuwqpo3Xto0hDh78pNignTVxdIAlRVu2JvdpnVrlG8xUwWvnP0JvWYO3ksQ6lQsG1hBw36e6aW9sio3q0sY7u4DnZic3vSVcP3vppldTCTOAtt+jWYveT2mDzNOZ5H6UdJ+zK+EvDYKTIEXDuq6O8LhwHLMyQpU3J0XPb+UlXcor2dzbLnRmj7zJ/cJ2aWpADpn65hPHlqYbtSLvZn+3Vky3KhO9JYMEa5Ni0018GFJ9Ly7j9ASU2bZYqltsJtXWjE7O1YLrnM9yA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE036yGxufsst+HDiCbQ6F669cTDu5HaI3tcDcnKYmw=;
 b=Ysj1VY/EqyI7jHnPHYNpv0/H5m7kEcuJyeA7b+KHFIdYsw5EUVL8XJiMHvt9ymVADHMtpWt3S8OcHu9E52gaR9hGtetiNGsocZfmogXtoycw0/kiF+SQPA3RKWwtsFRExzVaRBRb9B3dMQ2PjjaoELvFayUTNz/V5UQMKAiCDFXu+OVafmVy3vlPL/6zxk2wNMUCYzQNcWOMWca2+ad7yiTrdZR/W4QEp/20vvUJRRN0Yrq+fnHJpXbmMafnH/0u1u7Wz/jok69/s/mcp2dxldDPjOb1pF5zyDNm8s+BVSg0GBVadl9DGjhGQOhxoGwj2vn1DPcmNTDldnz4DUM7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE036yGxufsst+HDiCbQ6F669cTDu5HaI3tcDcnKYmw=;
 b=Q0Iu7dBIs/4HHbxkvpPm+Q4pWlMBFiG1rgdLZoZCJq9ARxqa6B+xOe3CqGKY10FTQx/2+X6ZbX05LnVlm2fVVFyOC6FtztAVhro9P7J22Fu86bppQStwLDp7Gw9xjm7EUn3Lgtt6aTXiHmSr1n3hZOS/VCL4TDvquFSJB51c4dI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3242.namprd11.prod.outlook.com (2603:10b6:5:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Mon, 21 Dec
 2020 06:23:38 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 06:23:38 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
  for DFL devices
Thread-Topic: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
  for DFL devices
Thread-Index: AQHW10q5410K+lIVqE2aiRicO6yYV6oBDZyw
Date:   Mon, 21 Dec 2020 06:23:38 +0000
Message-ID: <DM6PR11MB3819C105F324C0E6CF2747D385C00@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
 <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
 <20201221033346.GE14854@yilunxu-OptiPlex-7050>
In-Reply-To: <20201221033346.GE14854@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c5c81d5-5a60-4e76-d084-08d8a578f461
x-ms-traffictypediagnostic: DM6PR11MB3242:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3242FC82092BAE7E7DB853FB85C00@DM6PR11MB3242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLeggT28Vps9rGBKqrr7/0lubWHFmrBU213QOeWVM8+QMYTzE0yUSFuRIKGNe50Zw73Mj4jkpBbaLM5dWyA72HcwG+k5CBEXcsxi8BdbgbUyx5c06v0QNnFBzT+15hdOunYHeUQxJwFh4ub7HPGg8QVRJgPEqvOpOKIyPFcVuHVbwp2dcL3b8pE2mNCdmlYys3YVIl02cjIGgjHLVhQqBmoFyD2thZ1j6Ia0Y41RqZBNoFrLhohbVKNM83mT48jJYhfKOp4bBrmBnRtAyb40um0rxX/cvK9kob6bs0Ioa0ozQQAj2+g2ZHlPrrIENvVZRpT+zlKm0wb3ehvSUq8PNB1S9KZAmDpst7DEYPJzi4aG12VCzEmY74jS0GQVE+aqvffsT3nZnuQUVOSGk7YlGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(2906002)(6506007)(8936002)(316002)(53546011)(64756008)(66446008)(76116006)(186003)(83380400001)(86362001)(110136005)(66946007)(7696005)(66476007)(26005)(54906003)(71200400001)(478600001)(55016002)(5660300002)(52536014)(9686003)(4326008)(33656002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mPPtUmhNEHbkG1o5pDmjJkyHgzgjNShoBpWvdkOC76pWalcIOOwsF+u+IK0s?=
 =?us-ascii?Q?yNmGGoYyh4hWDH4rxjB9EQz2SyZCh2M1NBxbapiM1QWmi1c0TrXiD4WcYcKu?=
 =?us-ascii?Q?99BkmBhJURVXjfet3BjIqqPKkaMIGvFYkog0noizgI5HiH6M1TLbOKfnSJ86?=
 =?us-ascii?Q?SqEXLxLbNjMom9ePkyVtab8A0yjveO7TwZsILNonEYGQcuPu9c4f24UdRAc2?=
 =?us-ascii?Q?rz2wfbvIVQHL30h01URlLYJ2LaVplVbyMjfCMboY5AsOPk6ntUKdx3dt6krv?=
 =?us-ascii?Q?g2o/w937XYzC4n/Arl07AXPO1/xDkfk6c53EXNWByrAUN+/hP2fVy9dsSJdC?=
 =?us-ascii?Q?KafS/lG50vX3/DDXaLmsZxLJY0XXIWhPUmXoKSlo/WmDjHkKqGoctjsaIVBJ?=
 =?us-ascii?Q?DrDRopRjg/U+kmM022rdj2ywfhDaAUqJlSOkEUgFr4ioU8YSL3+A7hy8BCMo?=
 =?us-ascii?Q?ddV8pxgWUfEn9UjHYIauE0xiMUEP7HZumq6HSyboPG0bkDDeZ+M303kK6Fmw?=
 =?us-ascii?Q?0gkGwiXhiFyPSIJE5/nUSRtC6YotH/hq1sgz3+F891vyfPfO1mw0MWalXqHK?=
 =?us-ascii?Q?K8yXtlK+qYEAtvCBJuEPFWW8FNUBL6N1IGn8jKHO0lGONyc+yC5A/ujaV9JK?=
 =?us-ascii?Q?/4BPJIflmVSwtvjFOU3fYNk0b0eDnKQsDuEd+nm1iIxwKLC7adit6a6+l/Ly?=
 =?us-ascii?Q?0FWNZg1kFtCayhRzjivQGAE6nMs9iXLl5tfu8W3+BdgPti4KHrN4JT5wdbh7?=
 =?us-ascii?Q?tu0mUtX+hxWBhqpjM5SxwB0lz4TSPbEFPz0KTP8YJzUq5rs89eCrNdXQOT5X?=
 =?us-ascii?Q?JlSjuu4pG+HWcRXtCBvroXfuhW9ZOqdAWgZQaf32UClmvepkXh+/N+scudTp?=
 =?us-ascii?Q?4ibDyGkSq/URsQp56EMCs/VQL0txCQxE2S4RMDbNEYPOv1jrPIbLEavfD5tw?=
 =?us-ascii?Q?ciARzztTPLxe/9W3d0bVxb4Ovk2IPO9wdgaGzvdHvgA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5c81d5-5a60-4e76-d084-08d8a578f461
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 06:23:38.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsKP30c2uxpcXHw6aWHG/yB/xRCpGwOLki5pv64Hg+Op4EBzFPEULozyqd0QYIj4AQ8+Un93787fb5a//RobHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3242
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device suppo=
rt
> for DFL devices
>=20
> On Fri, Dec 18, 2020 at 05:59:17AM -0800, Tom Rix wrote:
> >
> > On 12/18/20 12:05 AM, Wu, Hao wrote:
> > >> Subject: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device supp=
ort
> for
> > >> DFL devices
> > >>
> > >> This patch supports the DFL drivers be written in userspace. This is
> > >> realized by exposing the userspace I/O device interfaces.
> > >>
> > >> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genir=
q
> > >> platform device with the DFL device's resources, and let the generic=
 UIO
> > >> platform device driver provide support to userspace access to kernel
> > >> interrupts and memory locations.
> > >>
> > >> The driver matches DFL devices in a different way. It has no device =
id
> > >> table, instead it matches any DFL device which could not be handled =
by
> > >> other DFL drivers.
> > > Looks like we want to build UIO driver as the default/generic driver =
for
> DFL,
>=20
> I'm not going to make UIO as the default driver for DFL devs, the driver
> module will not be autoloaded. I want to provide a choice to operate on
> the unhandled devs in userspace. Insmod it if it helps otherwise leave
> it.

But once it's loaded, then it will bind with all dfl devices which doesn't =
have
a matched driver yet.=20

>=20
> > > it seems fine but my concern is that UIO has its own limitation, if s=
ome
> day,
> > > dfl device is extended, but UIO has limitation, then we may need to s=
elect
> > > another one as the default driver.. or we can just match them using
>=20
> I think we may not have to select a "default" driver, if we have a
> better way for userspace accessing, we could load that module, leave
> UIO.

It would not be an easy decision, it may impact users who have already
built upper layer software on top of UIO, and ask new users to use new
one too. Users may not be happy with this.

>=20
> > > id_table as we know UIO meets the requirement for those DFL devices?
>=20
> As we discussed, the drawback is that we should always change the code to
> support a new dfl device for user accessing. But it is OK to me if the
> generic UIO match rule is not considered proper.
>=20
> >
> > When we have multiple defaults, could this be handled in the configury =
?
>=20
> I think we don't have to select a "default".

Actually I am fine with the idea of using a default / generic driver for DF=
L
device, and my only concern is UIO may not be good enough for us per my
understanding. Maybe we can have a more extendable one as the generic
driver, but if we don't have that yet, then using id table may be able to
avoid some problems I think.

Hao

>=20
> >
> > Tom
> >
> > >
> > >> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > >> ---
> > >> v2: switch to the new matching algorithem. It matches DFL devices wh=
ich
> > >>      could not be handled by other DFL drivers.
> > >>     refacor the code about device resources filling.
> > >>     fix some comments.
> > >> v3: split the dfl.c changes out of this patch.
> > >>     some minor fixes
> > >> ---
> > >>  drivers/fpga/Kconfig        |  10 ++++
> > >>  drivers/fpga/Makefile       |   1 +
> > >>  drivers/fpga/dfl-uio-pdev.c | 110
> > >> ++++++++++++++++++++++++++++++++++++++++++++
> > >>  3 files changed, 121 insertions(+)
> > >>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> > >>
> > >> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > >> index 5d7f0ae..7a88af9 100644
> > >> --- a/drivers/fpga/Kconfig
> > >> +++ b/drivers/fpga/Kconfig
> > >> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> > >>  	  the card. It also instantiates the SPI master (spi-altera) for
> > >>  	  the card's BMC (Board Management Controller).
> > >>
> > >> +config FPGA_DFL_UIO_PDEV
> > >> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> > >> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> > >> +	help
> > >> +	  Enable this to allow some DFL drivers be written in userspace. I=
t
> > >> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
> > >> +	  resources, and lets the generic UIO platform device driver provi=
de
> > >> +	  support for userspace access to kernel interrupts and memory
> > >> +	  locations.
> > > If we consider this as a default driver for everybody in DFL, then we=
 could
> > > consider build it into the core, otherwise it always requires to be l=
oaded
> > > manually, right?
>=20
> It should be loaded manually. I don't want to make this as default.
>=20
> > >
> > >> +
> > >>  config FPGA_DFL_PCI
> > >>  	tristate "FPGA DFL PCIe Device Driver"
> > >>  	depends on PCI && FPGA_DFL
> > >> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > >> index 18dc9885..8847fe0 100644
> > >> --- a/drivers/fpga/Makefile
> > >> +++ b/drivers/fpga/Makefile
> > >> @@ -45,6 +45,7 @@ dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o =
dfl-
> afu-
> > >> dma-region.o
> > >>  dfl-afu-objs +=3D dfl-afu-error.o
> > >>
> > >>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+=3D dfl-n3000-
> nios.o
> > >> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+=3D dfl-uio-pdev.o
> > >>
> > >>  # Drivers for FPGAs which implement DFL
> > >>  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> > >> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev=
.c
> > >> new file mode 100644
> > >> index 0000000..8c57233
> > >> --- /dev/null
> > >> +++ b/drivers/fpga/dfl-uio-pdev.c
> > >> @@ -0,0 +1,110 @@
> > >> +// SPDX-License-Identifier: GPL-2.0
> > >> +/*
> > >> + * DFL driver for Userspace I/O platform devices
> > >> + *
> > >> + * Copyright (C) 2020 Intel Corporation, Inc.
> > >> + */
> > >> +#include <linux/dfl.h>
> > >> +#include <linux/errno.h>
> > >> +#include <linux/kernel.h>
> > >> +#include <linux/module.h>
> > >> +#include <linux/platform_device.h>
> > >> +#include <linux/slab.h>
> > >> +#include <linux/uio_driver.h>
> > >> +
> > >> +#include "dfl.h"
> > >> +
> > >> +#define DRIVER_NAME "dfl-uio-pdev"
> > >> +
> > >> +static struct dfl_driver dfl_uio_pdev_driver;
> > >> +
> > >> +static int check_for_other_drv_match(struct device_driver *drv, voi=
d
> *data)
> > >> +{
> > >> +	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> > >> +	struct dfl_device *ddev =3D data;
> > >> +
> > >> +	/* skip myself */
> > >> +	if (ddrv =3D=3D &dfl_uio_pdev_driver)
> > >> +		return 0;
> > >> +
> > >> +	return dfl_match_device(ddev, ddrv);
> > >> +}
> > >> +
> > >> +static int dfl_uio_pdev_match(struct dfl_device *ddev)
> > >> +{
> > >> +	/*
> > >> +	 * If any other driver wants the device, leave the device to this =
other
> > >> +	 * driver.
> > >> +	 */
> > >> +	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev,
> > >> check_for_other_drv_match))
> > >> +		return 0;
> > >> +
> > >> +	return 1;
> > >> +}
> > >> +
> > >> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> > >> +{
> > >> +	struct device *dev =3D &ddev->dev;
> > >> +	struct platform_device_info pdevinfo =3D { 0 };
> > >> +	struct uio_info uio_pdata =3D { 0 };
> > >> +	struct platform_device *uio_pdev;
> > >> +	struct resource *res;
> > >> +	int i;
> > >> +
> > >> +	pdevinfo.name =3D "uio_pdrv_genirq";
> > >> +
> > >> +	res =3D kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> > >> +	if (!res)
> > >> +		return -ENOMEM;
> > >> +
> > >> +	res[0].parent =3D &ddev->mmio_res;
> > >> +	res[0].flags =3D IORESOURCE_MEM;
> > >> +	res[0].start =3D ddev->mmio_res.start;
> > >> +	res[0].end =3D ddev->mmio_res.end;
> > >> +
> > >> +	/* then add irq resource */
> > >> +	for (i =3D 0; i < ddev->num_irqs; i++) {
> > >> +		res[i + 1].flags =3D IORESOURCE_IRQ;
> > >> +		res[i + 1].start =3D ddev->irqs[i];
> > >> +		res[i + 1].end =3D ddev->irqs[i];
> > >> +	}
> > > How many interrupts UIO could support? or we need some
> > > warning or just even return error here?
>=20
> Yes, I can add some warning here.
>=20
> Thanks,
> Yilun

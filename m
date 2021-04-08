Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B9357EFA
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDHJUq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Apr 2021 05:20:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:17454 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhDHJUl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Apr 2021 05:20:41 -0400
IronPort-SDR: 4luu5Z+i4RjsimF8k9Mxd/y7BI3cZlwNnmntW3f+vg89Y/dL9I+s2ctMI8y2NYFJpIEtIF5NX3
 5QSmXJRLilrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193612452"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="193612452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 02:20:28 -0700
IronPort-SDR: VErc/DMerBojGNE3rqyTdO9LH1A5YuVqrEMY9tGoe5srnFIAniJ/18DWCm5o2iaKmF8D82VkaN
 MM2tTPn7fChg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="441683190"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2021 02:20:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 02:20:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 02:20:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 8 Apr 2021 02:20:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 8 Apr 2021 02:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWnnHM1Kh0kChu3SWoVoMsX3QNjtihPWiAHjamS9CTRNraJ2feoX/Z3gco/VogeF9ukEbuXyPKZGEHj4TlxEr6VVwK7Bo8eci9PSZyO+telo4hw9xq4SS8I2dLtFiQnTo+l4DFjLF8giDSHpueoCUqy5XOdg78fkTYLbmhXkMljo2Lw4+Zu3mpJ66xy3jRTcofuL1QJnOXBI3MI6jGSrFuzr1ut2/ezd8PO0zzPwqUCUCutnf01Db2KF3dZhgxQkOjlqx5ZHrZ8h+aHl8QCC+pLXprEkM965MjvwHWeTt/Ba+yFNHjEdByUT50rtla67VUAxii3czlfsOr8C+lcLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0716wRGAzAM6ac8D9tmQaATg9lzKDx2RsUY0WRXwms=;
 b=cnpJnmBN71QBvQTrbs2XunalvABmAIkrdkFA29ufRXArVXcIUHZwEMO7SZn651XCQURKQFpytHSrEFwJZh76cNuWjKvra5Kks6JgCvjqImuzVfrwQmDDJlWtjgQIuaup7psXtMcva2BOPOpqoOvOAZG935iSdiIHzxkksSuj3BsqzjjSjPekW5JF8Wm5jya2hZ0x4WStocn1U9cumsTt6sx1OaKinO6AWnxMo4f5XjZpjUJhnKUypQXNDbYLsfqMLgsUhliq1Y9UgvSlmPBQGXCctUZbSQcP3QRnGSuZD0wdiIIh01R8X2FMpolMekSoaBcMBcDjwIepOMuROh7uIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0716wRGAzAM6ac8D9tmQaATg9lzKDx2RsUY0WRXwms=;
 b=wOVY4jS28H01GpXlZ4XQ6A8XWpWGlwvgU22mNGgFy49Cnmdni7DDwjAFuNNXwMUZRmDOf+6jkkzIH26wpcM1SmDHola1N+eLPbR2aGI/XyA7zHRSOTW4OY6n2VLHsJRPci8t9uRg4V5i1V9YGa0CQQVcma2yAbj5QqbqEZkU7G0=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1690.namprd11.prod.outlook.com (2603:10b6:3:15::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 09:20:19 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 09:20:19 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>,
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
Thread-Index: AQHXKnapzaN+e8jiOUasbNG/fZUbfKqmp0KAgAEBK4CAAAt/AIAChFHwgAAQfwCAAAHe8A==
Date:   Thu, 8 Apr 2021 09:20:19 +0000
Message-ID: <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
In-Reply-To: <20210408081152.GA2713@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e269994-34fb-4b65-f7b3-08d8fa6f877e
x-ms-traffictypediagnostic: DM5PR11MB1690:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB169063B87B7BAB1D58ED78FB85749@DM5PR11MB1690.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T15xM6LDjHpPtBuyTA+VaMRw5x8W3czqP3F4J7QRbelQMqWX5orYBfHD5L+wAahYpuKx4nOTaeg5gskKd9gU8ohX9xoGJmTR2APsOZGnCJ9qHCOFTjr9oCLCydjyR/z5l9/cTBWTGua6FXMFzzQqldagSUtsbh9utGCczHzn4bjj0t8s58DGigP3tDXp5RuhQEfXbQ7oRBJTk1PumVTQqOEA2qm52RnHgXKavB6oatLN+R+zJXGh/5dbyQZdojoyp8eqSCUXP0XLUwqMlBcOqSlGR4DpOaOFOlcEvLIQ2lmpe54v3u9s4TquUrdvTKusJtO+rsEPaZunjSZxzmxJyhRPfIA+9GyXUJiyiWHwp+8NMWkTQ/3DQv0jzZDUvwjx7fnjDoYTfKaikXqq2SamKfrGhRD5iN4XEo5/d4PHWMdqKGyQElNowTBwNmaGz+ajBYAqq1/CncTS6FknrM4+i/eNTiZL50Ju8RTGpE+ZQBcYHd2kMPY+S2oi7pHMagkD8L9cSxGk6t0LloKPgkLFg0hAQK5ry7ShbR/qdGKy86Q6VBtyCuhXWNi5WWHwnVG5viWWh+/pgES/4iOuBWOyW/PeKBjVOydI67lhvbuxjEkUhQ9mUt7fR/m6gmB/AxgERdggNY5Gr3PkocAcSwJIzJAVC/YJJ50HnpWlcDEqtDE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(54906003)(33656002)(38100700001)(5660300002)(83380400001)(7416002)(76116006)(26005)(6506007)(2906002)(6862004)(186003)(71200400001)(52536014)(478600001)(6636002)(7696005)(8676002)(8936002)(66446008)(64756008)(66556008)(316002)(66946007)(30864003)(66476007)(86362001)(4326008)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p7dVlMln9PKi01aTdi+7n0e/QtCpn6Rao6zCIPogX8aZPt5sLIbtLHTbdIVw?=
 =?us-ascii?Q?HrK+FrMrbo/6aMoUxV46bpDXg6WMd9m1dgBPAQACXZNGgRmxXqHbugXyE6eZ?=
 =?us-ascii?Q?sjgtO6wD8r76jEkHdsbanCyrQdRIC9nrqzSGkaDuCeMNcKkVRw7C6PpZxyum?=
 =?us-ascii?Q?RUdaXrAUVTaC7PPdlZ+kOsY6eZM/7g9lz5Jma1OHfP1uWhGPgxRWoFCOlK1A?=
 =?us-ascii?Q?dVU58aFM7snScksgF6csnW3eIz3Mp7mLAkXEV/trNcqI9ssODmXfXT0K6FWr?=
 =?us-ascii?Q?iY1l3twch4sElPeCtM9AbPWVVjvAsahvvw0hVA0sDap5eVtPRKK15x5Ds1ho?=
 =?us-ascii?Q?kqG92fY5aj1D5NivxQTgFKjrQC85FVUBaPNMpWIaZm5dA/tenaE3ynFYAOic?=
 =?us-ascii?Q?pizisqZE5g8zXbmJv0p3Zl1HBe/qaHNeaCcNLFT30LqVIngFmqr71LWTnlBi?=
 =?us-ascii?Q?kDgQRGjB9gzaTPeqkuOGVQH4NQVAMoA2TktPRg5xpXZibF69rM9pOY0hL46n?=
 =?us-ascii?Q?pmnQeyuaqKCKh4chi9Q4N6MB4DYFsnN77DjOPgFXeoxFttJWt7RFSAQEQ/kb?=
 =?us-ascii?Q?iUqxS4p3FCAWnxjrd3slskguNFbUSYx+y2bPQJCs3+cvIzcxirTC/Q61F9RF?=
 =?us-ascii?Q?1jXnF3JW6X+fjpUdzla1VTdp7lvs33HrDra7qKUseFWfqt9CwuaJcCepOH8u?=
 =?us-ascii?Q?z0JD6qawvvhRgt17Kz3SOtI/dXAYD5gS4UKxDYrA+/azerrxPfc1nGZghdaY?=
 =?us-ascii?Q?nz2SY/yiF6CUOEP9VhQCuabwUUyFOmeXBll1stn5dL5opTIIkWd4D1DpCBIy?=
 =?us-ascii?Q?YJIHv9Hptq4CNNjSObbRUCDnVQNPkTPpCTiAZHNLCuoDeR/V0H8fMyyLp0A0?=
 =?us-ascii?Q?LX5NT8EY6zdE1TQhJYqxglhWTY4PWPwBu1F6UBFPOAivaGIe+/isEuPxlUxc?=
 =?us-ascii?Q?6re0bBpT4MFVOt57DrG+g87iLkEBpSFBqPsDG2ONsxCo0vSlzNCTR4knWfhk?=
 =?us-ascii?Q?2AqjlsQ1MT2zidJBImaVEFWOsblJxz0KRdtWQm478IdZVCYUmCtJbjLOL5rq?=
 =?us-ascii?Q?N7vMnrXtPurZ8yDT40jrLX1cyeQgSBIpj+ylAdheU4lPi3l5wXSUYDdhsz9O?=
 =?us-ascii?Q?xftsyQPlZgf//bIrpKOoB0kbr04eTmC9Ws/G9iNNAfQ694bq4761zhsxLeTM?=
 =?us-ascii?Q?RfggmrJ8jjNYOWjpCC9V/Oi8+hv0IZPyTiZ6m49SwefbbI7E2Ln2lCFA8XzA?=
 =?us-ascii?Q?cNrCj17U4gbHG9nIxOV22iAsIXJpRsWtUMrM+pUwPSFl/uqNWs0FWoVQLCtj?=
 =?us-ascii?Q?e9N2+YnTyVzREtZ16b8fczWd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e269994-34fb-4b65-f7b3-08d8fa6f877e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:20:19.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwyqXqnjYpiNTUcn55SxQQASllWNBT+3r/N7bVeXpdEIZJxznsnRhEM2dmN1Ds39xF45bW3DlCZAPG5Xss58Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1690
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Thu, Apr 08, 2021 at 03:30:15PM +0800, Wu, Hao wrote:
> > > > On Mon, 5 Apr 2021, Moritz Fischer wrote:
> > > >
> > > > > Hi Matthew,
> > > > >
> > > > > On Mon, Apr 05, 2021 at 04:53:00PM -0700,
> > > matthew.gerlach@linux.intel.com wrote:
> > > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > >
> > > > > > This patch adds DFL bus driver for the Altera SPI Master
> > > > > > controller.  The SPI master is connected to an Intel SPI Slave =
to
> > > > > > Avalon Master Bridge, inside an Intel MAX10 BMC Chip.
> > > > > >
> > > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com=
>
> > > > > > ---
> > > > > >  drivers/fpga/Kconfig          |   9 ++
> > > > > >  drivers/fpga/Makefile         |   1 +
> > > > > >  drivers/fpga/dfl-spi-altera.c | 221
> > > ++++++++++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 231 insertions(+)
> > > > > >  create mode 100644 drivers/fpga/dfl-spi-altera.c
> > > > > >
> > > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > > index d591dd9..0a86994 100644
> > > > > > --- a/drivers/fpga/Kconfig
> > > > > > +++ b/drivers/fpga/Kconfig
> > > > > > @@ -210,6 +210,15 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> > > > > >    the card. It also instantiates the SPI master (spi-altera) f=
or
> > > > > >    the card's BMC (Board Management Controller).
> > > > > >
> > > > > > +config FPGA_DFL_SPI_ALTERA
> > > > > > +tristate "FPGA DFL Altera SPI Master Driver"
> > > > > > +depends on FPGA_DFL
> > > > > > +select REGMAP
> > > > > > +help
> > > > > > +  This is a DFL bus driver for the Altera SPI master controlle=
r.
> > > > > > +  The SPI master is connected to a SPI slave to Avalon Master
> > > > > > +  bridge in a Intel MAX BMC.
> > > > > > +
> > > > > >  config FPGA_DFL_PCI
> > > > > >  tristate "FPGA DFL PCIe Device Driver"
> > > > > >  depends on PCI && FPGA_DFL
> > > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > > > index 18dc9885..58a42ad 100644
> > > > > > --- a/drivers/fpga/Makefile
> > > > > > +++ b/drivers/fpga/Makefile
> > > > > > @@ -45,6 +45,7 @@ dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-regi=
on.o dfl-
> > > afu-dma-region.o
> > > > > >  dfl-afu-objs +=3D dfl-afu-error.o
> > > > > >
> > > > > >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)+=3D dfl-n3000-
> > > nios.o
> > > > > > +obj-$(CONFIG_FPGA_DFL_SPI_ALTERA)+=3D dfl-spi-altera.o
> > > > > >
> > > > > >  # Drivers for FPGAs which implement DFL
> > > > > >  obj-$(CONFIG_FPGA_DFL_PCI)+=3D dfl-pci.o
> > > > > > diff --git a/drivers/fpga/dfl-spi-altera.c b/drivers/fpga/dfl-s=
pi-altera.c
> > > > > > new file mode 100644
> > > > > > index 0000000..9bec25fd
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/fpga/dfl-spi-altera.c
> > > > > > @@ -0,0 +1,221 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * DFL bus driver for Altera SPI Master
> > > > > > + *
> > > > > > + * Copyright (C) 2020 Intel Corporation, Inc.
> > > > > > + *
> > > > > > + * Authors:
> > > > > > + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/types.h>
> > > > > > +#include <linux/kernel.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/stddef.h>
> > > > > > +#include <linux/errno.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/io.h>
> > > > > > +#include <linux/bitfield.h>
> > > > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > > > > +#include <linux/regmap.h>
> > > > > > +#include <linux/spi/spi.h>
> > > > > > +#include <linux/spi/altera.h>
> > > > > > +#include <linux/dfl.h>
> > > > > > +
> > > > > > +struct dfl_altera_spi {
> > > > > > +void __iomem *base;
> > > > > > +struct regmap *regmap;
> > > > > > +struct device *dev;
> > > > > > +struct platform_device *altr_spi;
> > > > > > +};
> > > > > > +
> > > > > > +#define SPI_CORE_PARAMETER      0x8
> > > > > > +#define SHIFT_MODE              BIT_ULL(1)
> > > > > > +#define SHIFT_MODE_MSB          0
> > > > > > +#define SHIFT_MODE_LSB          1
> > > > > > +#define DATA_WIDTH              GENMASK_ULL(7, 2)
> > > > > > +#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
> > > > > > +#define CLK_POLARITY            BIT_ULL(14)
> > > > > > +#define CLK_PHASE               BIT_ULL(15)
> > > > > > +#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
> > > > > > +#define SPI_CLK                 GENMASK_ULL(31, 22)
> > > > > > +#define SPI_INDIRECT_ACC_OFST   0x10
> > > > > > +
> > > > > > +#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0)
> > > > > > +#define INDIRECT_WR             BIT_ULL(8)
> > > > > > +#define INDIRECT_RD             BIT_ULL(9)
> > > > > > +#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8)
> > > > > > +#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
> > > > > > +#define INDIRECT_DEBUG          BIT_ULL(32)
> > > > > > +#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x10)
> > > > > > +#define INDIRECT_TIMEOUT        10000
> > > > > > +
> > > > > > +static int indirect_bus_reg_read(void *context, unsigned int r=
eg,
> > > > > > + unsigned int *val)
> > > > > > +{
> > > > > > +struct dfl_altera_spi *aspi =3D context;
> > > > > > +void __iomem *base =3D aspi->base;
> > > > > > +int loops;
> > > > > > +u64 v;
> > > > > > +
> > > > > > +writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
> > > > > > +
> > > > > > +loops =3D 0;
> > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
> > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > +cpu_relax();
> > > > > > +
> > > > > > +if (loops >=3D INDIRECT_TIMEOUT) {
> > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > +return -ETIME;
> > > > > > +}
> > > > > > +
> > > > > > +v =3D readq(base + INDIRECT_RD_DATA);
> > > > > > +
> > > > > > +*val =3D v & INDIRECT_DATA_MASK;
> > > > > > +
> > > > > > +return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int indirect_bus_reg_write(void *context, unsigned int =
reg,
> > > > > > +  unsigned int val)
> > > > > > +{
> > > > > > +struct dfl_altera_spi *aspi =3D context;
> > > > > > +void __iomem *base =3D aspi->base;
> > > > > > +int loops;
> > > > > > +
> > > > > > +writeq(val, base + INDIRECT_WR_DATA);
> > > > > > +writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
> > > > > > +
> > > > > > +loops =3D 0;
> > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
> > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > +cpu_relax();
> > > > > > +
> > > > > > +if (loops >=3D INDIRECT_TIMEOUT) {
> > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > +return -ETIME;
> > > > > > +}
> > > > > > +return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct regmap_config indirect_regbus_cfg =3D {
> > > > > > +.reg_bits =3D 32,
> > > > > > +.reg_stride =3D 4,
> > > > > > +.val_bits =3D 32,
> > > > > > +.fast_io =3D true,
> > > > > > +
> > > > > > +.reg_write =3D indirect_bus_reg_write,
> > > > > > +.reg_read =3D indirect_bus_reg_read,
> > > > > > +};
> > > > > > +
> > > > > > +static struct spi_board_info m10_bmc_info =3D {
> > > > > > +.modalias =3D "m10-d5005",
> > > > > > +.max_speed_hz =3D 12500000,
> > > > > > +.bus_num =3D 0,
> > > > > > +.chip_select =3D 0,
> > > > > > +};
> > > > > > +
> > > > > > +static struct platform_device *create_cntrl(struct device *dev=
,
> > > > > > +    void __iomem *base,
> > > > > > +    struct spi_board_info *m10_info)
> > > > > > +{
> > > > > > +struct altera_spi_platform_data pdata;
> > > > > > +struct platform_device_info pdevinfo;
> > > > > > +u64 v;
> > > > > > +
> > > > > > +v =3D readq(base + SPI_CORE_PARAMETER);
> > > > > > +
> > > > > > +memset(&pdata, 0, sizeof(pdata));
> > > > > > +pdata.mode_bits =3D SPI_CS_HIGH;
> > > > > > +if (FIELD_GET(CLK_POLARITY, v))
> > > > > > +pdata.mode_bits |=3D SPI_CPOL;
> > > > > > +if (FIELD_GET(CLK_PHASE, v))
> > > > > > +pdata.mode_bits |=3D SPI_CPHA;
> > > > > > +
> > > > > > +pdata.num_chipselect =3D FIELD_GET(NUM_CHIPSELECT, v);
> > > > > > +pdata.bits_per_word_mask =3D
> > > > > > +SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> > > > > > +
> > > > > > +pdata.num_devices =3D 1;
> > > > > > +pdata.devices =3D m10_info;
> > > > > > +
> > > > > > +dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> > > > > > +pdata.num_chipselect, pdata.bits_per_word_mask,
> > > > > > +pdata.mode_bits);
> > > > > > +
> > > > > > +memset(&pdevinfo, 0, sizeof(pdevinfo));
> > > > > > +
> > > > > > +pdevinfo.name =3D "subdev_spi_altera";
> > > > > > +pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> > > > > > +pdevinfo.parent =3D dev;
> > > > > > +pdevinfo.data =3D &pdata;
> > > > > > +pdevinfo.size_data =3D sizeof(pdata);
> > > > > > +
> > > > > > +return platform_device_register_full(&pdevinfo);
> > > > >
> > > > > Should this be a SPI driver? I think looking at the UIO case we h=
ad
> > > > > decided against this pattern?
> > > >
> > > > This driver is similar in function to drivers/fpga/dfl-n3000-nios.c=
 which
> > > > uses this design pattern.  Is it okay to keep this design pattern f=
or
> > > > consistency?
> > > >
> > > >
> > > > >
> > > > > > +}
> > > > > > +static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> > > > > > +{
> > > > > > +struct device *dev =3D &dfl_dev->dev;
> > > > > > +struct dfl_altera_spi *aspi;
> > > > > > +
> > > > > > +aspi =3D devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
> > > > > > +
> > > > > > +if (!aspi)
> > > > > > +return -ENOMEM;
> > > > > > +
> > > > > > +dev_set_drvdata(dev, aspi);
> > > > > > +
> > > > > > +aspi->dev =3D dev;
> > > > > > +
> > > > > > +aspi->base =3D devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> > > > > > +
> > > > > > +if (IS_ERR(aspi->base)) {
> > > > > > +dev_err(dev, "%s get mem resource fail!\n", __func__);
> > > > > > +return PTR_ERR(aspi->base);
> > > > > > +}
> > > > > > +
> > > > > > +aspi->regmap =3D devm_regmap_init(dev, NULL, aspi,
> > > &indirect_regbus_cfg);
> > > > > > +if (IS_ERR(aspi->regmap))
> > > > > > +return PTR_ERR(aspi->regmap);
> > > > > > +
> > > > > > +aspi->altr_spi =3D create_cntrl(dev, aspi->base, &m10_bmc_info=
);
> > > > > > +
> > > > > > +if (IS_ERR(aspi->altr_spi)) {
> > > > > > +dev_err(dev, "%s failed to create spi platform driver\n",
> > > > > > +__func__);
> > > > > > +return PTR_ERR(aspi->base);
> > > > > > +}
> > > > > > +
> > > > > > +return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
> > > > > > +{
> > > > > > +struct dfl_altera_spi *aspi =3D dev_get_drvdata(&dfl_dev->dev)=
;
> > > > > > +
> > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > +}
> > > > > > +
> > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > +
> > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[] =3D {
> > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > +{ }
> > > > > > +};
> > > > >
> > > > > Maybe you can extend the Altera SPI driver with this part?
> > > >
> > > > The file, drivers/spi/spi-altera.c, already has platform MODULE_ re=
lated
> > > > code.  Wouldn't moving this code to that file produce conflicts?
> > >
> > > I've seen other drivers support multiple busses, so it should be
> > > possible, there might be nuances I'm missing in my brief look at this=
,
> > > though.
> > >
> > > I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > >
> > > See drivers/i2c/busses/i2c-designware-platdrv.c for an example (thoug=
h
> > > they might be guarding against what you describe with CONFIG_OF vs
> > > CONFIG_ACPI)
> > >
> > > If that doesn't work we could split it up into
> > >
> > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > or something of that sort?
> > >
> > > My point being, now that we have a bus, let's use it and develop driv=
ers
> > > according to the Linux device model where possible :)
> >
> > Agree. This does make sense from my side too. DFL core provides the
> mechanism
> > to enumerate different IPs on FPGA, but each function driver needs to g=
o to
> > related subsystem for review.  : )
> >
> > I understand that for FPGA case, it may have some additional logics for=
 specific
> > purposes based on common altera spi master IP, then additional code for
>=20
> I'm wondering if the additional logics are extensions for common spi-alte=
ra. Like
> the
> SPI_CORE_PARAMETER register, it is not within the register space of
> spi-altera,
>=20
>=20
>   |   |      +-------------+
>   |DFL|------| +--------+  |
>   |BUS|      | |SPI CORE|  |
>   |   |      | |PARAM   |  |
>   |   |      | +--------+  |
>   |   |      |             |
>   |   |      | +--------+  |   +-------+
>              | |Indirect|  |   |spi    |
>              | |access  +--+---|altera |
>              | |master  |  |   +-------+
>              | +--------+  |
>              +-------------+
> > a specific product still can be put into altera-spi-xxxx.c or altera-sp=
i-dfl-xxxx.c
>=20
> So is it proper we integrate this feature into spi-altera? Previously
> we have merged the dfl-n3000-nios, its spi part is very similar as
> this driver. The dfl-n3000-nios make the spi-altera as a sub device.
> Could we borrow the idea, or could we just integrate this driver in
> dfl-n3000-nios?

Looks like those are enhancements of the IP. They can be applied even
other buses are used, not only for DFL, like PCI device or platform device,
right? then why not put related code together with the original IP?

The reason I suggested that function drivers which use DFL bus, still need
to go to related subsystem, because we know DFL quite well but may
not be the experts for every subsystem (e.g. SPI), and every IPs (e.g.=20
Altera SPI Master). Altera SPI Master driver maintainer could give more
valuable suggestions on your question if this feature can be integrated
into spi-altera or not. : )

Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > Thanks
> > Hao
> >
> > >
> > > Cheers,
> > > Moritz

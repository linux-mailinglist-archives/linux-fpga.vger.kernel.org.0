Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BE1C38A8
	for <lists+linux-fpga@lfdr.de>; Mon,  4 May 2020 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEDLz2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 May 2020 07:55:28 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:22592
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbgEDLz1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 May 2020 07:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch3Oo2klE1LVxcbvaqpnk7DrnZyaxsiMNLii32d3XKR8O3r86Gnkbof0jvLhh2U1oMk13K5aNMlwhxJyLEgG+SlvtELK6kgWc2qAKsj22/lOxSBbRkyVjJoLAFuZlRLOXZqqPYL5nutTiYSFZzoJZbT+FAN1UwzIevIqwDnCdbqsipD64SBMedlWn8+joVuCL61WKpkr0mSpdPutnkwQ6OYONfwWuiRbyEsRbYmDb6Ps/3YSbFSxH+a9jBSNJaZGjTeiynhboF4bJnaXK1uZV/X3Jo59ipsJ15E6zoyfKa41VRwJ50HkxnuRK4zOYCWhzYN5Tyq7awFGZ03dsSJjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPyz/NmNrQ/i871oBzMYzTzXCR5jMUR8h+gOdrhEUcY=;
 b=nwSGBlXCrCwozln04p3AEdHn0iO4GEqJwMUdDycCoLqxqWRqkWP9zo7nTpBWwYwxpD1bidz2FCzSlChHYTPvHpYqi+9FL4TwpaNGNpdPLsLuUT2TP/GL4Hrdp3J23lM9jVyfWkFBne1aus8lcazLuJAKg0pBcPHLTnf/i/vrKB2YW4+kJKYDaw9R2cm+iMfas9RaOHcfmUD5evbugFG9da5zaPxHKxuF9Xds4hkbgn/r6IYz6FJk1grqe1of8QEWvL3G8d1jmzZQk0H7wJhEtNeFRZPbrBbNsTUrOlwAjKgniD7vJclnzUyS655gngORvIBj4PXpeB67+ED3vLv/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPyz/NmNrQ/i871oBzMYzTzXCR5jMUR8h+gOdrhEUcY=;
 b=oNKiQeOe44SlC8iQi+PqrE8lsl33hHiZSEWndKW1/6K5vgX+T2QUdXI09MTWbRbEc/7/oLbUiRjoUKOxDmDb1+qhAZeKpLapGGqRmVAC6tjRIMMxkavF+NjiSgXTZr/IibGmE/ArcpHKQJJKUJFiSLXjs6gL1Dx8WuRWgwFidqE=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 DM6PR02MB6124.namprd02.prod.outlook.com (2603:10b6:5:1fb::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Mon, 4 May 2020 11:55:24 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::2cd7:4680:9cd4:f51b]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::2cd7:4680:9cd4:f51b%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 11:55:24 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 2/2] fpga: zynq: Add AFI config driver
Thread-Topic: [PATCH 2/2] fpga: zynq: Add AFI config driver
Thread-Index: AQHWExAhzZUocH0/3EuatlmWIllh3KiGGIAAgBHUQYA=
Date:   Mon, 4 May 2020 11:55:23 +0000
Message-ID: <DM6PR02MB5386D0632A60A9C056DB31E6C2A60@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
 <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
 <20200423032854.GB2430@epycbox.lan>
In-Reply-To: <20200423032854.GB2430@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0f4afc2-5634-4446-3064-08d7f022076d
x-ms-traffictypediagnostic: DM6PR02MB6124:|DM6PR02MB6124:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB6124DDEE5717F6BF924E0E23C2A60@DM6PR02MB6124.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JDiXkM3QMonhhdpFgVP06xWP8KofBI7jSWVHsyY5LrMcgUFNE8EwtUSGdGQRmPu5HfyLtbMxboE0HQo/FCv8qZHYc8Rvbi3AbVx8RmN31LXuTNh30ToDfn7XjqOD6fDrzqmH/IIHqIlnolIfkJRGkwn10e3AfKSD1ZVVYA+DOfIgeEQ1Os45MAkQ7NMdH7u53MTTWQn/VVBApcRrGnF8gMmOGeW5MGNmp74OAQpVZY1Fr+/SVyXG6KtuhjunStqi42MUBUUvF4n4smhztjvyA+9odMg18Y3VHDkhyJAhMc7pvAtUUU/j6FIvsZGvG2IpbFj4q9ouFTBHcGg7BcvfqG83GnUYxFBoV/Kxp+A8WeYOyBcZOIk3jk6g9pyPuonofrN5haaCveGBz6iyXaDWOj3jOwmKrGg3k7tcv5c2mzV8kvJ5zy7UrTffaVenMvl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(186003)(33656002)(5660300002)(76116006)(53546011)(6506007)(66476007)(54906003)(7696005)(71200400001)(66946007)(26005)(66556008)(64756008)(66446008)(6916009)(86362001)(4326008)(9686003)(478600001)(8936002)(55016002)(8676002)(2906002)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CZklHfAIogbZTMzhBAwfzoqbmOEdHb0Rr5QkRXZbaLu6ru/ZQXA7uQUQmF+G+5+COd7BKqB9O+9GNYUsepCkClXlCFP/KfVpyMQs3dvLNRCx6o/stIEx3LmjzNt3wlXLwmSlLijDQAmDp/sDBmxlp/jdFv88i2zkRZwnkAp1wQXTko8r9pIU5wc9KxHZAqqBt3HGSHvw9OdNAQDgTh+NTIi/4St9bWHV/lxXpkt7r9h2yhkA5LL4nk8jjIYGgXXD4DGC6VLDgizTZp+1qG2xS1ggB8ybLt+CGuE5RXFHKpOU5esXoYN1/vOz9kPJvNHlEZsPDuBrHOI+98PZlCpPAyWOyRvxvv4yC9gRJlN8CrIHyuulhA8EyWqwbYCHhl8CvHdgsNcI/3Y5zkVRZZM9cNnN7J4Iimvure3753xhkmewfEc32jl4jJPPkHNgr+w7vhIczJZCqRcmHdcTJN8NAxjbvIafhlcg1VnROwIs5suM+EK743essU92s1+bl8z5wpKA1V2bdlz5SAtOgu98x6GcTSMtAN/P/e3nA0YhMQLzwNvh9dlDJijLXUsZbTIuJLu0c9DUIrnMCZyQcxAwrtU1HsLUxmZkOUQAdIjEH1SDlTbXK4Onazk4kvcdRSlTXzDuCAyRN9bCrUA/3RPDJ62XV4FfHh/RFXYw9PmwBx5MQA98wMiZq1aAslGWvDH32TtP7AHG8iQ5xx+Nda43MNH4apB4qM5th0MxeeHTGV1goAuLnNBvSm5L1iJmFkYwmseJXKxdM0icJIjyo/IxfasBhnjXz/E7Yv8OCCtr2Kw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f4afc2-5634-4446-3064-08d7f022076d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 11:55:23.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPJ0N7iD6XgGiDLPYOCDvf3JboEu+lIZklAYYA11OwXpECIq3DlFHiSFcDjxJ7a88L3vWzsdPMBMxgogtYXGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6124
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Mortiz,

Thanks for proving the comments.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer [mailto:mdf@kernel.org]
> Sent: Thursday, April 23, 2020 8:59 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; chinnikishore369@gmail.com
> Subject: Re: [PATCH 2/2] fpga: zynq: Add AFI config driver
>=20
> Hi Nava,
>=20
> On Wed, Apr 15, 2020 at 03:54:50PM +0530, Nava kishore Manne wrote:
> > This patch Adds AFI config driver. This is useful for the PS to PL
> > configuration for the fpga manager On zynq platform.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/Kconfig    |  8 +++++
> >  drivers/fpga/Makefile   |  1 +
> >  drivers/fpga/zynq-afi.c | 81
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 90 insertions(+)
> >  create mode 100644 drivers/fpga/zynq-afi.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 474f304e..60982a0 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> >  	  to configure the programmable logic(PL) through PS
> >  	  on ZynqMP SoC.
> >
> > +config FPGA_MGR_ZYNQ_AFI_FPGA
> > +	bool "Xilinx AFI FPGA"
> > +	depends on FPGA_MGR_ZYNQ_FPGA
> Curious. How does this dependency play in here?
> > +	help
> > +	  Zynq AFI driver support for writing to the AFI registers
> > +	  for configuring the PS_PL interface. For some of the bitstream
> > +	  or designs to work the PS to PL interfaces need to be configured
> > +	  like the data bus-width etc.
> >  endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > 312b937..d115e29 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+=3D fpga-
> bridge.o
> >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+=3D altera-hps2fpga.o altera-
> fpga2sdram.o
> >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+=3D altera-freeze-bridge.o
> >  obj-$(CONFIG_XILINX_PR_DECOUPLER)	+=3D xilinx-pr-decoupler.o
> > +obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+=3D zynq-afi.o
> >
> >  # High Level Interfaces
> >  obj-$(CONFIG_FPGA_REGION)		+=3D fpga-region.o
> > diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c new
> > file mode 100644 index 0000000..7ce0d08
> > --- /dev/null
> > +++ b/drivers/fpga/zynq-afi.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx FPGA AFI driver.
> > + * Copyright (c) 2018 Xilinx Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* Registers and special values for doing register-based operations */
> > +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> > +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> > +
> > +#define AFI_BUSWIDTH_MASK	0x01
> > +
> > +/**
> > + * struct afi_fpga - AFI register description
> > + * @membase:	pointer to register struct
> > + * @afi_width:	AFI bus width to be written
> > + */
> > +struct zynq_afi_fpga {
> > +	void __iomem	*membase;
> > +	u32		afi_width;
> > +};
> > +
> > +static int zynq_afi_fpga_probe(struct platform_device *pdev) {
> > +	struct zynq_afi_fpga *afi_fpga;
> > +	struct resource *res;
> > +	u32 reg_val;
> > +	u32 val;
> > +
> > +	afi_fpga =3D devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
> > +	if (!afi_fpga)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	afi_fpga->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(afi_fpga->membase))
> > +		return PTR_ERR(afi_fpga->membase);
> > +
> > +	val =3D device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> > +				       &afi_fpga->afi_width);
> > +	if (val) {
> > +		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	reg_val =3D readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > +	writel(reg_val | afi_fpga->afi_width,
> > +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > +	reg_val =3D readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > +	writel(reg_val | afi_fpga->afi_width,
> > +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id zynq_afi_fpga_ids[] =3D {
> > +	{ .compatible =3D "xlnx,zynq-afi-fpga" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
> > +
> > +static struct platform_driver zynq_afi_fpga_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "zynq-afi-fpga",
> > +		.of_match_table =3D zynq_afi_fpga_ids,
> > +	},
> > +	.probe =3D zynq_afi_fpga_probe,
> > +};
> > +module_platform_driver(zynq_afi_fpga_driver);
> > +
> > +MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
> MODULE_AUTHOR("Nava
> > +kishore Manne <nava.manne@xilinx.com>"); MODULE_LICENSE("GPL v2");
> > --
> > 2.7.4
> >
>=20
> It looks like all the driver does is writing two registers? How does
> that fit into FPGA Manager as a framework. Should this maybe be eithe
> for Zynq architecture or a Misc driver instead?
>=20
To establish the proper communication channel between PS and PL, The AXI In=
terface Bus Width should be configured properly.
For a design to design this AXI Interface Bus Width settings are vary. So f=
or Zynq just loading the Bitstream into the PL is not sufficient
to establish a proper communication channel between PS and PL we have to do=
 AXI Interface Bus Width settings as per the design
after loading the Bit file into the PL. I feel this is more relevant to the=
 FPGA settings so I have placed this driver here.

Please suggest the best place to put this driver.

> Is the idea here to create the device via an overlay?
Yes, this driver loading/removal is triggered by the overlay after loading =
the bit file into the PL.

Regards,
Navakishore.

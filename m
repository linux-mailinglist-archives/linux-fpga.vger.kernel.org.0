Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909FD1C38B8
	for <lists+linux-fpga@lfdr.de>; Mon,  4 May 2020 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgEDL6s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 May 2020 07:58:48 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:6042
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728628AbgEDL6s (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 May 2020 07:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8gjV/5mGL36riMudRcEO6h+9EfVFWEcinLakyjRLzz34bk4ExaEpxNMA2i0NWC7tuGZfQ6ttxJcggBENRP4YPlamalg8vcpHpPIRTITRCnPKZUs/j33au8YcSV5wSxLIFxFIW19XdutWjQt68I7+C6StC6OPbt6sKwcnIRar3HTAqgHA9OoDyQSbiX9ak0TkR2/2ETEc4pWTg2S8OzPu7QPt1EBYHr+ngZGBGH3fE9VvGIXwmbDNRYa0nHxrZw957vhgWP0M9AjRlLFPaNZyo0UD9xana+N4MwV6scL8FZoP/7tWTjah9zNCaL6lCGG+M/9iwqDHZf031/z4qwPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZE9REMMtVRGQopnD/5bQrknlr1lc6GGeMuLtw+hXRs=;
 b=bsM+Xtjo0s7X4pGQ9j4vPQHacHROg3RHVjfrHpSwYQjYZ7qyfiCJx6c8Kge4TjgIS5eDjd/8/ihf3/rdixFpRnS9KqusNiIZrMvWBR+sCj1+KJmqfkYZ7KyA3dwEtf3l6cDV4ruU9qMFbfMC9QPdhf9Nogwd48hB/t282EIC/XXiMk93wdJ6ugYEPgMisFn8JTP1j4Spk6lnGmMaLnoevaTS1Ushr8GMz0wbgqJwZKUyZtwYc4Fci6URLM7aFP7h/1iZ2Eg1Fs+zk4XOfXNJ0BuCzq0VKRoQRtdvklynFGFFr2M9jM6K+RoKbKgbKNV6KuSpvG3VLkTkAlVFc8WRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZE9REMMtVRGQopnD/5bQrknlr1lc6GGeMuLtw+hXRs=;
 b=hw1eKTx5EN+IdOZ6QAxNPO0ABWPFuE7t0AzZark3JacDZ/IFjgqOJ34i4hR7J4uagek/Rxz9Vampl0Z6DUq4Oucr6XZ/u0iJqn8egKSm0kKxOO2e2k2UoZhS58HhVqCY4xsOXjWbp+2HffPbqhnY8RSLzIJzt0lZCWyl7R9fNZc=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 DM6PR02MB4154.namprd02.prod.outlook.com (2603:10b6:5:a3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.21; Mon, 4 May 2020 11:58:42 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::2cd7:4680:9cd4:f51b]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::2cd7:4680:9cd4:f51b%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 11:58:42 +0000
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
Thread-Index: AQHWExAhzZUocH0/3EuatlmWIllh3KiGGIAAgBHUQYCAAAORYA==
Date:   Mon, 4 May 2020 11:58:41 +0000
Message-ID: <DM6PR02MB5386B2BC995622312F8D241DC2A60@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
 <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
 <20200423032854.GB2430@epycbox.lan> 
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
x-ms-office365-filtering-correlation-id: df0e3366-e182-48f0-2dbb-08d7f0227d92
x-ms-traffictypediagnostic: DM6PR02MB4154:|DM6PR02MB4154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB41546EB8540383008F1270BDC2A60@DM6PR02MB4154.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z96ZMmwqXck16HUVBf6tgV+SUnjTFKf2So9bUW6dlpwllNtaqlIjIsPqYwfYjnywe4N85B2o+SB1ywi6MBRh110W4rXLUPO8LliKWcgVJmMd+IRYxrFOWhev58a0LBUzQGzndBCCu/zO47EFSngGRy7OM+DqjF5kXAD8vfhZlL6kv3CSheN9DwIYWuaUgZD1LKi+hcA444IOAmHNU7dA5vbu+nYfJf5slgJN+5A7KKnH590+GVQgIKl6HMAxrRjK8KorQ5i7sbkzLNuFSR0SDPp2tyI+rQ4OE9uR/v3vFz0wyu1C+LAgixdX/sTRwIvo7ocNzqP6m9aldl3r5cUJJ7wnKAP9isuhrvupQWVt/LLtiDVRLhv69EIPd3bnOJT80TjKBzyNukLkMLMJJLgWg1xnRBAumCVx5WjgOBDRkR7NDmHEMZaB93bRjvXWbN32
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(5660300002)(316002)(8936002)(64756008)(66476007)(66446008)(66556008)(54906003)(2906002)(8676002)(76116006)(66946007)(53546011)(6506007)(9686003)(186003)(26005)(7696005)(71200400001)(86362001)(52536014)(478600001)(6916009)(33656002)(55016002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3gMknyFxnVMkhLvzLFzLe/IggQaKQwACrdyxb7IiUboIaMU12HB6oHPsgsoyL9emY3mG0/Cieow0Ir1/Rh4WjMgn/FjSKw5zlL0H3B5JqeD6ngLfgiOU0Efi3U9BEZzp8/ZSTh6KRGuMWCZX61af18R5KsR8tYJ2NfS7vsx8/eSchqvpWR4BbANLv+dbL/f2J2zQQhib6yACL0dGo55F3y2agqY9gqCbQm7Q2HS9lbH1to7ASRgzVqVzSTv+d602Ir97dIzoGR7nqKDOfmpxe3gUI2r25WhbUDWGU+vqfpjrPL7drjNnFjtPZQZjbJbbDZ6RaWMgt1Uvrcq8xDZJ0Yt6J3jUuuH/lhZqBDaTv5dP1CRwAbVccwSztjT9v/2EYROXxhcM6kUmW8z4e+bEnSr95a2ao2qFzkoDSCBL95mrfMxGipbY7yF6Mead1mB1dPPpz+C/hSHufXpNZQ9yJHUN3Qi+8zW1fs3SjzLkNH2dxs37UShGjno+y0bJa6KcMy+h16jwuaA4703JbJ5qOzQJQy5gWDhdQSJ8AwhtzjZKc7InYwql9Qm4i96eB+jj7s6WtbLBlwZ0Mw0FzvV8CkgGs2UPlhBr9yumAP7dIDvzy7y16a18GyEnFLpqOrScRnseqDhak4gITwLYYJWqMw6Z3NQMo8o6xLfP+2e9n55o0ek2rHykuzG8vUT1pFuO/5+AqlHmrN3RSL0uJuNmNybHCBRc1oHLzBFV0TTmmWcH6Sj5Crd9e2+ilE25TSDe5gG5+7hcKMpXbufFTpuw975JUr2ynlPZLbN/jpowmaY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e3366-e182-48f0-2dbb-08d7f0227d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 11:58:41.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1YisssLTe8RhveCqQqjQcAAa68pj5Qtka1zJyisfpTHHaAczd4cC94o2tQOrf1+QZeZTymSKijjXPZJG4D7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4154
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Corrected typo

> -----Original Message-----
> From: Nava kishore Manne
> Sent: Monday, May 4, 2020 5:25 PM
> To: 'Moritz Fischer' <mdf@kernel.org>
> Cc: Michal Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-=
arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com
> Subject: RE: [PATCH 2/2] fpga: zynq: Add AFI config driver
>=20
> Hi Moritz,
>=20
> Thanks for proving the comments.
> Please find my response inline.
>=20
> > -----Original Message-----
> > From: Moritz Fischer [mailto:mdf@kernel.org]
> > Sent: Thursday, April 23, 2020 8:59 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > fpga@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; chinnikishore369@gmail.com
> > Subject: Re: [PATCH 2/2] fpga: zynq: Add AFI config driver
> >
> > Hi Nava,
> >
> > On Wed, Apr 15, 2020 at 03:54:50PM +0530, Nava kishore Manne wrote:
> > > This patch Adds AFI config driver. This is useful for the PS to PL
> > > configuration for the fpga manager On zynq platform.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/Kconfig    |  8 +++++
> > >  drivers/fpga/Makefile   |  1 +
> > >  drivers/fpga/zynq-afi.c | 81
> > > +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 90 insertions(+)
> > >  create mode 100644 drivers/fpga/zynq-afi.c
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > 474f304e..60982a0 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> > >  	  to configure the programmable logic(PL) through PS
> > >  	  on ZynqMP SoC.
> > >
> > > +config FPGA_MGR_ZYNQ_AFI_FPGA
> > > +	bool "Xilinx AFI FPGA"
> > > +	depends on FPGA_MGR_ZYNQ_FPGA
> > Curious. How does this dependency play in here?
> > > +	help
> > > +	  Zynq AFI driver support for writing to the AFI registers
> > > +	  for configuring the PS_PL interface. For some of the bitstream
> > > +	  or designs to work the PS to PL interfaces need to be configured
> > > +	  like the data bus-width etc.
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > 312b937..d115e29 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+=3D fpga-
> > bridge.o
> > >  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+=3D altera-hps2fpga.o altera-
> > fpga2sdram.o
> > >  obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+=3D altera-freeze-bridge.o
> > >  obj-$(CONFIG_XILINX_PR_DECOUPLER)	+=3D xilinx-pr-decoupler.o
> > > +obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+=3D zynq-afi.o
> > >
> > >  # High Level Interfaces
> > >  obj-$(CONFIG_FPGA_REGION)		+=3D fpga-region.o
> > > diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c new
> > > file mode 100644 index 0000000..7ce0d08
> > > --- /dev/null
> > > +++ b/drivers/fpga/zynq-afi.c
> > > @@ -0,0 +1,81 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Xilinx FPGA AFI driver.
> > > + * Copyright (c) 2018 Xilinx Inc.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +/* Registers and special values for doing register-based operations =
*/
> > > +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> > > +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> > > +
> > > +#define AFI_BUSWIDTH_MASK	0x01
> > > +
> > > +/**
> > > + * struct afi_fpga - AFI register description
> > > + * @membase:	pointer to register struct
> > > + * @afi_width:	AFI bus width to be written
> > > + */
> > > +struct zynq_afi_fpga {
> > > +	void __iomem	*membase;
> > > +	u32		afi_width;
> > > +};
> > > +
> > > +static int zynq_afi_fpga_probe(struct platform_device *pdev) {
> > > +	struct zynq_afi_fpga *afi_fpga;
> > > +	struct resource *res;
> > > +	u32 reg_val;
> > > +	u32 val;
> > > +
> > > +	afi_fpga =3D devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL=
);
> > > +	if (!afi_fpga)
> > > +		return -ENOMEM;
> > > +
> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	afi_fpga->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(afi_fpga->membase))
> > > +		return PTR_ERR(afi_fpga->membase);
> > > +
> > > +	val =3D device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> > > +				       &afi_fpga->afi_width);
> > > +	if (val) {
> > > +		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	reg_val =3D readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > > +	writel(reg_val | afi_fpga->afi_width,
> > > +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > +	reg_val =3D readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > > +	writel(reg_val | afi_fpga->afi_width,
> > > +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id zynq_afi_fpga_ids[] =3D {
> > > +	{ .compatible =3D "xlnx,zynq-afi-fpga" },
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
> > > +
> > > +static struct platform_driver zynq_afi_fpga_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "zynq-afi-fpga",
> > > +		.of_match_table =3D zynq_afi_fpga_ids,
> > > +	},
> > > +	.probe =3D zynq_afi_fpga_probe,
> > > +};
> > > +module_platform_driver(zynq_afi_fpga_driver);
> > > +
> > > +MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
> > MODULE_AUTHOR("Nava
> > > +kishore Manne <nava.manne@xilinx.com>"); MODULE_LICENSE("GPL v2");
> > > --
> > > 2.7.4
> > >
> >
> > It looks like all the driver does is writing two registers? How does
> > that fit into FPGA Manager as a framework. Should this maybe be eithe
> > for Zynq architecture or a Misc driver instead?
> >
> To establish the proper communication channel between PS and PL, The AXI
> Interface Bus Width should be configured properly.
> For a design to design this AXI Interface Bus Width settings are vary. So=
 for Zynq
> just loading the Bitstream into the PL is not sufficient to establish a p=
roper
> communication channel between PS and PL we have to do AXI Interface Bus
> Width settings as per the design after loading the Bit file into the PL. =
I feel this is
> more relevant to the FPGA settings so I have placed this driver here.
>=20
> Please suggest the best place to put this driver.
>=20
> > Is the idea here to create the device via an overlay?
> Yes, this driver loading/removal is triggered by the overlay after loadin=
g the bit
> file into the PL.
>=20
> Regards,
> Navakishore.

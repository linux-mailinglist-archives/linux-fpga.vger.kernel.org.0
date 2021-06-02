Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F743986EB
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Jun 2021 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhFBKvN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Jun 2021 06:51:13 -0400
Received: from mail-bn8nam08on2053.outbound.protection.outlook.com ([40.107.100.53]:63392
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231490AbhFBKu2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Jun 2021 06:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKvn++h5BHmRWjjUnlp84Nly5HMeeuLacWm7tz85swHWF7PRS4fzxFoNtZNPgBuDDPfA99zj31QbH0B6kkX9fg+9veFswbPmyfYxKyKNs1kAVoxvptjcoAuJAyN+HXARdIcIllBTDpfr/luyeMuCPnoYEzdWMdXD3OMSuK9AiuMIPybcJ+oSzoto6DhufV5ySUlzTch/srWzVn8t9rHjlAtQV5YHHjzQE3lx6BhTrWcZmilrI0mRCI8yvXWUwyZ1OJIcFd3k9N7Y6RmUHYc+7VO/RTyGaXd0xmVSbhN7nAGA79Y9RFQrfn7q7Eg11wV+yvWYRYyoAzENjxMiIt/d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzHZ4x0u+W7afZJ8k66h2a1K0GPRBhF/rMqDAUJ0Z2k=;
 b=Te/PZibYofbJZbsb5a2BcO6FaFjkKkeTvQuxZPQxg7JBWR0AnCnIp1XmnnGh+lu6+N+X2osXAyzgIFDzdJPJ1xIlWbT6AOP+zhwXTWkC+LPl6Y1AUxXfzG0NC3EG/fh+K0REE5FDNOBJ+VKQkb1druUlNfRQaq6c7JT0oJQfGgE//8WR9Ujcagw9OcqZEjNmq8R9ui5aRwMPMCNAANpugFVzGWAtGs+TS5kU3nNUapJQt760EB36PS1doT4IVHmOm/KGOI9gdznAhQ/iIfNXGT/wLJD1MhnfvN6XfwVM38h47QTKQzV0gu2gvwx8vJM9P1pNm1W2FyM8DFEGgpx5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzHZ4x0u+W7afZJ8k66h2a1K0GPRBhF/rMqDAUJ0Z2k=;
 b=Tvgu8S2zJ6adsO7b6UaP3y/XymjWDFVxOkHOHyRmqAIKaEPieIGyABm/DWyMS2nlmIpmWCznpr3NDo/My5myuvGombXGjgAYu1HI0R929YU4mu1HU40Vkv0DUM7XQ0sktUKth2j3P1GXNV/bK5e0vdlorMzAmRrMIOUN4qoztLw=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7239.namprd02.prod.outlook.com (2603:10b6:510:1d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.26; Wed, 2 Jun 2021 10:48:42 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 10:48:42 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH 3/3] fpga: region: Adds runtime PM support
Thread-Topic: [PATCH 3/3] fpga: region: Adds runtime PM support
Thread-Index: AQHXJ6KdTpEiWN/+bESGWLEVPH0Elqqsv+2AgA6mmuCARYO/AA==
Date:   Wed, 2 Jun 2021 10:48:42 +0000
Message-ID: <PH0PR02MB733699A67717E605045728DAC23D9@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-4-nava.manne@xilinx.com> <YHDHhf1tQo6vI49W@epycbox.lan>
 <MWHPR02MB2623E61ABFBB478E95DC863FC2499@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623E61ABFBB478E95DC863FC2499@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018dd33d-1684-4940-f52a-08d925b3fcf7
x-ms-traffictypediagnostic: PH0PR02MB7239:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB72392FF6F8DE919484D58026C23D9@PH0PR02MB7239.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bxq1jI5ufpJiN5AADaIeEgXIfX/Pov/GXbkpBOe2x5PCIMdlCnq9iy8MN7Uw+sYpNd3zUVrJb8cYplBvRRBbFUcSqRq+y4Fnq/AU/HhVD5oiaHkfKF5v88shDvtyXxoWP4ZIDrNHArzOG2YUfA+BuWVU4qWfIckuy0HQcUkJnfic37tID1K5Vo8TR3Y+TQG7HsuiMdBxDCUVcspnvEz0IH1yMCMyndVm2vJb/hKXlXT3lCt8vL8fkSrfbYBvueS0AAnvIMbGK9Hcb51JhLB8UclxVsRFjLv6owE9fmbLCoquMjs+n57Yikm/WdbOMFokR9NL3LnOVt0s6/pfA2ZqlJqJqX1bo9KhidiW88DMMndIO9RrkjmEqIidNROrITrXqCNZ6507Xw36iMNyWT/L2gOyN4E5JaoHCGRDGwm8LKvcWenOOCuXP2ePlNqGglAlxE30yDHtUjKioVjEZbR1oa6r2QszeHetBrHV3BFsJOjWUcDRBv7Xoh5fNRFZT+L7Nx6oEgTFd9iQ+ncceI3xJJwr2UwR/0aR2Fno571ado7pYOk8kuajeNgD56dXasOPIW6ipWSxDPj1ND0banx/1V5ap+MAPR/xdG/U67jH8qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39850400004)(136003)(107886003)(6916009)(33656002)(478600001)(7696005)(4326008)(186003)(55016002)(2906002)(8676002)(5660300002)(9686003)(54906003)(53546011)(6506007)(76116006)(38100700002)(122000001)(71200400001)(64756008)(66946007)(83380400001)(26005)(66446008)(8936002)(316002)(52536014)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8tJRvbKQMui90NHMAtFU/+HvWxJuj99L81aRYsHDx159BcIyI7tivnvgKgU?=
 =?us-ascii?Q?jsQ0x7RBTagSLmK3YvX2Pv+opu67xmcUzMxS3DGnkECLBv5sWFXklzxTBJRz?=
 =?us-ascii?Q?34O8jqOF27NVWKn3Pq1znQezqnTBPwiciAmlHCEORFz8QzmulgdaemY1EV4t?=
 =?us-ascii?Q?DhXzBihj31Xc8ROtiRpXzczuoSLO2HFAC5X1fdtXZJ5pdwaJJUvbJQliNB3c?=
 =?us-ascii?Q?3H5OBmN2THXc22YUh9swGUUBFY8zLEeGc+B994gx+m9zCuswHJ1NenVJSwl0?=
 =?us-ascii?Q?L9x0cXX/FyHCChktVQylyzZ7aXCYJa4tm27R17WbEmgbHiLjynwALxMgoun6?=
 =?us-ascii?Q?8GYlj1uyO3zTCaV1dsYv/J/6GzKjLOFSPumZE+EWKp8rpth+0Q3VrofJeox2?=
 =?us-ascii?Q?QVU4Oy2xkklNK6TEeps0f076qMi5dwVBmpsi7m6NQ+NvxqC+4GnW5qbgIDTZ?=
 =?us-ascii?Q?og1mbAwZH4pYSc10qo/DZBwe5Vm/tiFb+HqLS+5BlaGOKq90bgCRrgByi9vR?=
 =?us-ascii?Q?nnYYZ4RQKynIy0wcHDknjDXYlz6bDS0Z+2p+nQ7z67P5Iwm+Up+EC4w5k9JR?=
 =?us-ascii?Q?6rJORpqWzvKxc0lf1hvnRVXtzwlZ0DxsPEiWmGJVcP+89d9mYFLqs7c09GuY?=
 =?us-ascii?Q?sEqvPR2Tq5xhmCfBXGu+MCVu0g22EwPcs0i8BPbXYz8UFtYAz23uqh6s2p3K?=
 =?us-ascii?Q?hhrKaZ0XWuzU3u6R8IZkB28ZAqyZXMfeSekWptwBUEY+gIXswx9oty8EoCdP?=
 =?us-ascii?Q?mY0Cx2ev39SE3w4t6e7fJHsCCerW5+SpIDIcbcdP/Tuf4OD8uRJzA7u4R+/H?=
 =?us-ascii?Q?Rpxfak9hpRcuYLutlhd+fx6xyFE769zebb+Afob1fNDoFarz8KsvTJqhFUwl?=
 =?us-ascii?Q?0dbpu3C9MXBP9heRZBt6m99MjRaaumnOVj3KWYlcvqTLfqqKftNe4JjPlP74?=
 =?us-ascii?Q?WYtYY6JPRTrD4HIrbUg/hn3x3NtGgWX2qLoZR19qd1268lQxZz/dbomhquBG?=
 =?us-ascii?Q?/Ix5+LjCXPjl6MG9M0yFHGoAwNzXrETJrEUlZcN7FrB6j7awc/aeZoVMn2n7?=
 =?us-ascii?Q?Fokhxk36nO5/qOWfIoR24/DtkPGuq1zxyY0PzUQx9lLTB4MoMNbLCJ3bj3Cn?=
 =?us-ascii?Q?dQv7XLm0aDK5WPrc2Y8PCBDGHTKUpwsOlCMJK+XmXPHXGMPYvZoY5QfPVrl/?=
 =?us-ascii?Q?Y+AQHD8/QhZmTge8COELJYI1dkMNILx0QzYrbZyp6IDHMCS3LeDhLcpzOte/?=
 =?us-ascii?Q?tzbnxsbrDQTbswvOXnSV2/JoriUgLpQv3KMx0DqrZCjjC+sahweBxLH7uhTk?=
 =?us-ascii?Q?4FMWxCLpHZny9Lr6fRuLGr+y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018dd33d-1684-4940-f52a-08d925b3fcf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 10:48:42.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QuQQVm3WxOdRkDxvdx1ENUFvpzLCDr9bfTbHRHIxVHStJIiTlbVrAHG6n6hhxM+2EkS5Ytr8A/pssO+S/5vMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7239
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne
> Sent: Monday, April 19, 2021 10:49 AM
> To: Moritz Fischer <mdf@kernel.org>
> Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: RE: [PATCH 3/3] fpga: region: Adds runtime PM support
>=20
> Hi Moritz,
>=20
> 	Please find my response inline.
>=20
> > -----Original Message-----
> > From: Moritz Fischer <mdf@kernel.org>
> > Sent: Saturday, April 10, 2021 3:01 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git <git@xilinx.com>
> > Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
> >
> > On Fri, Apr 02, 2021 at 02:50:49PM +0530, Nava kishore Manne wrote:
> > > Adds support to handle FPGA/PL power domain. With this patch, the PL
> > > power domain will be turned on before loading the bitstream and
> > > turned off while removing/unloading the bitstream using overlays.
> > > This can be achieved by adding the runtime PM support.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/of-fpga-region.c
> > > b/drivers/fpga/of-fpga-region.c index e405309baadc..35fc2f3d4bd8
> > > 100644
> > > --- a/drivers/fpga/of-fpga-region.c
> > > +++ b/drivers/fpga/of-fpga-region.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/of_platform.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  static const struct of_device_id fpga_region_of_match[] =3D {
> > >  	{ .compatible =3D "fpga-region", },
> > > @@ -302,6 +303,7 @@ static int
> > > of_fpga_region_notify_pre_apply(struct
> > fpga_region *region,
> > >  	}
> > >
> > >  	region->info =3D info;
> > > +	pm_runtime_get_sync(dev->parent);
> > >  	ret =3D fpga_region_program_fpga(region);
> > >  	if (ret) {
> > >  		/* error; reject overlay */
> > > @@ -324,10 +326,13 @@ static int
> > > of_fpga_region_notify_pre_apply(struct fpga_region *region,  static
> > > void
> > of_fpga_region_notify_post_remove(struct fpga_region *region,
> > >  					      struct of_overlay_notify_data
> > *nd)  {
> > > +	struct device *dev =3D &region->dev;
> > > +
> > >  	fpga_bridges_disable(&region->bridge_list);
> > >  	fpga_bridges_put(&region->bridge_list);
> > >  	fpga_image_info_free(region->info);
> > >  	region->info =3D NULL;
> > > +	pm_runtime_put(dev->parent);
> > >  }
> > >
> > >  /**
> > > @@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct
> > platform_device *pdev)
> > >  		goto eprobe_mgr_put;
> > >  	}
> > >
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	ret =3D pm_runtime_get_sync(&pdev->dev);
> > > +	if (ret < 0)
> > > +		goto err_pm;
> > > +
> > > +	pm_runtime_put(&pdev->dev);
> > > +
> > >  	ret =3D fpga_region_register(region);
> > >  	if (ret)
> > > -		goto eprobe_mgr_put;
> > > +		goto err_pm;
> > >
> > >  	of_platform_populate(np, fpga_region_of_match, NULL, &region-
> > >dev);
> > >  	platform_set_drvdata(pdev, region);  @@ -422,6 +434,9 @@ static
> > >int of_fpga_region_probe(struct  platform_device *pdev)
> > >
> > >  	return 0;
> > >
> > > +err_pm:
> > > +	pm_runtime_put(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > >  eprobe_mgr_put:
> > >  	fpga_mgr_put(mgr);
> > >  	return ret;
> > > @@ -434,6 +449,7 @@ static int of_fpga_region_remove(struct
> > > platform_device *pdev)
> > >
> > >  	fpga_region_unregister(region);
> > >  	fpga_mgr_put(mgr);
> > > +	pm_runtime_disable(region->dev.parent);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.18.0
> > >
> >
> > Does this add a dependency on CONFIG_PM?
> >
> Yes, the newly added functionality has a dependency on CONFIG_PM if it's
> disabled the expected power domain (in our cases it's PL) will not powere=
d
> ON/OFF dynamically at runtime and this is as an expected behavior. Other
> than this it will not impact the any of the driver existing functionality=
.
>=20
> Regards,
> Navakishore.

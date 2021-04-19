Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DBA363AF7
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Apr 2021 07:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhDSFTO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Apr 2021 01:19:14 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:52064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229473AbhDSFTN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Apr 2021 01:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbbrHRJDNCObFqy2aPZ/UtdUwdC1Ps9oNM3sekDdwUWYMIdJVgc4d0R9BXaKP0Kt1UKo/mWxcD+CTmXf2WxaPeNul3KUZhscNEUIwCQ4D+qwSh3qzJr9N2hnroT6+Gmr540xLX0YA4gd+sDhJC5ouVqAFGv19GFqceKVHJYjhrepA+W/HH1lOZapkuUgff1B5VdpGGHcWyX3A4ytflLAZuFld4OcCPLTni1R1oV6YvlEVM08/Q35s4AUWE2LVP8Z+W3YRD9YaZphm1tqRGWlFThC6vDZ8N2zIluKGE5ZAtEt6kP5dXLgDtQm0Q1RwaSSnJfEfBzT8L9jmGWRkbAzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXC9e93PUyqYnqSD5wuRx8MAaMfdfW5g6MI/GTUnsLg=;
 b=ig+gTIRxyl+cJC1ekVNjayWa2RmLeQxO2TJWBPI5ua/KPN/elceeQQNA1kw6Ur5ChJrqccdeyniEaRUqcN786losEHxYSBZP1RbU03589pRBMdliLUfkjvCrtO1dwVNZi/OKlN7pPCxPKY9T/itjtGwY/FpJ/Zmpdj+I8a1iATIYTQdY8S6Aq4GHA/16TWOVit0nYXvJ0OvaYxG/I6ks3XNzy9L2oTmZ5psZi6u5lEbDRkuIdJDdbsLndn9kFqP4LSTehZDKdegX/ZQgT5Voxfc6jXusYJOQYyCigypK4qTeH7kBgVMBlXgAWAWsbdo2Z/fTwTFqhwPV55mN+3VnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXC9e93PUyqYnqSD5wuRx8MAaMfdfW5g6MI/GTUnsLg=;
 b=knTkONKY314ceENk0kSdqKTOF0s97rDwsInrmyAfNV7DU+QsgO1Bml28oCZ5yHCYXtRlZb89Lkcdu7+ZSCBjTSEwqBhXRffQlClBk78piprFQBAeJl5NM2B1R4lWIOPy/25gsmKS2MC9pB6sJ+RK/oRIeT3+SxF9W3ACoyFiOi4=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7604.namprd02.prod.outlook.com (2603:10b6:303:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 05:18:41 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 05:18:41 +0000
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
Thread-Index: AQHXJ6KdTpEiWN/+bESGWLEVPH0Elqqsv+2AgA6mmuA=
Date:   Mon, 19 Apr 2021 05:18:41 +0000
Message-ID: <MWHPR02MB2623E61ABFBB478E95DC863FC2499@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-4-nava.manne@xilinx.com> <YHDHhf1tQo6vI49W@epycbox.lan>
In-Reply-To: <YHDHhf1tQo6vI49W@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b96d5d46-32f6-4637-505e-08d902f298aa
x-ms-traffictypediagnostic: CO6PR02MB7604:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB760433E2181CD013108C884CC2499@CO6PR02MB7604.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMlmY87CPkqGkGQntW5QJMACW/d29FUKQ/KQhuCDUYdA13mQCEE9l8E2l6vZiZGExJgifKzr+4eONZYpLaoBNNPt2Ilo7qFF2DuQ8kBr0gt3amhxmDpI5DaWmx2woCA2rUiZgwY+t4+rPmkBscZSQBJBL/WJWH6m1VqhRTGRpfTqrpx0T3aBUQhxRztRONNhBb4FvLMdO5qCtLd6F99YQ019zNwewIbIQFi1+0+7uhIMoWulW+k5auHrvnaJ2TglEr6JtLE7TZZQOHZb8F7fpmF44At5Lmja5J0xt0mqNZVh2OnlI5jD8xa5b6e9hWDFoGqXOfhFEeq8WYrY0FarD6ZP47FDSyAUxbOg+inwa2d/h31O20QEvw4tpWDz+YGHcPXZTfWCeURvpnDgEtJ+jNmpUhOmTXRTImPd56ZRXbAOpzyUwwfkGtqMtVtXcuAL5pE0L6YmQvny0BiaIoAT4UIZmseKkkgSNsgHyuoEmYvugy2W0Ap1RlaWoKz+3iVrcYIU55Z175H4OLhNDchMaQZL0ERRgNMD+nuK2d5aiHRZoxWnypX9ycOfD98FWJ80sKsQKYYQCivUyQywL7zF0Ipj80DcSY/IUUF+nbFoL7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(71200400001)(26005)(52536014)(122000001)(4326008)(54906003)(186003)(478600001)(33656002)(8676002)(8936002)(38100700002)(86362001)(7696005)(55016002)(53546011)(6506007)(64756008)(316002)(2906002)(66946007)(9686003)(66446008)(5660300002)(107886003)(83380400001)(66476007)(6916009)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C6G/rwHftHk4MxTu8T23wIucioeLD2kFjas6LaffkZ4A97kuEL/l+z4SAzR/?=
 =?us-ascii?Q?Unq8eMAxKlte6tk0l78JCRcQcHWDgnufbNYRLp41EcL1HIEmx/hfdjrifDzg?=
 =?us-ascii?Q?2enEy0lLrxuqG69zLC4X77Qj1TnNOd3+By31/EAKR9JBWQ5RuQFkOuMbledf?=
 =?us-ascii?Q?HVKAp8v5KV4KukxynjDuFq446dQ55bmBbtWytRUGRAZrbhTVDrjv/JZFZU+T?=
 =?us-ascii?Q?ta4E7jaPeUQv1aqapjHKnFaU07N8Gkgk5c2jKA6KSZ4zpGBYVVabv6MxMM6i?=
 =?us-ascii?Q?Erp0G6Vky3Ikg7Eymq8v1btQZ+n/zJebKt2qfCi7AWQOQeM95Mt0JVZiLG38?=
 =?us-ascii?Q?UOZnms7yGeMTfJkTVVUOiZy66imRDbZTPYrMeTBfGbuyY5zsvLOICQ06TQq1?=
 =?us-ascii?Q?0Ebd5BCzPyq29yArdDYQyEdU9EH25m+KXYvG/dQ6PADwaYJkOMTAEKMfHs14?=
 =?us-ascii?Q?AdgOrtt/9F209tHspwCOVf9iChE6W8oMkzGxlb9zkqvi1M3xJLV18wTaMR7i?=
 =?us-ascii?Q?9QI0RVkRHYv65c9ipHokysuUJcW8vcx0HAocAzSYphx4ZY8h764RXezXjxA9?=
 =?us-ascii?Q?5YoJJB7CXErjrZ2PCEdXgjGdm2cf7L40FapkHOKZXYMmLPPLGs+6xAMUiKQB?=
 =?us-ascii?Q?YSNUHBbEU/UrRSSmJNteTB6ththqhzmqp7WF05k4YVD5guFkQGSHoKki+/ol?=
 =?us-ascii?Q?HvyskyCey3QwnxSLPzemm9rzxRZ4lprD5dCXJ8hWYjEi5Ffs9pzmCWJSq1b0?=
 =?us-ascii?Q?JuUciL/xyBe+dFsxCsWszSBcmN+Xyo6AO4YSJFGANldvCwYt3yo/2T9brALK?=
 =?us-ascii?Q?/F6VUxE63OKszHcCPfehadVcLvnA76fiyba3TKNTe93d0OT+YeGlKBGACmN2?=
 =?us-ascii?Q?NSPERumpyaakAwbuV725K5ZvnbSf2T1NWy8IHmkoDwb3luI3qRfxNiysrkb5?=
 =?us-ascii?Q?AmjatCRE981g19/irUF7JcVu9OTZxr8ZWGMf0pBUUSUiIfoVv2bQYxqToF2A?=
 =?us-ascii?Q?T3Of17ljM+K18nyYWsBZ5gs1bBYJ1GxxaPzr7lmZ8LAO9jkEelLcr7aURQeL?=
 =?us-ascii?Q?7QonP1xrI0LASvTFse7EtbxJbePL/TVRfck6frvjeHkDscmon6uNAKHAt+aP?=
 =?us-ascii?Q?jL4jw+Yxc/PJdML4NW8ZjcePmo4R6IocraJKPXRecPX2m0uxskrySA7Pivo3?=
 =?us-ascii?Q?pevdLELiDWJtRftbD/YhSQpdQ19iY+ogFgPljlcq7ZGtQEtNY2boSkOjSZcH?=
 =?us-ascii?Q?HTwfoCnCykZeFssEIPiBMZLWWETkoULhybiCK/9/1s8fGj3x8q/q8Y6RFTIV?=
 =?us-ascii?Q?EYUOZ3iWIk06154WENk/DbNk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96d5d46-32f6-4637-505e-08d902f298aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 05:18:41.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHWVW2IgtRVRP205eZZy7vq017Hdg3WnZo/Yo5xiZZPiY+yJfrQ4KtLxRcQa9JG4u2b0fFEKPd/C7D7PoBwV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7604
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Saturday, April 10, 2021 3:01 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
>=20
> On Fri, Apr 02, 2021 at 02:50:49PM +0530, Nava kishore Manne wrote:
> > Adds support to handle FPGA/PL power domain. With this patch, the PL
> > power domain will be turned on before loading the bitstream and turned
> > off while removing/unloading the bitstream using overlays.
> > This can be achieved by adding the runtime PM support.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/of-fpga-region.c
> > b/drivers/fpga/of-fpga-region.c index e405309baadc..35fc2f3d4bd8
> > 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pm_runtime.h>
> >
> >  static const struct of_device_id fpga_region_of_match[] =3D {
> >  	{ .compatible =3D "fpga-region", },
> > @@ -302,6 +303,7 @@ static int of_fpga_region_notify_pre_apply(struct
> fpga_region *region,
> >  	}
> >
> >  	region->info =3D info;
> > +	pm_runtime_get_sync(dev->parent);
> >  	ret =3D fpga_region_program_fpga(region);
> >  	if (ret) {
> >  		/* error; reject overlay */
> > @@ -324,10 +326,13 @@ static int
> > of_fpga_region_notify_pre_apply(struct fpga_region *region,  static voi=
d
> of_fpga_region_notify_post_remove(struct fpga_region *region,
> >  					      struct of_overlay_notify_data
> *nd)  {
> > +	struct device *dev =3D &region->dev;
> > +
> >  	fpga_bridges_disable(&region->bridge_list);
> >  	fpga_bridges_put(&region->bridge_list);
> >  	fpga_image_info_free(region->info);
> >  	region->info =3D NULL;
> > +	pm_runtime_put(dev->parent);
> >  }
> >
> >  /**
> > @@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct
> platform_device *pdev)
> >  		goto eprobe_mgr_put;
> >  	}
> >
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D pm_runtime_get_sync(&pdev->dev);
> > +	if (ret < 0)
> > +		goto err_pm;
> > +
> > +	pm_runtime_put(&pdev->dev);
> > +
> >  	ret =3D fpga_region_register(region);
> >  	if (ret)
> > -		goto eprobe_mgr_put;
> > +		goto err_pm;
> >
> >  	of_platform_populate(np, fpga_region_of_match, NULL, &region-
> >dev);
> >  	platform_set_drvdata(pdev, region);
> > @@ -422,6 +434,9 @@ static int of_fpga_region_probe(struct
> > platform_device *pdev)
> >
> >  	return 0;
> >
> > +err_pm:
> > +	pm_runtime_put(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> >  eprobe_mgr_put:
> >  	fpga_mgr_put(mgr);
> >  	return ret;
> > @@ -434,6 +449,7 @@ static int of_fpga_region_remove(struct
> > platform_device *pdev)
> >
> >  	fpga_region_unregister(region);
> >  	fpga_mgr_put(mgr);
> > +	pm_runtime_disable(region->dev.parent);
> >
> >  	return 0;
> >  }
> > --
> > 2.18.0
> >
>=20
> Does this add a dependency on CONFIG_PM?
>=20
Yes, the newly added functionality has a dependency on CONFIG_PM if it's di=
sabled the expected power domain (in our cases it's PL) will not powered ON=
/OFF dynamically at runtime and this is as an expected behavior. Other than=
 this it will not impact the any of the driver existing functionality.

Regards,
Navakishore.

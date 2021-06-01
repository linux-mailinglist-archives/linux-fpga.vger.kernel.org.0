Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A066A396D9D
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jun 2021 08:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFAG6U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Jun 2021 02:58:20 -0400
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:24122
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231139AbhFAG6T (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Jun 2021 02:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUDSz56TU2TYTsYZvIeK4WyfU3sls0IxJaH14q8os3Gp2vjoG+rmz2QKiQnjipyY7Wyh88RSn2mVK6CBv1eVJXoHVMPcGmbt03bk1uwWhknfcPTjnMj26qUvXd2n2mPGWHRZGJlq+X0hbRc7in2EjCyyWHR72OL4+KpXfHHYbXJBdL8FZyAXAFXuR/hWKfxsq33yZzdep/MTF1hJZAL8ZeApblk4ViB5SzsBwkMbC9iUmnnjzi2YjudF5pKknzsNozmnvKG1S9u1UPwYVkY2IquJXtHmE7VaO6MjAkOWUFncxMfyrcqqbZbTmQaA99IIqbxPWVW8CM6653WsJ1IFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuW8Jc+boMEnNKDtYASy6hhBjwEphDyDcndNvkMGZC8=;
 b=fdw/hrEHdoKE0bG2/I/Sw/jO5Rhag52GJ0TZkhIWBDc/YMj+MAJJwjnCcjD8Na/FJ465ImtHb8kuVGKPZiGt0+heJYoLzmpEi68mS+i1i8hXbcowVFYGZAYHogfwrSrifc/Oo4iToLZVM44P5/OoQi/ZgiSyWzr2DTcW6bJZZ0ubv6lpSJUGVGURld5jx+tTEGnu1ag0IVffcoxizugUIxFoCcPJtqAOCVqDWAjBBefOkE7UFAU+43ugZTBwV3uUYQ7BLXHOFUQkwMUvbjqroqoWgO8nh6SoPPzUhmD3NXeL3Tg23u/cOwTlxC7cXuJGazNq9I1wrjmEcyUqd5IA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuW8Jc+boMEnNKDtYASy6hhBjwEphDyDcndNvkMGZC8=;
 b=RnHm4jvmSTNldWpfPPs8TN/ha69i8vO4g2e6ypdbLpmMb8jzNZK/Y+/XIRNfwaWgZp1TD08sjWQA27GWncbz/sdq8xdhLZqEaXgUZQxRnIy7CWa4RvSwYo80/fnBo3tHZOr3WjXRa4zfZ4BkGy/djsNo29a04NspshAMqYZZD3E=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB7304.namprd02.prod.outlook.com (2603:10b6:510:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Tue, 1 Jun 2021 06:56:33 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 06:56:33 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <RAVIPATE@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
Thread-Topic: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
Thread-Index: AQHXTU+iaNo/Lx6wC0mUnqfp+5BQFarsD00AgBK10GA=
Date:   Tue, 1 Jun 2021 06:56:32 +0000
Message-ID: <PH0PR02MB73361AA34F762B497CFDEFB4C23E9@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
 <20210520080954.1393-5-nava.manne@xilinx.com> <YKYidhc25e4SIwNi@kroah.com>
In-Reply-To: <YKYidhc25e4SIwNi@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd1df2c3-007c-422c-3aff-08d924ca6417
x-ms-traffictypediagnostic: PH0PR02MB7304:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB73042BF43D488174C9CD0253C23E9@PH0PR02MB7304.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+Lmff9cxgSotTpDUbffEPytESJl0+iknN4ZxrDbHW2O0PWwZnRSroBEe9gdIkPcFKWBkv/aXrBa5CFC768oME0DXgOAd+1ZVhpQGoVi4AlBoIvUcVbHZiUx4A96Z3pZLWp5M9+CVLS3DbmGkddKpkj4/0Ft3pMcnOBrX8BTed6JrvrzSpYAgkKZtEwtpFmTa6pBJvoHvtWb78+4XIUdDFHF5yJj10t3xWBx6n9eErqHeEdlXs/Z1iOEgAf5OhThyRBK3r/s/zgTExKgBansoEllArlRuMopDYeZQOFrR9SOLgcVAv0MFe8EAdBKC7UNo4iBi6p3IgbIg7nCJhujqIPjvaYoLx3tssbui3yZQYVGSjJco4tff0UVqhlaFMHM+15bVncDDD6BkA1+N9CFo2sbKB3Nf9RFkjiK2TQJK3wM5GmjF/8uILSCDBlxAVhAtF4TeUX5C+3OSOXXAx18c29yr1ireFJeGamou/hA7lTxf1eRBQDdZgoVmN+iGebAV4emfDdnnmDKOlFzKCSXWIPfkrxnEsuT3zhrPdTnrPLSo3DbgRbaP/e938MuzZK/qHItYUEL+/72d5rpUqxUYmpA9QyLwRaQAsenEfbJ9WE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(107886003)(8676002)(122000001)(5660300002)(66476007)(53546011)(83380400001)(186003)(8936002)(2906002)(9686003)(26005)(6506007)(64756008)(76116006)(66556008)(66946007)(66446008)(6916009)(478600001)(33656002)(316002)(7416002)(55016002)(4326008)(38100700002)(7696005)(52536014)(86362001)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tc7oLuRp5ZimCcrH72mF9RGy6/Brpm70RF4UB8Q2Nun8x0vFawILc4TAZ5Ur?=
 =?us-ascii?Q?RMZYb9YrGkbNMFbE5DhoaiivOthsfQWyndIQvRrafTMBgCR64Ai9r7aetQFr?=
 =?us-ascii?Q?CSkBAE/8U/Xke5vPlrvTidHysptaYN+8lPu3y1D9Z9USVIG6hHi/n5vmCU03?=
 =?us-ascii?Q?eNxsDDlcyKPYJAARvYeLCg2BUg+EmnD00vc0WdyOId4OuSWFiuPxJtamGm1n?=
 =?us-ascii?Q?ms4ENFL39E3Ccpy5lya8jWrNhm8SNYiv6xgkaNeeNFlOqONY6MeoTwU0NpDk?=
 =?us-ascii?Q?n9xFuySI3xouWHIZAiH/eZt8FCerUM+iqyuwiGVxf565/IdzUUw4aPThlqEa?=
 =?us-ascii?Q?28Y17iVKErDICxT4ar+97x2qn9jixQFfu6DhHvfM6yifyE7LdZEvut8IKdJV?=
 =?us-ascii?Q?8amX5ZaQ9JcJmX5XRIv8jJqm6iFTCQtEJl5Ml+Rs6MYu8l5Krbarjsr06qKy?=
 =?us-ascii?Q?CgoSc3zGUEgHtttB3hgIC8WNjchU5rX/FfDgH+hxgjXZQ8Vsckk73Ekd3TF1?=
 =?us-ascii?Q?9bquCN6PsBz2JqyWga/lbnXkwgkUNB5yJRAHOpI7A5YKgBpS/syIJzXiaKZo?=
 =?us-ascii?Q?jlxSy88bGGopdeRlOw+efIyT5J1dFZO5FrbYi0U1f6c348B7Bv8wCvdvzk8W?=
 =?us-ascii?Q?kaMeIsy2W/OF8kl0Oxx0pMWDmB7HqDdvfK1dluXw+Xk0OCxeUEp8jnF4hb3U?=
 =?us-ascii?Q?O2jNMlckD+xqPmoDqwUgXiYMwN9CQxM3Hsmb9bs333Y303ZxW5yCaotgCPo7?=
 =?us-ascii?Q?Qa2LAHQdAs+jXMDyeLAxfzsCdMFhM8VL5eIohsw0Q8iMsd3smif/JOnm0RTI?=
 =?us-ascii?Q?vEzu5G17zDmMKjNkuSX9WFVsT27IHyIi7SroD0jhIj85Lq6TGYLSWUovq/GK?=
 =?us-ascii?Q?VPvApyBX1m7mYuDMFTtluYH6GAh/Sm8vNEhd0F/gExCFcC67lhleCKPoAiDd?=
 =?us-ascii?Q?WE3Nn++bgV7fOYOmmH2OV2f5SgEI1MeWU0lbHxS5?=
x-ms-exchange-antispam-messagedata-1: RJh54J/vp/REEB6gBxOKfgstXPT7/vrPu+YQcOeJbxHlb7RSOc+M2Hged/x6GkZu7PPjf8yTQFLP8KjXL03KceczN/nIRxh8OJm9v6xxMVFXzKwnCH6EiXELO7XJXdobMkHW2hjiN7l2IOxEmU2zFeQa0VlYgavGRep11oIgFvNhPgZjPFaO6O8m5A7LdM8vmmRgpFaWhinpb5uQkRE+10iubDxiotHThoz5O3sqT5EfGZRSndqA/2sR/IYlZD/s4rmDWUfLf70vysINu836jC50NAV9RWxE/73CpQkAYIi3JRjc8gMBLOMBGlaB1Iko1oFi5VHhr5v4UGORqnJ+SUIK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1df2c3-007c-422c-3aff-08d924ca6417
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 06:56:32.8255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrWJBXGjUP8eTS14rugwaDCF0beEfoNfjRhmG05meMzjUyC/YfhDRH5yyXovByoZHendN2vnyA1G/sgJ8Cb/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7304
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, May 20, 2021 2:19 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> mdf@kernel.org; trix@redhat.com; arnd@arndb.de; Rajan Vaja
> <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> Tejas Patel <tejasp@xlnx.xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Ravi Patel <RAVIPATE@xilinx.com>;
> iwamatsu@nigauri.org; Jiaying Liang <jliang@xilinx.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>;
> chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>
> Subject: Re: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager dr=
iver
>=20
> On Thu, May 20, 2021 at 01:39:54PM +0530, Nava kishore Manne wrote:
> > Add support for Xilinx Versal FPGA manager.
> >
> > PDI source type can be DDR, OCM, QSPI flash etc..
> > But driver allocates memory always from DDR, Since driver supports
> > only DDR source type.
> >
> > Signed-off-by: Appana Durga Kedareswara rao
> > <appana.durga.rao@xilinx.com>
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > Reviewed-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > Changes for v2:
> >                 -Updated the Fpga Mgr registrations call's
> >                  to 5.11
> >                 -Fixed some minor coding issues as suggested by
> >                  Moritz.
> > Changes for v3:
> >                 -Rewritten the Versal fpga Kconfig contents.
> > Changes for v4:
> >                 -Rebased the changes on linux-next.
> >                  No functional changes.
> > Changes for v5:
> >                 -None.
> > Changes for v6:
> >                 -None.
> >
> >  drivers/fpga/Kconfig       |   9 +++
> >  drivers/fpga/Makefile      |   1 +
> >  drivers/fpga/versal-fpga.c | 117
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 127 insertions(+)
> >  create mode 100644 drivers/fpga/versal-fpga.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 33e15058d0dc..92c20b92357a 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
> >  	  to configure the programmable logic(PL) through PS
> >  	  on ZynqMP SoC.
> >
> > +config FPGA_MGR_VERSAL_FPGA
> > +	tristate "Xilinx Versal FPGA"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	help
> > +	  Select this option to enable FPGA manager driver support for
> > +	  Xilinx Versal SoC. This driver uses the firmware interface to
> > +	  configure the programmable logic(PL).
> > +
> > +	  To compile this as a module, choose M here.
> >  endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > 18dc9885883a..0bff783d1b61 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+=3D
> ts73xx-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+=3D xilinx-spi.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
> > +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      +=3D versal-fpga.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-plat.o
> >
> > diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
> > new file mode 100644 index 000000000000..5744e44f981d
> > --- /dev/null
> > +++ b/drivers/fpga/versal-fpga.c
> > @@ -0,0 +1,117 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019-2021 Xilinx, Inc.
> > + */
> > +
> > +#include <linux/dma-mapping.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/string.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
> > +
> > +/**
> > + * struct versal_fpga_priv - Private data structure
> > + * @dev:	Device data structure
> > + */
> > +struct versal_fpga_priv {
> > +	struct device *dev;
> > +};
>=20
> Don't you have this pointer already?  What device is this exactly and why
> does it differ from the structure it currently lives in?
>=20
Agree, this struct is not needed.
Will fix this issue in v7.

> > +
> > +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> > +				      struct fpga_image_info *info,
> > +				      const char *buf, size_t size) {
> > +	return 0;
> > +}
>=20
> If you don't need this, why include it?
>=20

Agree this empty API is not needed.
It's a limitation with the framework and this needs to fixed in the fpga_ma=
nager core.
Will address this generic issue in a different series.
=20
> > +
> > +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> > +				 const char *buf, size_t size)
> > +{
> > +	struct versal_fpga_priv *priv;
> > +	dma_addr_t dma_addr =3D 0;
> > +	char *kbuf;
> > +	int ret;
> > +
> > +	priv =3D mgr->priv;
> > +
> > +	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> GFP_KERNEL);
> > +	if (!kbuf)
> > +		return -ENOMEM;
> > +
> > +	memcpy(kbuf, buf, size);
> > +
> > +	wmb(); /* ensure all writes are done before initiate FW call */
>=20
> What "writes"?  The memcpy above?  Are you _SURE_ that really is correct
> here?  This feels wrong.
>=20

Will fix in v7.

> > +
> > +	ret =3D zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
>=20
> If this needs some sort of barrier, shouldn't it be in this call?
>=20

Will fix in v7.

> > +
> > +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> > +
> > +	return ret;
> > +}
> > +
> > +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
> > +					  struct fpga_image_info *info)
> > +{
> > +	return 0;
> > +}
>=20
> Again, why have it if it does nothing?
>=20

Same as above.

> > +
> > +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager
> > +*mgr) {
> > +	return FPGA_MGR_STATE_UNKNOWN;
> > +}
>=20
> Again, is this needed?  If so, then the fpga_manager core needs to be fix=
ed
> up :)
>

Same as above.

> > +static const struct fpga_manager_ops versal_fpga_ops =3D {
> > +	.state =3D versal_fpga_ops_state,
> > +	.write_init =3D versal_fpga_ops_write_init,
> > +	.write =3D versal_fpga_ops_write,
> > +	.write_complete =3D versal_fpga_ops_write_complete, };
> > +
> > +static int versal_fpga_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct versal_fpga_priv *priv;
> > +	struct fpga_manager *mgr;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev =3D dev;
>=20
> You save a pointer to a reference counted structure, without incrementing
> the reference count.  What could go wrong?  :)
>=20
> You are getting lucky here, but as stated above, why do you need this
> pointer?
>=20

Will fix in v7.

Regards,
Navakishore.

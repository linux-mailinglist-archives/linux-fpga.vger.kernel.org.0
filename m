Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE9300076
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 11:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAVKgl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 05:36:41 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:8897
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728067AbhAVKfO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jan 2021 05:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL1wmdi01d+FHjuPQYuXHGeq462HbRaMz9yiGXpK/1gheTFm5kbtHZTUutBHi+bsqImv/wKfdirXfTgpSIowYzRgvmwhLdxXWSKIHgdXuYMcxCA3RrxI83rLQrCPnVRaPvFrI7KZaH5uWeMPxMQbB37GtNOvydasLOtf0bSS1oxyDqLoDrB32sA7/pyMK/fHmDcK5CheGv7cupYiEGMJFOsJCA5zPQqDNbGwyN5WQxRDDcgvxri1fsp7GJODZSQtTx3O4iHjGk3N9N1e5538FmqpVaUn+0eWYEXQoy+beXMAp6vHUz9SkiweWLuceb5LKQxl6JCVbiu+4nODIlKmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQIijxbWmv6pUY108OO4ofrfCpckci1uH3ncWl3f43E=;
 b=d4PHpASbUvr+B5CUklPySGfrwluCNt5IomxDZ/FUdpnJZhmikcmEPi0J+STW3Ql2f4m56mYiU61mmo9ojNcJsloDRWpCYnvpiidJ81ZZtngM+VIqGIkcVh9NZN6J1j6DIbW2DEu40jMpaiRhT+ollhKrqvlXi8KuGYswDG/44XXizLOwM9tR6YpFbpwiSsrGNjFbxNdD+D6B9HDWewqIeiX3PRyTV1ODalL5X4esrfN7N5npDK1iDw6Bkie2oDrmZ8Mq+j2HUcAcaugQs8X2DzZfXxGtNvyC88VTi6lQKaE+hIuHlF+K8yo2BOO+Y0medHAjyLOC3IOyYntIoxBTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQIijxbWmv6pUY108OO4ofrfCpckci1uH3ncWl3f43E=;
 b=gUzp7oeVggwFMoKtnCsx0sG7OezlGbh+Ht+Pn3JHcHh7BPAdLi7iAvVA3b2F+N+En89kW93HbDBXzErUUlk3P+DH8N94qve7cBQ99CqyI9pRc7XVnNB1gKRhALDq8fv+VM628WpYxfffhvytm8KfNPIR+107Xul3D4bVROohwk4=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR0201MB3611.namprd02.prod.outlook.com (2603:10b6:301:76::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 10:34:15 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 10:34:15 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
Thread-Topic: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
Thread-Index: AQHW7USLyeY5b3FOfkKTbQUTtVqUFaouGt0AgAVRbYA=
Date:   Fri, 22 Jan 2021 10:34:15 +0000
Message-ID: <MWHPR02MB26239A3F539DE8E053D512D5C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com> <YAYo1ksLfMMNxPuL@epycbox.lan>
In-Reply-To: <YAYo1ksLfMMNxPuL@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acfdc08d-b632-4efa-f5b0-08d8bec14451
x-ms-traffictypediagnostic: MWHPR0201MB3611:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR0201MB361106AB8D2D1F42F7829291C2A00@MWHPR0201MB3611.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVbMQiwldz56WpZyuzx3DhTYy99wL+X1OSUfWN+4R34Uj2bp8HDtqCIYWmsFaVDWKXRsNvas+j510GEIABb5TEQlCQ4sId86FfHuPNpZhYHCYUXrXiIfdebmaCcSjZn2toMv9ZelTo9JnmqVA4x9d4UuvTAjo5heY4vP7heQnrz2ltAlGFhpsgYO5eb/HIu1JW65+vMSDPurIEGXj61gw1++yFG3yeP2qPn4h95JZSU8ko9MhvxYVWNvnT1dp7Y1RH5SB49WbT2KwvgZKVAoXuBVAPUWwiLI+/qwyuxgGKHvo1bsVPlxoRv2Lf8CmAC1T5kIp0ffGANhjxgLdNhkqw0EtzpgwValhT2r24nPcHwjRJefuPUvyTpAwhzcXZ1DmaKdW4FOp+dnXOErXYaGIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(66476007)(186003)(76116006)(8676002)(33656002)(5660300002)(6916009)(9686003)(52536014)(64756008)(4326008)(8936002)(71200400001)(66446008)(66946007)(55016002)(83380400001)(107886003)(86362001)(6506007)(7696005)(66556008)(478600001)(316002)(2906002)(54906003)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OZplxRlTXB43zEfsWZZDxYw18kjI+E58C4Oq/d5zbJ+uAe/BUQV8qT6vA0DJ?=
 =?us-ascii?Q?K9/Kg/OW78KQBsi5T86eE362oORjG16Tgx2tqCBAosF7DeMZ6ByjUppY7w42?=
 =?us-ascii?Q?mQE+Fa1YEkTDx4g4OQ2slKMly38ai4S3rh6wWtvkYp3Yr4Nk975/W0f0rf8/?=
 =?us-ascii?Q?CYtLDZmAiKPSPohVmQdDFDya/wqHM3Ld7DtlG/YMOSaGleEgcjI2lEMTEzLu?=
 =?us-ascii?Q?fay1T0hN84m78Wk1tng+cKm0/wZ18ykKsBKyOYNaS8CQdpQRL90CZqz1kLz6?=
 =?us-ascii?Q?4Be5QGp/1I7D0o4aU34Hgut51Q+Yr5LwdbJG8cCFarL2JC5vxmeA1yZDp+AI?=
 =?us-ascii?Q?LdHY8HTB1e9gNe6Ai3nO4Kykmc9ZnS2AsRTSRYipb55DpBLwuQDiCISt0C/M?=
 =?us-ascii?Q?Pwj5tekIrKKuabgQST5XietzoB4h749FHJXP7hXnfLFqvF6OSJb7OiYupRIk?=
 =?us-ascii?Q?CTMTia21VT1+4dPq//Ao0fLVl8UBqmfTW1xZrSSEk2b9X0Uya8R5V2hC+a8K?=
 =?us-ascii?Q?ifmctpHa8jjYiawrRZ6qJ5Nk8AVh9dlmLn6RYZ+OjDeWQ4pwn3gx5nWBIIDs?=
 =?us-ascii?Q?XN9ZN5V9b8s+YjiJXwFdIvVJTyjMPsESRFQmQN1hzv+lgorwK0zHHD4x1HFn?=
 =?us-ascii?Q?MggLbRsNb+6jjYXLoMcyIOSpnsnGtvq9KtafuB2N/piDk+cwqw9nvfeEPPyn?=
 =?us-ascii?Q?Ud8g+2RHraz7/ukiMJpFDR5C2i5da8syxmke+Kq0jrsy3q7UHCcu6deF1ORz?=
 =?us-ascii?Q?VyQ+foGu57Qi99vvntARLhaf6bBEIyhHy0oeGR4wifIbWT630S72WrQJ+kLZ?=
 =?us-ascii?Q?ETWh2156ln+bxiIheDjsvLWm8DO6hxJ5Wf/uY33gWbuDlKIiJ79CzIkufYMa?=
 =?us-ascii?Q?ZF8ukXQJxUxoC0lgQfU1LJoxsFO+0X2ir5OTYfVQfGMeRljfN3WCmHvDShv4?=
 =?us-ascii?Q?is/96oQ78KyuIDtJ95bmwooxX++emXuIQ71P0Hi+vcqrZyMFmdNKFa/zTH8h?=
 =?us-ascii?Q?wKZLrQ4B7A+0xpBpiNYGB5+zj2DTumhaR5l0clnIpHw0zkCbr2M9XpmhWW9Z?=
 =?us-ascii?Q?mx5TdZ1J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfdc08d-b632-4efa-f5b0-08d8bec14451
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 10:34:15.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWl32RRmx/1dOxq0cglw41UdsDrFdlZNjSnCap6VxHdUETZ3rTotkSSdfDFpR7kBeHZkO+tb1zji4rU1IgJhsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3611
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Thanks for the review.
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Tuesday, January 19, 2021 6:03 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com;
> Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager drive=
r
>=20
> Hi Nava,
>=20
> On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne wrote:
> > This patch adds driver for versal fpga manager.
> Nit: Add support for Xilinx Versal FPGA manager

Will fix in v2.

> >
> > PDI source type can be DDR, OCM, QSPI flash etc..
> No idea what PDI is :)

Programmable device image (PDI).=20
This file is generated by Xilinx Vivado tool and it contains configuration =
data objects.

> > But driver allocates memory always from DDR, Since driver supports
> > only DDR source type.
> >
> > Signed-off-by: Appana Durga Kedareswara rao
> > <appana.durga.rao@xilinx.com>
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/fpga/Kconfig       |   8 ++
> >  drivers/fpga/Makefile      |   1 +
> >  drivers/fpga/versal-fpga.c | 149
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 drivers/fpga/versal-fpga.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > 5645226ca3ce..9f779c3a6739 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> >  	  to configure the programmable logic(PL) through PS
> >  	  on ZynqMP SoC.
> >
> > +config FPGA_MGR_VERSAL_FPGA
> > +        tristate "Xilinx Versal FPGA"
> > +        depends on ARCH_ZYNQMP || COMPILE_TEST
> > +        help
> > +          Select this option to enable FPGA manager driver support for
> > +          Xilinx Versal SOC. This driver uses the versal soc firmware
> > +          interface to load programmable logic(PL) images
> > +          on versal soc.
> >  endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > d8e21dfc6778..40c9adb6a644 100644
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
> > new file mode 100644 index 000000000000..2a42aa78b182
> > --- /dev/null
> > +++ b/drivers/fpga/versal-fpga.c
> > @@ -0,0 +1,149 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2021 Xilinx, Inc.
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
> > +/* Constant Definitions */
> > +#define PDI_SOURCE_TYPE	0xF
> > +
> > +/**
> > + * struct versal_fpga_priv - Private data structure
> > + * @dev:	Device data structure
> > + * @flags:	flags which is used to identify the PL Image type
> > + */
> > +struct versal_fpga_priv {
> > +	struct device *dev;
> > +	u32 flags;
> This seems unused ... please introduce them when/if you start using them.

Will fix in v2.

> > +};
> > +
> > +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> > +				      struct fpga_image_info *info,
> > +				      const char *buf, size_t size) {
> > +	struct versal_fpga_priv *priv;
> > +
> > +	priv =3D mgr->priv;
> > +	priv->flags =3D info->flags;
> ? What uses this ? It seems this function could just be 'return 0' right =
now.

Will fix in v2.

> > +
> > +	return 0;
> > +}
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
> > +
> > +	ret =3D zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
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
> > +
> > +static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager
> > +*mgr) {
> > +	return FPGA_MGR_STATE_OPERATING;
> Is that always the case? Shouldn't that be FPGA_MGR_STATE_UNKNOWN?

For Versal SoC base PDI is always configured prior to Linux boot up. So I m=
ake the fpga state as OPERATING.
Please let know if it is not a proper implementation will think about the a=
lternate solution.=20

> > +}
> > +
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
> > +	int err, ret;
> Please pick one, err or ret. 'err' seems unused?

Will fix in v2.

> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev =3D dev;
> > +	ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
> > +	if (ret < 0) {
> > +		dev_err(dev, "no usable DMA configuration");
> Nit: "no usable DMA configuration\n"

Will fix in v2.

> > +		return ret;
> > +	}
> > +
> > +	mgr =3D devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
> > +				   &versal_fpga_ops, priv);
> > +	if (!mgr)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, mgr);
> > +
>=20
> Replace this part:
> > +	err =3D fpga_mgr_register(mgr);
> > +	if (err) {
> > +		dev_err(dev, "unable to register FPGA manager");
> > +		fpga_mgr_free(mgr);
> > +		return err;
> > +	}
>=20
> with:
> 	return devm_fpga_mgr_register(mgr);
>=20
> I tried to get rid of the boilerplate, since every driver repeats it (and=
 above
> calling fpga_mgr_free(mgr) on a devm_fpga_mgr_create() created FPGA
> manager is wrong?) :)

Thanks for pointing it. Will fix in v2.

> > +
> > +	return 0;
> > +}
> > +
>=20
> Then
> > +static int versal_fpga_remove(struct platform_device *pdev) {
> > +	struct fpga_manager *mgr =3D platform_get_drvdata(pdev);
> > +
> > +	fpga_mgr_unregister(mgr);
> > +	fpga_mgr_free(mgr);
> > +
> > +	return 0;
> > +}
> drop this since cleanup is now automatic.

Thanks for pointing it. Will fix in v2.

> > +
> > +static const struct of_device_id versal_fpga_of_match[] =3D {
> > +	{ .compatible =3D "xlnx,versal-fpga", },
> > +	{},
> > +};
> > +
> Nit: Drop the newline

Will fix in v2.

> > +MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
> > +
> > +static struct platform_driver versal_fpga_driver =3D {
> > +	.probe =3D versal_fpga_probe,
> > +	.remove =3D versal_fpga_remove,
> > +	.driver =3D {
> > +		.name =3D "versal_fpga_manager",
> > +		.of_match_table =3D of_match_ptr(versal_fpga_of_match),
> > +	},
> > +};
> > +
> Nit: Drop the newline

Will fix in v2.

Regards,
Navakishore.

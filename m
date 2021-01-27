Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B630565B
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 10:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhA0JAn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 04:00:43 -0500
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:8160
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233773AbhA0I6d (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 03:58:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4ajooLIuQSQCLK7ezufa42540N/AtP2qONvCXoAgmq1oAtFkQ9sZB6UpxwKh0lAqi721ytjS4s6CFS6GDFq8MOozRw1T4mG4CUcWSx0Y1nsAgWBnOoxqwgLeisgXP3kbhwGeHd0XD3MsCVu3z2EsQNXE4NifTjkse9ZVX68EMzG/nGeIf3HusRNiAY0dWmvai5u4737QUbG7TvVhcN16wYCOHE+FNYoTC+ZmHSDRznyFjav1UtKvbyX37saVdbMF3m7BzOmhM5SiDNlS67njCrpsV3ryEDHGfWWxWUNFjn1ZLigstR2Vf9anAUJzzmNn+XvMVNHXa6OmOLQz/q6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+1PovnS+5JHiBMGOC4FiWqgK/Kd5tbgcB/8YS0oMuM=;
 b=giFUeao9sYCbLJJQ+pWjVpXv8U1McjYkO+k2Meo68emRsBGEJIASyUTavX7qDitW+Wurq88A9oDt6OBJV+O4LauhcwA+Up5UeSrEDGX4Dm3InVeJvyJhzyNfN5bN+oigFBcQ71o7ZmnZTigR6ELk9APIVX+HWFf0XV9hpGfEGTKhVCeNC3Zx8WCH4Vtsrpudcx9932Y8Z2qQ+W8HKeDHVIhiWYZwFzzumW/ALUUVZskQJmnjuCbQOGjzTY4/RQO91OsYnmzOxasqUH7idLk12z6CsPUgx9LGT1PBFS8sdF4DxBwy81m/Wr1l2KndHAqs+oYf9reUVJEW5mNjktA51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+1PovnS+5JHiBMGOC4FiWqgK/Kd5tbgcB/8YS0oMuM=;
 b=dMVDuNngW+2rS94kttXhvry4z76UGYq2LVwGEVd11p1Bc+HvMmMADojyPlbW4g6naenKBPveWjdcuRfn+8CyQW3pvxHlQQqS+Niaj8PJ67BqDiYM0a72ytl962nsXvTKZueypD4T7OHCCNNG7KKektHVhh6oqvhTTA3JkctKijg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB3358.namprd02.prod.outlook.com (2603:10b6:301:66::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 08:57:35 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c4a8:8d45:c13b:9942%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 08:57:35 +0000
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
Thread-Index: AQHW7USLyeY5b3FOfkKTbQUTtVqUFaouGt0AgAVRbYCAAnmHgIAFUX3g
Date:   Wed, 27 Jan 2021 08:57:35 +0000
Message-ID: <MWHPR02MB26231DAF3A8E2A65EF25A4C3C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com> <YAYo1ksLfMMNxPuL@epycbox.lan>
 <MWHPR02MB26239A3F539DE8E053D512D5C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YAyyU9dybSdmOAQL@epycbox.lan>
In-Reply-To: <YAyyU9dybSdmOAQL@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3039446-18c7-46c7-2073-08d8c2a19745
x-ms-traffictypediagnostic: MWHPR02MB3358:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB335862E624C7612D82FF733DC2BB9@MWHPR02MB3358.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPYjjFLZnpRtjmEOSqKoFZyVepr/w2WIeACbMZvDR3iBn6XpDzf+MLDrukiwWiPpqVUDEg5QD9qnge+uHOIWnCe3o7WsWeiGmKbytQHvKEwRRjaeDab9kus0DNs3GCJhIor3NT3cpyDLOVCSj4erJv3ENkWKJan+4+uEZspLAiDaa0jKULFT3iwY180/JZgCFsDxFTN/0UK4cydWbBCiLeJJ2wQVsxv9Iv9YuUaNZBaloHQEXpv2uyI5rnsuP3TaxMShjv36Bxs/tCdBJMu++pjHdNr42lWZ0SnWX26M+B1GgQfJvdhYGHDNYboIsdS4IV/L1SrDHfv4ArPolatv7OLYj1XJNJmRM5goxN/RX5KwfaEZ6DjnpyGKX7CmkF1phDoLfXuQZqZYqF+QqGhhHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(83380400001)(66946007)(66476007)(64756008)(4326008)(66446008)(86362001)(66556008)(107886003)(9686003)(33656002)(52536014)(76116006)(55016002)(186003)(6916009)(5660300002)(71200400001)(8936002)(6506007)(316002)(478600001)(7696005)(54906003)(26005)(53546011)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EvGmlsvLQyGQj8YvZyQ//VZ2Z4mWRwBaugJOXKAsUXOTn8Gx+cFbLpHXUDR4?=
 =?us-ascii?Q?hwUBEw9xfeR1vBwT3va55vNkrNSdtC1tQBiI8bXcrspP1jPM6iFzfRO7eVMG?=
 =?us-ascii?Q?NOYwDynTbCeVBoezMA0Wmd7V1GWMIqSUSdXo1+Jbg4z2BZe+D0lBbX6pGP4z?=
 =?us-ascii?Q?l1/QPjN8S0OYHayfKIpwi83LgHC3CZktpjDE3uskewUL2KwuV8ip3ts1jjWp?=
 =?us-ascii?Q?hCHLmCnh4rT5xKKlimg5TsQdL6mtSipj1TLzpHh22N8zx3NVGdZ0fcBM2d1o?=
 =?us-ascii?Q?f4uL/9yTOr+RZLZKbJS4SlGgnlwNhJgnMheRnseCYc6pXiBor0jlm2/yedqa?=
 =?us-ascii?Q?ahklJ3Ula3+UQZWxMnyGt8Nf1OFqwO5C4ILFeacLNFjJqCJGHQIFeRwtc4A6?=
 =?us-ascii?Q?1oaF1dAC1RX8E2AVktrh9PVHK5LGn6RGN5cBdhpfEILaNA426RuLoJ/7LDV1?=
 =?us-ascii?Q?2tPe+MJ+2AXei6TdnbymV0dgFbh0tMjEOEsSsHEavtlLPxKquBAS3f9ZmhXr?=
 =?us-ascii?Q?rUrp96UVwyoFCqNrqs3qM7nt5uTTnRdjCkrzSM9xtAZsLgRRfVRxGBx6sfRd?=
 =?us-ascii?Q?YjrNXgMTjVaUPuhJv+pBUILZjgI/OSADr6+FaXoeDCUQqd6LPttFwBVMCpZG?=
 =?us-ascii?Q?tmlMrqEOh+OK54JXhOvQ0LDg9Jj45Ku3vDPkGAiMgOxcL80pE+pNbRLqiB/y?=
 =?us-ascii?Q?eblJDOcxNHjJtk/iQeE9aNLssZfXJCJn99+BdpdFPB6dJxe+sjCMUJC6Jhmj?=
 =?us-ascii?Q?Hs06CXQg/gvJBwvx8SuwxhfGFfeDt9NgC3H69iWLAWlCNvsfQbIAOJ0AAbdg?=
 =?us-ascii?Q?uisRXqT0BJp3rw//621IBB0R/SlVhG1uomRx38t+QaWQyjRjkzFScnAfDKIx?=
 =?us-ascii?Q?LtGncpQPk0bTTxXasBybUlzcgzE77bXshHb44gQCrRu5tmliiOEbsL2q7H2g?=
 =?us-ascii?Q?E2c2AcbqRfEmNgplx6CtwFGOAV7+L54TUYLyxk2954Hn53lSr/+1ZLMr3Y8g?=
 =?us-ascii?Q?kpxWO5/JUjN9hfedPAOFuk9Iyk3IO3/5aUDETbvxwW6w3aDsAjXhhkE2Tpi8?=
 =?us-ascii?Q?q0b4Pfsn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3039446-18c7-46c7-2073-08d8c2a19745
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 08:57:35.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtJUM9EGMqDR64kYfTW7T7cG2CYvBs3PkPxrhNzML1WngjyWImUsM1zPMz9V563a9J6teI44DW1MVs4X9EZC5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3358
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

	Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Sunday, January 24, 2021 5:04 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; chinnikishore369@gmail.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>
> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager drive=
r
>=20
> Hi Nava,
>=20
> On Fri, Jan 22, 2021 at 10:34:15AM +0000, Nava kishore Manne wrote:
> > Hi Moritz,
> >
> > 	Thanks for the review.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Moritz Fischer <mdf@kernel.org>
> > > Sent: Tuesday, January 19, 2021 6:03 AM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> > > Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
> > > <appanad@xilinx.com>
> > > Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager
> > > driver
> > >
> > > Hi Nava,
> > >
> > > On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne wrote:
> > > > This patch adds driver for versal fpga manager.
> > > Nit: Add support for Xilinx Versal FPGA manager
> >
> > Will fix in v2.
> >
> > > >
> > > > PDI source type can be DDR, OCM, QSPI flash etc..
> > > No idea what PDI is :)
> >
> > Programmable device image (PDI).
> > This file is generated by Xilinx Vivado tool and it contains configurat=
ion data
> objects.
> >
> > > > But driver allocates memory always from DDR, Since driver supports
> > > > only DDR source type.
> > > >
> > > > Signed-off-by: Appana Durga Kedareswara rao
> > > > <appana.durga.rao@xilinx.com>
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/fpga/Kconfig       |   8 ++
> > > >  drivers/fpga/Makefile      |   1 +
> > > >  drivers/fpga/versal-fpga.c | 149
> > > > +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 158 insertions(+)  create mode 100644
> > > > drivers/fpga/versal-fpga.c
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > > 5645226ca3ce..9f779c3a6739 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> > > >  	  to configure the programmable logic(PL) through PS
> > > >  	  on ZynqMP SoC.
> > > >
> > > > +config FPGA_MGR_VERSAL_FPGA
> > > > +        tristate "Xilinx Versal FPGA"
> > > > +        depends on ARCH_ZYNQMP || COMPILE_TEST
> > > > +        help
> > > > +          Select this option to enable FPGA manager driver support=
 for
> > > > +          Xilinx Versal SOC. This driver uses the versal soc firmw=
are
> > > > +          interface to load programmable logic(PL) images
> > > > +          on versal soc.
> > > >  endif # FPGA
> > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > > d8e21dfc6778..40c9adb6a644 100644
> > > > --- a/drivers/fpga/Makefile
> > > > +++ b/drivers/fpga/Makefile
> > > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+=3D
> > > ts73xx-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+=3D xilinx-spi.o
> > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
> > > > +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      +=3D versal-fpga.o
> > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
> > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-pla=
t.o
> > > >
> > > > diff --git a/drivers/fpga/versal-fpga.c
> > > > b/drivers/fpga/versal-fpga.c new file mode 100644 index
> > > > 000000000000..2a42aa78b182
> > > > --- /dev/null
> > > > +++ b/drivers/fpga/versal-fpga.c
> > > > @@ -0,0 +1,149 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright (C) 2021 Xilinx, Inc.
> > > > + */
> > > > +
> > > > +#include <linux/dma-mapping.h>
> > > > +#include <linux/fpga/fpga-mgr.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/string.h>
> > > > +#include <linux/firmware/xlnx-zynqmp.h>
> > > > +
> > > > +/* Constant Definitions */
> > > > +#define PDI_SOURCE_TYPE	0xF
> > > > +
> > > > +/**
> > > > + * struct versal_fpga_priv - Private data structure
> > > > + * @dev:	Device data structure
> > > > + * @flags:	flags which is used to identify the PL Image type
> > > > + */
> > > > +struct versal_fpga_priv {
> > > > +	struct device *dev;
> > > > +	u32 flags;
> > > This seems unused ... please introduce them when/if you start using
> them.
> >
> > Will fix in v2.
> >
> > > > +};
> > > > +
> > > > +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> > > > +				      struct fpga_image_info *info,
> > > > +				      const char *buf, size_t size) {
> > > > +	struct versal_fpga_priv *priv;
> > > > +
> > > > +	priv =3D mgr->priv;
> > > > +	priv->flags =3D info->flags;
> > > ? What uses this ? It seems this function could just be 'return 0' ri=
ght now.
> >
> > Will fix in v2.
> >
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> > > > +				 const char *buf, size_t size) {
> > > > +	struct versal_fpga_priv *priv;
> > > > +	dma_addr_t dma_addr =3D 0;
> > > > +	char *kbuf;
> > > > +	int ret;
> > > > +
> > > > +	priv =3D mgr->priv;
> > > > +
> > > > +	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> > > GFP_KERNEL);
> > > > +	if (!kbuf)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	memcpy(kbuf, buf, size);
> > > > +
> > > > +	wmb(); /* ensure all writes are done before initiate FW call */
> > > > +
> > > > +	ret =3D zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
> > > > +
> > > > +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int versal_fpga_ops_write_complete(struct fpga_manager *mgr=
,
> > > > +					  struct fpga_image_info *info) {
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static enum fpga_mgr_states versal_fpga_ops_state(struct
> > > > +fpga_manager
> > > > +*mgr) {
> > > > +	return FPGA_MGR_STATE_OPERATING;
> > > Is that always the case? Shouldn't that be
> FPGA_MGR_STATE_UNKNOWN?
> >
> > For Versal SoC base PDI is always configured prior to Linux boot up. So=
 I
> make the fpga state as OPERATING.
> > Please let know if it is not a proper implementation will think about t=
he
> alternate solution.
>=20
> So you're saying I can't boot a Versal SoC without a PDI / Bitstream load=
ed?
> Interesting :)
> >

For Versal SoC Vivado generated base PDI is always needed to bring-up the b=
oard.=20

Regards,
Navakishore.


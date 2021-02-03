Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674E730D64B
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Feb 2021 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhBCJ2r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 04:28:47 -0500
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85]:38975
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233511AbhBCJ1n (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 04:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPa5WXZR5YfjtFSTxDlxvbbe1WaSnyeQ8Bc1h+Fn4CEEvSF4CcNxC0eU+Ce8qIT+1Dn81VUN9Xx61deaGBeoYinqyXZrxw9FVc4OBxVvaYATvgzBHJOASDCPLWLHlaWQy0eQrGc2wUN2keNTaf02+g1WwMk36wVkr4SrP4mV7bWvN0niijr1klKG2ISUCw52EFbwERtyKnMTOu8EIF4OuRBB7u8qUBguxXzG/TFUHgBUoU22HMELKXsXMbq/5B2NogvSoxpA9D2DRN1EjHHmS25hEvB0El1/IvDyPgfJpJSyEP0FrBQhDOMABR+a4QYPu0chWo7nK8lMpZd1Gv7Z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dum0a+rVcDTRogtoXclxld+SZk9fmljeUVAwblaqh9g=;
 b=VZo2NgSlrF8W1qPcvZxWuFNEqCmVUcM/SKMAyEovRZ+s+vq+K+g+OaISpJK0vxSAwZZKoddW4giMxUnB8NPwcZ/gfG05T6trRmG5yrgVWkK1OSeOPO0J0uon5YZRTjT/HMe6FbJIYeJxq17IGUSsc3otDsTmdGJItwvipQaAS/JcZkKd7aMpBzgyFVTigSHsfR4PgVslKwUdj9kHMa+Un322b9QKFp2/TYbjfsLuMAnMdGk4M+PjNHVqOTT7VRLPqlZzL8ZNHxyDNNTyttD7u2D+Zt+DLfzvy+7aQC5ivE7W/hdc5+E3Y7UaWGYyYV4KHmjmwgjSuJeRI261+lHeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dum0a+rVcDTRogtoXclxld+SZk9fmljeUVAwblaqh9g=;
 b=ay9h9Aw8+grTSlm3ut6vg5vjm/sFH/fxo8ob2sB/RCGKCw/edcQZuT49dcmAZqjDEzGq8of3XrgXV8p3v6RzC7fUt23498re+3Aj84zcn0doYIfuAB3q4OrbIun6IqrS0sU3kBxqS/xlfWBYtniRjkMSJUeoAT7nMt1jfUk95iw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by CO6PR02MB7540.namprd02.prod.outlook.com (2603:10b6:303:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 09:26:47 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::804d:5b7:ada6:2f4]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::804d:5b7:ada6:2f4%2]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 09:26:46 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>, Michal Simek <michals@xilinx.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Thread-Index: AQHW7USLyeY5b3FOfkKTbQUTtVqUFaouGt0AgAVRbYCAAnmHgIAFUX3ggAAIXQCAANEDgIAKLgJQ
Date:   Wed, 3 Feb 2021 09:26:46 +0000
Message-ID: <MWHPR02MB2623CCE3D5BD30E0EF3E5BA6C2B49@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
 <20210118024318.9530-3-nava.manne@xilinx.com> <YAYo1ksLfMMNxPuL@epycbox.lan>
 <MWHPR02MB26239A3F539DE8E053D512D5C2A09@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YAyyU9dybSdmOAQL@epycbox.lan>
 <MWHPR02MB26231DAF3A8E2A65EF25A4C3C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <5ae6d181-3258-a877-23c5-6ba81c40b10a@xilinx.com>
 <YBHexYg/Bw1U7LQm@epycbox.lan>
In-Reply-To: <YBHexYg/Bw1U7LQm@epycbox.lan>
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
x-ms-office365-filtering-correlation-id: f29d4c19-9a7a-411c-8b2c-08d8c825d411
x-ms-traffictypediagnostic: CO6PR02MB7540:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR02MB75400100B5668EFFC71361E0C2B49@CO6PR02MB7540.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8j7Rp0aigI0VXBBISo+QAqm49S2k3ZjZEPTQNn2MIuWAIRwv3QbL63M0bEsl9JF1zu78KpizhASZgOQZGMwRJ+kjGF4supWdqhfLrKjKZo3rUAhyLzO3oZnzRtpFiWT9l4zjnWRAAFq0FcFNussDDyAzQ+P7J8Aecyjn6Q8NfNiV+QoBlrIOPWKtTiIqow5YNKeMEqdQjMXSHkkbHeWlgU94Mu0kKwV9t98ElvaHXLaNctBdgudkqNpMSw4U0etQ3uJXOeVwOFFVlFOokTfn7xbiD1bS35ylXdPPPWulLV5iv4wF4Uxd08AKC/aMJFW3EgiaJFG+R9rR8dF6Lx+bQfKleEDGpuuqyriUjgiVp9euxVod4F/LDJknG17KvirkD+O003X3ztwOHtrOw79H102UnxDJT38Ikf0SqEXTYS8+iM4bCQDh8McmuAk6yauRZOmejTNUpnNwI+wBiMiob1TY6pSERV+mDJNerCimJz4X4B2FtKB1miHS9suNPrzm6ToT3HgSs/QHaoA7qXkmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(86362001)(8936002)(2906002)(107886003)(4326008)(6636002)(9686003)(66446008)(55016002)(5660300002)(6506007)(186003)(26005)(33656002)(52536014)(66476007)(316002)(66556008)(76116006)(7696005)(54906003)(8676002)(478600001)(110136005)(64756008)(66946007)(53546011)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2FWlettT1SgKNEHwCaTPXa+7snFWm1vB1hu1d5SiFFMNG9pKUC/596ljvqQG?=
 =?us-ascii?Q?JHhzsMLxN7Ay1Z2JH1wLsHvmH4pCN2gkkpJ1dLQZHyaL8JaIFdRM8FJ0z8j/?=
 =?us-ascii?Q?nCDBW4QuIeckWO4kONQlSdPLAK76loPKkTMRDcKO2oBviXTwx+uj9yOcpdG8?=
 =?us-ascii?Q?8IE4BuCTheI7yxS1xksuiQ63DjizHThy0Sh+SwVx1qslIF0nBEOavOYjHO78?=
 =?us-ascii?Q?LP1oyn3aDbvKXvnbZwye7RWlhgo9DC5MEiNnfeoMzmoyA9o2AgkSHhjJqgw1?=
 =?us-ascii?Q?YtBAe+FduPwUge85QjXCce13n+r6TOXE7RNJpXdilKx7RlVXRsQxk2hEi39g?=
 =?us-ascii?Q?xTI4C2ZTp+pF5XQliE0mbioyzsa0dGvi/mnga0Vy056GJaARccTGDoM++72l?=
 =?us-ascii?Q?JpdXuxNmBlfhJddbi1g3FTRJ7FYlOBsPZjMRILhD/icq9yOUGjK8Nm+pECBN?=
 =?us-ascii?Q?MwmN5e4Mm6emEFIFXk7zxqNvgTC9a2n4OwOC6+KDrwJntcRfbAhO/7HGaCaf?=
 =?us-ascii?Q?9KDgJRIdSgkENomYe1tuRpNWpXkfi/q+V+a9/OH8mW3r9y/jGsoMUnsQBr5C?=
 =?us-ascii?Q?82jZBXdcsLCDEdR45SqxdvB4loZwknCFpSygYYeFMJZ1u+yGXRK9AV5tKgwP?=
 =?us-ascii?Q?x7iSfyPYy7UEP2l+pW8x1trSTjSeqIjPKDjADPlwvhncDo8GtMEBafOy6AZO?=
 =?us-ascii?Q?mWV62cpl5zlJk49NRYXpNnKz3NlKwIGfQgCrZSd8OjiWL9GZVSacy5NKgfCU?=
 =?us-ascii?Q?twEFwhufIF3PUUd709N1jUibYtc7jbR80ZlwxqTc/uiIrKfrvmKEYlq8Pfkt?=
 =?us-ascii?Q?GGu45qTYn5FCosR/CMWGEDkacgIiLiom2rpAnKorGIsjwl2X6f01/9eh9fuW?=
 =?us-ascii?Q?+8woZ55CKgfwVs22p9fjEh1c481wRQHa5t8erVOqMk52D2YVwZCnyqlVL9pV?=
 =?us-ascii?Q?ial6KRC/LnljQvfpH7qvDWFiM+LXkc1T5AhcX3ftYMZTYLpqh+O0IrewvHeX?=
 =?us-ascii?Q?pLXDA2TQp8/tQLL2P02lkdZZJZOgqNpft+cMPa6eE+//7yO5trlqhEJeGV7S?=
 =?us-ascii?Q?n+oUex5roG2Ikw2HiMxyQab8m8nwK+xidED8HFqRrcJmJOioVWDX09aAvIhN?=
 =?us-ascii?Q?Dym8hrLASVhvg5/Zo2Ofa1PRzxd6tdtpaPDb+JvrNwf2mZp5YaiAgah7QVZ6?=
 =?us-ascii?Q?MDM1b8NFa+4jRHZGEzT0hlx1lbs24TU9Oy3pIA83RhgFGrBQEcrrZf9Rz2m9?=
 =?us-ascii?Q?gT/OCf1m1SPWxk9dEPNZhDvtuujSWhzWpQIlXiWj+fvN7NzYT9HQjRml8V0T?=
 =?us-ascii?Q?8JQvdCYV8lmeJxQUeOXXNynU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29d4c19-9a7a-411c-8b2c-08d8c825d411
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 09:26:46.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lmW/QU3XA2yCAq9qZh4CRMqlcV94nFndZzzwS+PG99EmOWJkUamsAjIHQccqyzSQJ9VLehqTlem1yFDbnk5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7540
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Thursday, January 28, 2021 3:15 AM
> To: Michal Simek <michals@xilinx.com>
> Cc: Nava kishore Manne <navam@xilinx.com>; Moritz Fischer
> <mdf@kernel.org>; trix@redhat.com; robh+dt@kernel.org; linux-
> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; chinnikishore369@gmail.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>
> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager drive=
r
>=20
> On Wed, Jan 27, 2021 at 10:16:32AM +0100, Michal Simek wrote:
> > Hi
> >
> > On 1/27/21 9:57 AM, Nava kishore Manne wrote:
> > > Hi Moritz,
> > >
> > > 	Please find my response inline.
> > >
> > >> -----Original Message-----
> > >> From: Moritz Fischer <mdf@kernel.org>
> > >> Sent: Sunday, January 24, 2021 5:04 AM
> > >> To: Nava kishore Manne <navam@xilinx.com>
> > >> Cc: Moritz Fischer <mdf@kernel.org>; trix@redhat.com;
> > >> robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; linux-
> > >> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > >> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> > >> <git@xilinx.com>; chinnikishore369@gmail.com; Appana Durga
> > >> Kedareswara Rao <appanad@xilinx.com>
> > >> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager
> > >> driver
> > >>
> > >> Hi Nava,
> > >>
> > >> On Fri, Jan 22, 2021 at 10:34:15AM +0000, Nava kishore Manne wrote:
> > >>> Hi Moritz,
> > >>>
> > >>> 	Thanks for the review.
> > >>> Please find my response inline.
> > >>>
> > >>>> -----Original Message-----
> > >>>> From: Moritz Fischer <mdf@kernel.org>
> > >>>> Sent: Tuesday, January 19, 2021 6:03 AM
> > >>>> To: Nava kishore Manne <navam@xilinx.com>
> > >>>> Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal
> > >>>> Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > >>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > >>>> linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > >>>> chinnikishore369@gmail.com; Appana Durga Kedareswara Rao
> > >>>> <appanad@xilinx.com>
> > >>>> Subject: Re: [PATCH 3/3] fpga: versal-fpga: Add versal fpga
> > >>>> manager driver
> > >>>>
> > >>>> Hi Nava,
> > >>>>
> > >>>> On Mon, Jan 18, 2021 at 08:13:18AM +0530, Nava kishore Manne
> wrote:
> > >>>>> This patch adds driver for versal fpga manager.
> > >>>> Nit: Add support for Xilinx Versal FPGA manager
> > >>>
> > >>> Will fix in v2.
> > >>>
> > >>>>>
> > >>>>> PDI source type can be DDR, OCM, QSPI flash etc..
> > >>>> No idea what PDI is :)
> > >>>
> > >>> Programmable device image (PDI).
> > >>> This file is generated by Xilinx Vivado tool and it contains
> > >>> configuration data
> > >> objects.
> > >>>
> > >>>>> But driver allocates memory always from DDR, Since driver
> > >>>>> supports only DDR source type.
> > >>>>>
> > >>>>> Signed-off-by: Appana Durga Kedareswara rao
> > >>>>> <appana.durga.rao@xilinx.com>
> > >>>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > >>>>> ---
> > >>>>>  drivers/fpga/Kconfig       |   8 ++
> > >>>>>  drivers/fpga/Makefile      |   1 +
> > >>>>>  drivers/fpga/versal-fpga.c | 149
> > >>>>> +++++++++++++++++++++++++++++++++++++
> > >>>>>  3 files changed, 158 insertions(+)  create mode 100644
> > >>>>> drivers/fpga/versal-fpga.c
> > >>>>>
> > >>>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > >>>>> 5645226ca3ce..9f779c3a6739 100644
> > >>>>> --- a/drivers/fpga/Kconfig
> > >>>>> +++ b/drivers/fpga/Kconfig
> > >>>>> @@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
> > >>>>>  	  to configure the programmable logic(PL) through PS
> > >>>>>  	  on ZynqMP SoC.
> > >>>>>
> > >>>>> +config FPGA_MGR_VERSAL_FPGA
> > >>>>> +        tristate "Xilinx Versal FPGA"
> > >>>>> +        depends on ARCH_ZYNQMP || COMPILE_TEST
> > >>>>> +        help
> > >>>>> +          Select this option to enable FPGA manager driver suppo=
rt for
> > >>>>> +          Xilinx Versal SOC. This driver uses the versal soc fir=
mware
> > >>>>> +          interface to load programmable logic(PL) images
> > >>>>> +          on versal soc.
> > >>>>>  endif # FPGA
> > >>>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > >>>>> d8e21dfc6778..40c9adb6a644 100644
> > >>>>> --- a/drivers/fpga/Makefile
> > >>>>> +++ b/drivers/fpga/Makefile
> > >>>>> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)
> 	+=3D
> > >>>> ts73xx-fpga.o
> > >>>>>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+=3D xilinx-spi.o
> > >>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
> > >>>>>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
> > >>>>> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      +=3D versal-fpga.o
> > >>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
> > >>>>>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-
> plat.o
> > >>>>>
> > >>>>> diff --git a/drivers/fpga/versal-fpga.c
> > >>>>> b/drivers/fpga/versal-fpga.c new file mode 100644 index
> > >>>>> 000000000000..2a42aa78b182
> > >>>>> --- /dev/null
> > >>>>> +++ b/drivers/fpga/versal-fpga.c
> > >>>>> @@ -0,0 +1,149 @@
> > >>>>> +// SPDX-License-Identifier: GPL-2.0+
> > >>>>> +/*
> > >>>>> + * Copyright (C) 2021 Xilinx, Inc.
> > >>>>> + */
> > >>>>> +
> > >>>>> +#include <linux/dma-mapping.h>
> > >>>>> +#include <linux/fpga/fpga-mgr.h> #include <linux/io.h> #include
> > >>>>> +<linux/kernel.h> #include <linux/module.h> #include
> > >>>>> +<linux/of_address.h> #include <linux/string.h> #include
> > >>>>> +<linux/firmware/xlnx-zynqmp.h>
> > >>>>> +
> > >>>>> +/* Constant Definitions */
> > >>>>> +#define PDI_SOURCE_TYPE	0xF
> > >>>>> +
> > >>>>> +/**
> > >>>>> + * struct versal_fpga_priv - Private data structure
> > >>>>> + * @dev:	Device data structure
> > >>>>> + * @flags:	flags which is used to identify the PL Image type
> > >>>>> + */
> > >>>>> +struct versal_fpga_priv {
> > >>>>> +	struct device *dev;
> > >>>>> +	u32 flags;
> > >>>> This seems unused ... please introduce them when/if you start
> > >>>> using
> > >> them.
> > >>>
> > >>> Will fix in v2.
> > >>>
> > >>>>> +};
> > >>>>> +
> > >>>>> +static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
> > >>>>> +				      struct fpga_image_info *info,
> > >>>>> +				      const char *buf, size_t size) {
> > >>>>> +	struct versal_fpga_priv *priv;
> > >>>>> +
> > >>>>> +	priv =3D mgr->priv;
> > >>>>> +	priv->flags =3D info->flags;
> > >>>> ? What uses this ? It seems this function could just be 'return 0'=
 right
> now.
> > >>>
> > >>> Will fix in v2.
> > >>>
> > >>>>> +
> > >>>>> +	return 0;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static int versal_fpga_ops_write(struct fpga_manager *mgr,
> > >>>>> +				 const char *buf, size_t size) {
> > >>>>> +	struct versal_fpga_priv *priv;
> > >>>>> +	dma_addr_t dma_addr =3D 0;
> > >>>>> +	char *kbuf;
> > >>>>> +	int ret;
> > >>>>> +
> > >>>>> +	priv =3D mgr->priv;
> > >>>>> +
> > >>>>> +	kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> > >>>> GFP_KERNEL);
> > >>>>> +	if (!kbuf)
> > >>>>> +		return -ENOMEM;
> > >>>>> +
> > >>>>> +	memcpy(kbuf, buf, size);
> > >>>>> +
> > >>>>> +	wmb(); /* ensure all writes are done before initiate FW call
> > >>>>> +*/
> > >>>>> +
> > >>>>> +	ret =3D zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
> > >>>>> +
> > >>>>> +	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
> > >>>>> +
> > >>>>> +	return ret;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static int versal_fpga_ops_write_complete(struct fpga_manager
> *mgr,
> > >>>>> +					  struct fpga_image_info
> *info) {
> > >>>>> +	return 0;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static enum fpga_mgr_states versal_fpga_ops_state(struct
> > >>>>> +fpga_manager
> > >>>>> +*mgr) {
> > >>>>> +	return FPGA_MGR_STATE_OPERATING;
> > >>>> Is that always the case? Shouldn't that be
> > >> FPGA_MGR_STATE_UNKNOWN?
> > >>>
> > >>> For Versal SoC base PDI is always configured prior to Linux boot
> > >>> up. So I
> > >> make the fpga state as OPERATING.
> > >>> Please let know if it is not a proper implementation will think
> > >>> about the
> > >> alternate solution.
> > >>
> > >> So you're saying I can't boot a Versal SoC without a PDI / Bitstream
> loaded?
> > >> Interesting :)
> > >>>
> > >
> > > For Versal SoC Vivado generated base PDI is always needed to bring-up
> the board.
> >
> > Look at PDI as ps7_init/psu_init file but in different format. And
> > bitstream is optional part of it (like a one partition).
>=20
> So at that point I could still have no bitstream loaded (optional), and m=
y
> status would be 'unknown' not 'operating' if I cannot tell the two cases =
apart.
> What am I missing? :)
>=20

Agree, In few cases Bitstream partition is optional, So we can't say exactl=
y whether the PL is having Bitstream or Not . So here the ideal default PL =
state should be Unknown.
Will fix in v2.

Regards,
Navakishore.

=20

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40D932747E
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Feb 2021 21:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhB1Uxq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Feb 2021 15:53:46 -0500
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:32577
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231230AbhB1Uxo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Feb 2021 15:53:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0J/nbjwrkN60Irxhpu4CaXfNGxhjUQ6frESxzUh0jkl+of0pL6SbUrje/mzUGGoY0pO9LMkswZ1rk8YtTnpJNIC+MS6NckmURkCmtTL65xtof6K3F1re1MJFvJgYDbXAPt9bv4VQP6Mdilym28inFY/cWZ1nZmby92lSu2K+0hYbgHRAQABn9Tj4pqE4f6jzSWxq5A327HZd8sxsac/BTGuzVd1ssSZ8p//QF1KlX6qKoUR/cClbopaaXlJvC1oKxw8FFsL4dRzbHaeqphD+blOtEyHWVTtd9CzwqwkmBexo6fyil2kok5B5JYrpa+d3lMGNoV6TZVmgOED+t062A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdnx1fiMzjfnBD9uiLfBC6zx8S3+gFlrfvCIGF3grP0=;
 b=fPZyDG25vPCB4FrZ/zWFuEOJZiV1+m3wIxlYPZ03d5d5cfWYBnDEYoN2/WXP6TNP+t3uW3goXz68vU7bf5z8ISpZmRLf8C6UF41RBuwfPoNMC521jXkIoRphDsE1zqZ+N7NviTAvlN1qpeLWzCzQAX6rQVI4bgwgClcieDcjZZH3JpPzc01eLIESCd6Y4vCYhXvZsec3u/NuzGi+g6gOQCYs/UxjEfwk2NHenfby2wv8HbMZub75ZQN5IjW4xwXddbbdTNMF4ubfIMMuoR3fnZsV2dQjY4sVSDvWe2dvZ7L23MSjlNH3RGfS9S0RvXUFsg18k6Wx23koqqEbYEZNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdnx1fiMzjfnBD9uiLfBC6zx8S3+gFlrfvCIGF3grP0=;
 b=NuGnZbsVJBKzCTX4GZ0sNJRw7CeIxKs5E7OPUH+zzGtQcyDBGXwvvULIEHqAvLehO+WGQKJe6y55bsS2qRcFKayRR5LZTVSYA/NWudworq70oSFCtmCAC0UTWl+7VYa9M51qsT+42Nfv1T0QVvY0FinNbu/fXqOvoUG3DU2LgQI=
Received: from BY5PR02MB6260.namprd02.prod.outlook.com (2603:10b6:a03:1b0::29)
 by BYAPR02MB5349.namprd02.prod.outlook.com (2603:10b6:a03:67::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sun, 28 Feb
 2021 20:52:48 +0000
Received: from BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::d8a:e9ce:7970:c07f]) by BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::d8a:e9ce:7970:c07f%4]) with mapi id 15.20.3890.028; Sun, 28 Feb 2021
 20:52:48 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
CC:     Lizhi Hou <lizhih@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, Max Zhen <maxz@xilinx.com>
Subject: RE: [PATCH V3 XRT Alveo 18/18] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
Thread-Topic: [PATCH V3 XRT Alveo 18/18] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
Thread-Index: AQHXBcHU/FUH/Q/oVEmgYGrsJlYPbKpiuD6AgAA+EQCACyOsIA==
Date:   Sun, 28 Feb 2021 20:52:48 +0000
Message-ID: <BY5PR02MB6260BE31657E33792A88260EBB9B9@BY5PR02MB6260.namprd02.prod.outlook.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-19-lizhih@xilinx.com>
 <287d9c6b-1b2b-f62d-ff8a-ad57b01f58a6@redhat.com>
 <YDKo7KiLm9ajkC67@epycbox.lan>
In-Reply-To: <YDKo7KiLm9ajkC67@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 631a16bd-39b1-4fb7-e110-08d8dc2aceae
x-ms-traffictypediagnostic: BYAPR02MB5349:
x-ms-exchange-minimumurldomainage: github.com#4891
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5349679D1AFBB4152B6A2DFBBB9B9@BYAPR02MB5349.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6M9abPDcUK7EIWpy/2Wl5aYAqXuywfMSofsnyO7Qq+FJ1wUD6Ycjde92ghNv1RM1RYtmy/BQEu8kKhHEz8J+9HIUlkkN8rtQ/UDuaJGBVIYwrM1H8POnw0Rq/8QEJA9u2JgBZD24uNCjQ5GS3IB/i5nRb0SvIxvNimPkSOR2d2dExU113OQbIiXX34ZoIswh3huryDOPLmcth8/NTzsvOjHA7q1RLC+QWhHLC4220d8QRacWLtyrwQ5P/FbBXWan2TeTex/wPYpHZ7vc4QksTJAx2oCaY+bNRjlbZ/c9yAVAWxmPD6D2yxmxX01Vb7Wa7uuDfXH1/FmrcHcYjB+RJZpUMI0JBC5tX+V55lKqC4vCwvL6ZVYyS+sUoil3Fb1oHBfHlEPCve/hAc8kEW/P8UaavLwp+UBHvCiVWxCfWyv5dF3u91YfhNFZXZuwPn7jhHG1Od+sPK+r+iBuRAX87Q9HMNwah6njuAECTBGTZQ6FEcVTpsX1dK8txbcm5gZpc/cO1NpV/3ErMgpg4J6EaVYwdn+qVRU06DBeiKKGYA4eu/jq/B7MtLiVVZRcb4XqxTMZrv+BCX7CmNiAVFTb0bqCnPrMF4IfzxrYP/WiBmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6260.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(366004)(83380400001)(186003)(316002)(71200400001)(55016002)(2906002)(7696005)(86362001)(33656002)(110136005)(54906003)(52536014)(30864003)(8936002)(66556008)(5660300002)(66946007)(9686003)(53546011)(76116006)(478600001)(4326008)(64756008)(8676002)(66446008)(107886003)(15650500001)(26005)(6506007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ZmfdDRHQD5laBI6Y4DrmLRYvISOhirb9U2tWhoU6tDJv1+y5+yIlTljx47?=
 =?iso-8859-1?Q?zRAfJ30fDog+2LbCk278CKEHxoFodH+xyccgyKYffa97RiuQBbgalVmpNF?=
 =?iso-8859-1?Q?d1ANbL8vWt2u8CeDGcsacob56LUj/6bYjkUmB6xsgJ7Aor/H8uar09E8TT?=
 =?iso-8859-1?Q?iLFcDkZfqr0OhBx836So7SRHI6xVVp+uJX4Ak+b708rHNI6JJrMfmf18KG?=
 =?iso-8859-1?Q?H0qm6EeD0GQTo1QAsxykHgDzr9BQCePpDYf+rtzQqi3ML/bRBpGdZRznRO?=
 =?iso-8859-1?Q?5yQhF44bhRG3QvFeOgYi4TNo1I/SObst8TXjYt49CrqrF6mZn4VGTWQJP7?=
 =?iso-8859-1?Q?H74IS6jrVIi2DZnPRIrE+t1Txzd0vLqsnsOOnGgrNOdidxw8Mh4nEdUIqT?=
 =?iso-8859-1?Q?ooUs8clprl5lhNOXK/hEnGhmZCioDNTLUsvw26b7AXRYKv2pKDlD6YP/aq?=
 =?iso-8859-1?Q?gk3GYJAwkxWNsgvDEEbEMmIHFyLizUZHGw7xWu9Pa++gT8FAkrEnddV7jo?=
 =?iso-8859-1?Q?+z5+G8sz2OX2YJd340QgPpz/My0yFMCQlMTzvg/UR6GYVxlqhO3pMeTJb4?=
 =?iso-8859-1?Q?Fe9FybYkFh9GY+wnn3q95pf7MjtwByi5G2j/QJWhGFgLKhCNgPRTguZsfl?=
 =?iso-8859-1?Q?S1YSyW/7GmNi1NCeuQKSICBkxoZ0R0+Cg2XIPFPIZ1BhB5DDdYvPZ6sZKO?=
 =?iso-8859-1?Q?UMTXrCmwG5k/+d8ph9dV8e/aOmkswirj9w32mx8FXG2EDDfg1mZKJ7XDNv?=
 =?iso-8859-1?Q?6+fn7HRG3OMeku2reerO8K1rgPuPpZ6XYFkL81EzQwH6LwjtdFHVmjPNDh?=
 =?iso-8859-1?Q?pbKaE8b3cm2RR3tMplrPevacUrGf/ycg/8mqCICe7xb1oBfwwypImzvATF?=
 =?iso-8859-1?Q?iGHtw8QOGbT8sa7fZCDqAkl7eLlDVVlBfvMGglOjNxRI/bnNowVXbKx4xC?=
 =?iso-8859-1?Q?3+QGuGRqeeh1OyruElnKFa7KlhGMxTW1LA4qGPx1NDe+Lt9h3sfLxBvp8M?=
 =?iso-8859-1?Q?32EfO8jFoi/+qXaVbTio8u4bNXH5HXP6c0Qa2fF2HOHF6OgfCY/EGZXVYw?=
 =?iso-8859-1?Q?PqVzz3JtkIDHVpy++3pqTmfzCURp9E/4Vj62LjucCIGf0JRp5jfAjL3LQ/?=
 =?iso-8859-1?Q?5blYN3reN7daEPdAbmTmCGAmG0qn+vxTvPg2LblZZOQpajaROSsXHZkkUs?=
 =?iso-8859-1?Q?/khL2g4sEGoOhdrz0k6LrQwnXCtkepIEcuwY1Of0oTdhO0gC1kUv5dmnFb?=
 =?iso-8859-1?Q?zbVcXHShIWcWRO8S6tz1CVx8OyjyO+pwyTRW8bN1pf7EWueyyhIPSIhttH?=
 =?iso-8859-1?Q?EOJFEQ3OMLFZAoWNuxodrmjoUIlwFE4saH2Ve0cnB9XygvbRrMxTrGoIGk?=
 =?iso-8859-1?Q?Rl5hJ27ZGM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6260.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631a16bd-39b1-4fb7-e110-08d8dc2aceae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 20:52:48.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPcy5D7ffcod1DI/f1MHNCC6hxQRhq6dIKvW8q51OenoD0z7QLxMVMwu0lx9TskTw0B03BFjv8Orqz43QAfQtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5349
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Moritz,

> -----Original Message-----
> From: Moritz Fischer <mdf@kernel.org>
> Sent: Sunday, February 21, 2021 10:40 AM
> To: Tom Rix <trix@redhat.com>
> Cc: Lizhi Hou <lizhih@xilinx.com>; linux-kernel@vger.kernel.org;
> mdf@kernel.org; Lizhi Hou <lizhih@xilinx.com>; linux-fpga@vger.kernel.org=
;
> Max Zhen <maxz@xilinx.com>; Sonal Santan <sonals@xilinx.com>; Michal
> Simek <michals@xilinx.com>; Stefano Stabellini <stefanos@xilinx.com>;
> devicetree@vger.kernel.org; robh@kernel.org; Max Zhen <maxz@xilinx.com>
> Subject: Re: [PATCH V3 XRT Alveo 18/18] fpga: xrt: Kconfig and Makefile
> updates for XRT drivers
>=20
> On Sun, Feb 21, 2021 at 06:57:31AM -0800, Tom Rix wrote:
> > As I am looking through the files, I have this comment.
> >
> > fpga/ is currently a single directory, while files could be organized
> > in subdirectories like
> >
> > dfl/pci.c
> >
> > instead have the possible subdir name as a prefix to the filename.
> >
> > dfl-pci.c
> >
> > For consistency,
> >
> > xrt/metadata/metadata.c
> >
> > should be
> >
> > xrt-metadata.c
>=20
> Agreed. Keep the prefix.
> >
> > Likewise the build infra needs to integrated within the existing files
> > fpga/Kconfig,Makefile
> >
> > This is a bigish refactor, so let's get a second opinion.
>=20
> In what sense? You mean adding a subdirectory? Maybe something like this
>=20
> drivers/fpga
>   - dfl/
>   - xilinx/
>   - intel/
>   - lattice/
>   - xrt/
>   ...
>=20
> would generally make sense.
>=20
> We didn't have enough drivers to prioritize that yet, but we can look int=
o it.

If longer term we would like to reorganize the drivers/fpga directory struc=
ture=20
should we keep the current directory structure for XRT as in the patch seri=
es?

> >
> > Moritz ?
> >
> > On 2/17/21 10:40 PM, Lizhi Hou wrote:
> > > Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers=
.
> > Expand the comment, there are several new configs that could use an
> > explanation
> > >
> > > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > > Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> > > ---
> > >  MAINTAINERS                        | 11 +++++++++++
> > >  drivers/Makefile                   |  1 +
> > >  drivers/fpga/Kconfig               |  2 ++
> > >  drivers/fpga/Makefile              |  4 ++++
> > >  drivers/fpga/xrt/Kconfig           |  8 ++++++++
> > >  drivers/fpga/xrt/lib/Kconfig       | 16 ++++++++++++++++
> > >  drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++=
++
> > >  drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
> > > drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
> > >  drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
> > >  drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
> > >  11 files changed, 134 insertions(+)  create mode 100644
> > > drivers/fpga/xrt/Kconfig  create mode 100644
> > > drivers/fpga/xrt/lib/Kconfig  create mode 100644
> > > drivers/fpga/xrt/lib/Makefile  create mode 100644
> > > drivers/fpga/xrt/metadata/Kconfig  create mode 100644
> > > drivers/fpga/xrt/metadata/Makefile
> > >  create mode 100644 drivers/fpga/xrt/mgmt/Kconfig  create mode
> > > 100644 drivers/fpga/xrt/mgmt/Makefile
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > d3e847f7f3dc..e6e147c2454c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6973,6 +6973,17 @@ F:	Documentation/fpga/
> > >  F:	drivers/fpga/
> > >  F:	include/linux/fpga/
> > >
> > > +FPGA XRT DRIVERS
> > > +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> > > +R:	Max Zhen <max.zhen@xilinx.com>
> > > +R:	Sonal Santan <sonal.santan@xilinx.com>
> > > +L:	linux-fpga@vger.kernel.org
> > > +S:	Maintained
> > > +W:	https://github.com/Xilinx/XRT
> > > +F:	Documentation/fpga/xrt.rst
> > > +F:	drivers/fpga/xrt/
> > > +F:	include/uapi/linux/xrt/
> > > +
> > >  FPU EMULATOR
> > >  M:	Bill Metzenthen <billm@melbpc.org.au>
> > >  S:	Maintained
> > > diff --git a/drivers/Makefile b/drivers/Makefile index
> > > fd11b9ac4cc3..e03912af8e48 100644
> > > --- a/drivers/Makefile
> > > +++ b/drivers/Makefile
> > > @@ -178,6 +178,7 @@ obj-$(CONFIG_STM)		+=3D hwtracing/stm/
> > >  obj-$(CONFIG_ANDROID)		+=3D android/
> > >  obj-$(CONFIG_NVMEM)		+=3D nvmem/
> > >  obj-$(CONFIG_FPGA)		+=3D fpga/
> > > +obj-y				+=3D fpga/xrt/metadata/
> >
> > This is wrong.
> >
> > Move metadata building to fpga/ Makefile and pick an appropriate config=
,
> not just 'obj-y'

Will update.

> >
> > >  obj-$(CONFIG_FSI)		+=3D fsi/
> > >  obj-$(CONFIG_TEE)		+=3D tee/
> > >  obj-$(CONFIG_MULTIPLEXER)	+=3D mux/
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > 5645226ca3ce..aeca635b1f25 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -216,4 +216,6 @@ config FPGA_MGR_ZYNQMP_FPGA
> > >  	  to configure the programmable logic(PL) through PS
> > >  	  on ZynqMP SoC.
> > >
> > > +source "drivers/fpga/xrt/Kconfig"
> > > +
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > d8e21dfc6778..2b4453ff7c52 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -46,3 +46,7 @@ dfl-afu-objs +=3D dfl-afu-error.o
> > >
> > >  # Drivers for FPGAs which implement DFL
> > >  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> > > +
> > > +# XRT drivers for Alveo
> > > +obj-$(CONFIG_FPGA_XRT_LIB)		+=3D xrt/lib/
> > > +obj-$(CONFIG_FPGA_XRT_XMGMT)		+=3D xrt/mgmt/
> >
> > I don't see how mgmnt would work without lib.=A0 If that is so
> >
> > these configs could collapse to CONFIG_FPGA_XRT
> >
> > > diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig new
> > > file mode 100644 index 000000000000..0e2c59589ddd
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/Kconfig
> > > @@ -0,0 +1,8 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only # # Xilinx Alveo FPGA
> > > +device configuration #
> > > +
> > > +source "drivers/fpga/xrt/metadata/Kconfig"
> > > +source "drivers/fpga/xrt/lib/Kconfig"
> > > +source "drivers/fpga/xrt/mgmt/Kconfig"
> > > diff --git a/drivers/fpga/xrt/lib/Kconfig
> > > b/drivers/fpga/xrt/lib/Kconfig new file mode 100644 index
> > > 000000000000..eed5cb73f5e2
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/lib/Kconfig
> > > @@ -0,0 +1,16 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only # # XRT Alveo FPGA device
> > > +configuration #
> > > +
> > > +config FPGA_XRT_LIB
> > > +	tristate "XRT Alveo Driver Library"
> > > +	depends on HWMON && PCI && HAS_IOMEM
> > > +	select FPGA_XRT_METADATA
> > > +	help
> > > +	  Select this option to enable Xilinx XRT Alveo driver library. Thi=
s
> > > +	  library is core infrastructure of XRT Alveo FPGA drivers which
> > > +	  provides functions for working with device nodes, iteration and
> > > +	  lookup of platform devices, common interfaces for platform device=
s,
> > > +	  plumbing of function call and ioctls between platform devices and
> > > +	  parent partitions.
> > > diff --git a/drivers/fpga/xrt/lib/Makefile
> > > b/drivers/fpga/xrt/lib/Makefile new file mode 100644 index
> > > 000000000000..5641231b2a36
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/lib/Makefile
> > > @@ -0,0 +1,30 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > > +#
> > > +# Authors: Sonal.Santan@xilinx.com
> > > +#
> > > +
> > > +FULL_XRT_PATH=3D$(srctree)/$(src)/..
> > > +FULL_DTC_PATH=3D$(srctree)/scripts/dtc/libfdt
> > > +
> > > +obj-$(CONFIG_FPGA_XRT_LIB) +=3D xrt-lib.o
> > > +
> > > +xrt-lib-objs :=3D			\
> > > +	main.o			\
> > > +	xroot.o			\
> > > +	xclbin.o		\
> > > +	subdev.o		\
> > > +	cdev.o			\
> > > +	group.o			\
> > > +	xleaf/vsec.o		\
> > > +	xleaf/axigate.o		\
> > > +	xleaf/devctl.o		\
> > > +	xleaf/icap.o		\
> > > +	xleaf/clock.o		\
> > > +	xleaf/clkfreq.o		\
> > > +	xleaf/ucs.o		\
> > > +	xleaf/calib.o		\
> > > +
> > > +ccflags-y :=3D -I$(FULL_XRT_PATH)/include	 \
> > > +	-I$(FULL_DTC_PATH)
> > > diff --git a/drivers/fpga/xrt/metadata/Kconfig
> > > b/drivers/fpga/xrt/metadata/Kconfig
> > > new file mode 100644
> > > index 000000000000..5012c9c6584d
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/metadata/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only # # XRT Alveo FPGA device
> > > +configuration #
> > > +
> > > +config FPGA_XRT_METADATA
> > > +	bool "XRT Alveo Driver Metadata Parser"
> > > +	select LIBFDT
> > > +	help
> > > +	  This option provides helper functions to parse Xilinx Alveo FPGA
> > > +	  firmware metadata. The metadata is in device tree format and XRT
> > and the XRT
> > > +	  driver uses it to discover HW subsystems behind PCIe BAR.
> > the HW
> > > diff --git a/drivers/fpga/xrt/metadata/Makefile
> > > b/drivers/fpga/xrt/metadata/Makefile
> > > new file mode 100644
> > > index 000000000000..14f65ef1595c
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/metadata/Makefile
> > > @@ -0,0 +1,16 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > > +#
> > > +# Authors: Sonal.Santan@xilinx.com
> > > +#
> > > +
> > > +FULL_XRT_PATH=3D$(srctree)/$(src)/..
> > > +FULL_DTC_PATH=3D$(srctree)/scripts/dtc/libfdt
> > > +
> > > +obj-$(CONFIG_FPGA_XRT_METADATA) +=3D xrt-md.o
> > > +
> > > +xrt-md-objs :=3D metadata.o
> > > +
> > > +ccflags-y :=3D -I$(FULL_XRT_PATH)/include	\
> > > +	-I$(FULL_DTC_PATH)
> > > diff --git a/drivers/fpga/xrt/mgmt/Kconfig
> > > b/drivers/fpga/xrt/mgmt/Kconfig new file mode 100644 index
> > > 000000000000..2b2a2c34685c
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/Kconfig
> > > @@ -0,0 +1,15 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only # # Xilinx XRT FPGA device
> > > +configuration #
> > > +
> > > +config FPGA_XRT_XMGMT
> > > +	tristate "Xilinx Alveo Management Driver"
> > > +	depends on HWMON && PCI && FPGA_XRT_LIB
> >
> > FPGA_XRT_LIB also depends on HWMON and PCI, so this could be minimized.
> >
> > Tom
> >
> > > +	select FPGA_XRT_METADATA
> > > +	select FPGA_BRIDGE
> > > +	select FPGA_REGION
> > > +	help
> > > +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPG=
A.
> > > +	  This driver provides interfaces for userspace application to acce=
ss
> > > +	  Alveo FPGA device.
> > > diff --git a/drivers/fpga/xrt/mgmt/Makefile
> > > b/drivers/fpga/xrt/mgmt/Makefile new file mode 100644 index
> > > 000000000000..8051708c361c
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/Makefile
> > > @@ -0,0 +1,19 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > > +#
> > > +# Authors: Sonal.Santan@xilinx.com
> > > +#
> > > +
> > > +FULL_XRT_PATH=3D$(srctree)/$(src)/..
> > > +FULL_DTC_PATH=3D$(srctree)/scripts/dtc/libfdt
> > > +
> > > +obj-$(CONFIG_FPGA_XRT_XMGMT)	+=3D xmgmt.o
> > > +
> > > +xmgmt-objs :=3D root.o		\
> > > +	   main.o		\
> > > +	   fmgr-drv.o		\
> > > +	   main-region.o
> > > +
> > > +ccflags-y :=3D -I$(FULL_XRT_PATH)/include		\
> > > +	-I$(FULL_DTC_PATH)
> >
>=20
> - Moritz

-Sonal

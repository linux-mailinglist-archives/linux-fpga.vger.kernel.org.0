Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4624451D
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Aug 2020 08:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHNG4K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Aug 2020 02:56:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:19119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgHNG4J (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Aug 2020 02:56:09 -0400
IronPort-SDR: v/om2mRv1ruR/QIezZe/OM5KRyX1Na//7dGW28hEM5KYYH9COIbt9SNxWQzrCK0VL+t52zjCqs
 qLSWUyWBROBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239197345"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="239197345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 23:55:37 -0700
IronPort-SDR: Ufsm2rXmI31D9zJS5RAbVY4KIaEI7+6Qr97Juo0KPje6nxwXU0ak5K4gTdgTebKA0WMYvtFt93
 vUgu89+5cxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="327803263"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com) ([10.22.229.83])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2020 23:55:37 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 23:55:36 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Aug 2020 23:55:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 13 Aug 2020 23:55:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afyRF01VLS+sItNchLJLdFvBVCt52lXvyDUgq4DoR/35aq6k8O6rx8Agh7pQk2n30ycZY0g+kwkl/ZitncDJLQ8PGoA/ZkvF76Xr5I50zzMKd27OesIlHELltBLIzXZJ4J3g6axsLGF5Sr77vJMK6f+FbD724rEG6rZOu77rQgdlLvAje66zlDBUchbmsMY4lD86jJVqO2QxdvwmJp2iioyb3Zwq/ucefCLpcQQPqrEp2Lr1dXhNjFFeD8Y5a8zWnDm00s4kDEX0tul2lzuPOgT6fHPEIOtU6WaGNKNBR+p7yKg/+LhTCt7pFhqs6vkDj0SVWN0Q4qaSHjWklB/CSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnLfC+0WxzyPPnhRcgwaQipktGXqEwf3YGTzw4lEU10=;
 b=KkYnk96f/4IgdoH34/b8wTuLvmgLDB5O+mC/jLlh0XHuIDei4fEbL8H5JdAMx1+riFYvGrPCj2gRG5dARV7O9rnUXshISr7x7s3aDF4F7rHs6nuHi8dRGO4gnDTXDJp/ORLQQqeYGffP3cal+s/6khik2TzD/oW963iY6RrY5wczrj34zVCxuTGTlIuSVKl5xJEDBjAAy+9OsvEGr/ZT9H6LWkhb7pDpYcXCjWaYKCRY+rcZvGbMyyG4xll/f1XzeT0zhuYMJdmenARtU/9FdyZAwQgXWHv1YGOxuGhb33SRD9tavKe5hp5n0w66U4em/QkxNdaqYPsy2fidHbI78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnLfC+0WxzyPPnhRcgwaQipktGXqEwf3YGTzw4lEU10=;
 b=dVudrCNB0Si4nAvofPYDxRPP0w1JaAYcqCPCMmfoaCiZbpV6Pls/CIv7CGM/pj2ZfhrQxtItbbCdIMDGhME6pg+o+su2xsYFyf/JZkQhPw0otyWjIto/EFD/mX7vT2tD0I7BZTx03F7Dg6q5KpskkbcdPfekRm9NMMWpw/r7wGQ=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Fri, 14 Aug
 2020 06:55:33 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3283.016; Fri, 14 Aug 2020
 06:55:33 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v5 3/3] fpga: dfl: add support for N3000 Nios private
  feature
Thread-Topic: [PATCH v5 3/3] fpga: dfl: add support for N3000 Nios private
  feature
Thread-Index: AQHWcgAOk+QPmnvzqU20JoVGQrLfGqk3IYIQ
Date:   Fri, 14 Aug 2020 06:55:32 +0000
Message-ID: <DM6PR11MB381910C0A06F85C58348D50685400@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1597303080-30640-1-git-send-email-yilun.xu@intel.com>
 <1597303080-30640-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819557E133CABA89288F2E085430@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200814055527.GA20337@yilunxu-OptiPlex-7050>
In-Reply-To: <20200814055527.GA20337@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a98092fc-8704-4dce-c370-08d8401f0a23
x-ms-traffictypediagnostic: DM6PR11MB3404:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3404487C586CCE4C05412CD485400@DM6PR11MB3404.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UScUhRvhQ8z3LUXNfnmeQwpB3mony1/RWcES4Rr90tRp+bc4pk0r15islGL3Cc4kbH+dITCeGEpfqlWGIMVsK9a4M3Vp86AKnPAqoxfN4F8ZYoL7RKHH0yH3o9a67A7r/vWv+E/U/kFJu4AExCIAH9I7x0tqa2E4NrHuxAFCTQGRv8d/TDwOKyKkFZaO7j3/b+n7uy0q0170T+Lgkjca9eCLwuiTlKZkrwht7A4cGB+U3p7KkcnKJhP3WxVYsP7H5Xy2dKf5sN5DrXQgWfuQVCqhukDX1raez9PwHHt5V0o+arC0XOB0xo3Wv5OfMQ3K1yI6iU2W46MB2rILpNJ3NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(6862004)(86362001)(4326008)(76116006)(478600001)(2906002)(7696005)(316002)(66946007)(71200400001)(66446008)(26005)(64756008)(66556008)(66476007)(9686003)(8936002)(8676002)(83380400001)(55016002)(5660300002)(6506007)(6636002)(52536014)(186003)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Wqg7ZUK02Xrp0Ci7J+suuct/z1PpFSlArN5gxRHIPhkrRWq448FAWBls+kgrEE+X/lofxz8iz7MZc3Fs0gAC40l21LwVefjtAPjMM8aP6zcf0lFhrKhV7GWEdL6RLZaTlJrKScdbXdXX9BbvBPXkkONmCliXRjp6Urn0ikkJ4T3Z9VCJaSs+Uixd8MeIv7ndW0ctylX2MeFmTP25FI5v7Zr3Uo08KIYNA9Me58n8p4ri0OZ4hkJjjqdxu96AXkU4MCTHDp2HbOjIv+8frHQXXag0VlKT6Xg7aN7BaG6q9UzAZN0anErzSZZCcWOoi2lcrYRJbBK6/cBZWD+ANxSdzkt0h3Kv5RL6JpwOLLddAJROUXK4zKz0hTZS924DRUaxT7NKCa7YbivaOzouFEBcI12Oea3Uw3rVc2RFRp95jyynXKoaMcM8wbR79q+iZAmacYyAbd+FqkQ6qrqnOg2vgkjAfqAMMdJ01/dVdl33qUltDSlhYLs+Vqe5KdoTx7iRxaQiWQtpRzWXa1Kwf2LHA/i5dPCASQ1E6tPlZP2bu9SaccsJSyKYb7tsTjGhgtACRiKv7Nz/JniVP7zHvcRluXC0W9WjAliku/jge7gQtlRqGH/W+3O1xMHSDyXRMJ6VbtBTVdTk8rrmYS2QYDLhEg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98092fc-8704-4dce-c370-08d8401f0a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 06:55:32.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4vtSYZv+fk3opQMAxsWD3mmbuKwmLNc6vlDDfAD32w2Jk4AqBreb5toG5Cg/C3gK17pDlcJGsT3a2bw0J6upA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3404
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 7cd5a29..f6252cd 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -191,6 +191,17 @@ config FPGA_DFL_AFU
> > >    to the FPGA infrastructure via a Port. There may be more than one
> > >    Port/AFU per DFL based FPGA device.
> > >
> > > +config FPGA_DFL_N3000_NIOS
> >
> > FPGA_DFL_NIOS_INTEL_PAC_N3000
>=20
> Why we need to be that specific? I think we don't have to add so many
> info for the naming. dfl N3000 nios is unique and aligned with the file
> name and driver name.

Looks like this driver only works for this card, not designed for common
reuse I think. This is why I am thinking if it can be more specific, and=20
matches with descriptions below.

>=20
> >
> > > +        tristate "FPGA DFL N3000 NIOS Driver"
> >
> > FPGA DFL NIOS Driver for Intel PAC N3000
> >
> > > +        depends on FPGA_DFL
> > > +        select REGMAP
> > > +        help
> > > +  This is the driver for the N3000 Nios private feature on Intel
> > > +  PAC (Programmable Acceleration Card) N3000. It communicates
> > > +  with the embedded Nios processor to configure the retimers on
> > > +  the card. It also instantiates the SPI master (spi-altera) for
> > > +  the card's BMC (Board Management Controller) control.
> > > +
> > >  config FPGA_DFL_PCI
> > >  tristate "FPGA DFL PCIe Device Driver"
> > >  depends on PCI && FPGA_DFL
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index d8e21df..27f20f2 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -44,5 +44,7 @@ dfl-fme-objs +=3D dfl-fme-perf.o
> > >  dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region=
.o
> > >  dfl-afu-objs +=3D dfl-afu-error.o
> > >
> > > +obj-$(CONFIG_FPGA_DFL_N3000_NIOS)      +=3D dfl-n3000-nios.o
> > > +
> > >  # Drivers for FPGAs which implement DFL
> > >  obj-$(CONFIG_FPGA_DFL_PCI)+=3D dfl-pci.o
> > > diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-n=
ios.c
> > > new file mode 100644
> > > index 0000000..aeac224
> > > --- /dev/null
> > > +++ b/drivers/fpga/dfl-n3000-nios.c
> > > @@ -0,0 +1,528 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * DFL device driver for Nios private feature on Intel PAC (Programm=
able
> > > + * Acceleration Card) N3000
> > > + *
> > > + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> > > + *
> > > + * Authors:
> > > + *   Wu Hao <hao.wu@intel.com>
> > > + *   Xu Yilun <yilun.xu@intel.com>
> > > + */
> > > +#include <linux/bitfield.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/io.h>
> > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/stddef.h>
> > > +#include <linux/spi/altera.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "dfl.h"
> > > +
> > > +static char *fec_mode =3D "rs";
> > > +module_param(fec_mode, charp, 0444);
> > > +MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on
> > > Intel PAC N3000");
> > > +
> > > +/* N3000 Nios private feature registers */
> > > +#define NIOS_SPI_PARAM0x8
> > > +#define PARAM_SHIFT_MODE_MSKBIT_ULL(1)
> > > +#define PARAM_SHIFT_MODE_MSB0
> > > +#define PARAM_SHIFT_MODE_LSB1
> > > +#define PARAM_DATA_WIDTHGENMASK_ULL(7, 2)
> > > +#define PARAM_NUM_CSGENMASK_ULL(13, 8)
> > > +#define PARAM_CLK_POLBIT_ULL(14)
> > > +#define PARAM_CLK_PHASEBIT_ULL(15)
> > > +#define PARAM_PERIPHERAL_IDGENMASK_ULL(47, 32)
> > > +
> > > +#define NIOS_SPI_CTRL0x10
> > > +#define CTRL_WR_DATAGENMASK_ULL(31, 0)
> > > +#define CTRL_ADDRGENMASK_ULL(44, 32)
> > > +#define CTRL_CMD_MSKGENMASK_ULL(63, 62)
> > > +#define CTRL_CMD_NOP0
> > > +#define CTRL_CMD_RD1
> > > +#define CTRL_CMD_WR2
> > > +
> > > +#define NIOS_SPI_STAT0x18
> > > +#define STAT_RD_DATAGENMASK_ULL(31, 0)
> > > +#define STAT_RW_VALBIT_ULL(32)
> > > +
> > > +/* Nios handshake registers, indirect access */
> > > +#define NIOS_INIT0x1000
> > > +#define NIOS_INIT_DONEBIT(0)
> > > +#define NIOS_INIT_STARTBIT(1)
> > > +/* Mode for PKVL A, link 0, the same below */
> > > +#define REQ_FEC_MODE_A0_MSKGENMASK(9, 8)
> > > +#define REQ_FEC_MODE_A1_MSKGENMASK(11, 10)
> > > +#define REQ_FEC_MODE_A2_MSKGENMASK(13, 12)
> > > +#define REQ_FEC_MODE_A3_MSKGENMASK(15, 14)
> > > +#define REQ_FEC_MODE_B0_MSKGENMASK(17, 16)
> > > +#define REQ_FEC_MODE_B1_MSKGENMASK(19, 18)
> > > +#define REQ_FEC_MODE_B2_MSKGENMASK(21, 20)
> > > +#define REQ_FEC_MODE_B3_MSKGENMASK(23, 22)
> > > +#define REQ_FEC_MODE_NO0x0
> > > +#define REQ_FEC_MODE_KR0x1
> > > +#define REQ_FEC_MODE_RS0x2
> > > +
> > > +#define NIOS_FW_VERSION0x1004
> > > +#define NIOS_FW_VERSION_PATCHGENMASK(23, 20)
> > > +#define NIOS_FW_VERSION_MINORGENMASK(27, 24)
> > > +#define NIOS_FW_VERSION_MAJORGENMASK(31, 28)
> > > +
> > > +#define PKVL_A_MODE_STS0x1020
> > > +#define PKVL_B_MODE_STS0x1024
> > > +#define PKVL_MODE_STS_GROUP_MSKGENMASK(15, 8)
> > > +#define PKVL_MODE_STS_GROUP_OK0x0
> > > +#define PKVL_MODE_STS_ID_MSKGENMASK(7, 0)
> > > +/* When GROUP MASK field =3D=3D GROUP_OK  */
> > > +#define PKVL_MODE_ID_RESET0x0
> > > +#define PKVL_MODE_ID_4X10G0x1
> > > +#define PKVL_MODE_ID_4X25G0x2
> > > +#define PKVL_MODE_ID_2X25G0x3
> > > +#define PKVL_MODE_ID_2X25G_2X10G0x4
> > > +#define PKVL_MODE_ID_1X25G0x5
> > > +
> > > +#define NS_REGBUS_WAIT_TIMEOUT10000/* loop count */
> > > +#define NIOS_INIT_TIMEOUT10000000/* usec */
> > > +#define NIOS_INIT_TIME_INTV100000/* usec */
> > > +
> > > +struct n3000_nios {
> > > +void __iomem *base;
> > > +struct regmap *regmap;
> > > +struct device *dev;
> > > +struct platform_device *altera_spi;
> > > +};
> > > +
> > > +static ssize_t nios_fw_version_show(struct device *dev,
> > > +    struct device_attribute *attr, char *buf)
> > > +{
> > > +struct n3000_nios *ns =3D dev_get_drvdata(dev);
> > > +unsigned int val;
> > > +int ret;
> > > +
> > > +ret =3D regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +return sprintf(buf, "%x.%x.%x\n",
> > > +       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
> > > +       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
> > > +       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
> > > +}
> > > +static DEVICE_ATTR_RO(nios_fw_version);
> > > +
> > > +#define IS_MODE_STATUS_OK(mode_stat)\
> > > +(FIELD_GET(PKVL_MODE_STS_GROUP_MSK, (mode_stat)) =3D=3D\
> > > + PKVL_MODE_STS_GROUP_OK)
> > > +
> > > +#define IS_RETIMER_FEC_CONFIGURABLE(retimer_mode)\
> > > +((retimer_mode) !=3D PKVL_MODE_ID_RESET &&\
> > > + (retimer_mode) !=3D PKVL_MODE_ID_4X10G)
> > > +
> > > +static int get_retimer_mode(struct n3000_nios *ns, unsigned int
> > > mode_stat_reg,
> > > +    unsigned int *retimer_mode)
> > > +{
> > > +unsigned int val;
> > > +int ret;
> > > +
> > > +ret =3D regmap_read(ns->regmap, mode_stat_reg, &val);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +if (!IS_MODE_STATUS_OK(val))
> > > +return -EFAULT;
> > > +
> > > +*retimer_mode =3D FIELD_GET(PKVL_MODE_STS_ID_MSK, val);
> > > +
> > > +return 0;
> > > +}
> > > +
> > > +static ssize_t fec_mode_show(struct device *dev,
> > > +     struct device_attribute *attr, char *buf)
> > > +{
> > > +struct n3000_nios *ns =3D dev_get_drvdata(dev);
> > > +unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
> > > +int ret;
> > > +
> > > +ret =3D get_retimer_mode(ns, PKVL_A_MODE_STS, &retimer_a_mode);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +ret =3D get_retimer_mode(ns, PKVL_B_MODE_STS, &retimer_b_mode);
> > > +if (ret)
> > > +return ret;
> > > +
> > > +if (!IS_RETIMER_FEC_CONFIGURABLE(retimer_a_mode) &&
> > > +    !IS_RETIMER_FEC_CONFIGURABLE(retimer_b_mode))
> > > +return sprintf(buf, "no\n");
> >
> > It needs to be defined clearly, configurable seems a little confusing.
> > It seems that hardware supports FEC mode but software can't change it.
>=20
> So let's name it IS_RETIMER_FEC_SUPPORTED(), is that OK?
>=20
> > Is that true? If it's in some hardware version doesn't support FEC, the=
n
> > We can make this sysfs not visible, right?
>=20
> Since now we always accepts the Module Parameter regardless the FW
> version, I think it would be reasonable we always have the sysfs to
> feedback the result of configuration.
>=20
> How do you think about it?

Yes, we can keep it, or return "not supported" in this sysfs in case it's n=
ot supported.

> > > +static void dump_error_stat(struct n3000_nios *ns)
> > > +{
> > > +unsigned int val;
> > > +
> > > +if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> > > +return;
> > > +
> > > +dev_info(ns->dev, "PKVL_A_MODE_STS 0x%x\n", val);
> >
> > dev_err is better?
>=20
> The logs will be printed out when the retimer configuration fails, in
> this case the module load will still success. Would it be confusing that
> driver prints error level msg but it doesn't fail out.

will these messages print only when hits errors/fails configuration with=20
hardware?=20

Thanks
Hao

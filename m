Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280F2CB485
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgLBFeW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 00:34:22 -0500
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:57736
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728503AbgLBFeW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 00:34:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQvgq/oigg3Z8e9227TIeKARiGlazWa6xpT4IHQJ3VUpV7fWSSpFH7J/CN4z8NH+A3URhCFWke7FWc8Z/lpI74n787ipZjMRDGhbKSqzuthadkw7LQee/n/UzxGWFdV9G7Uln21YDTA5O80B+wVtx2maKxR5NFtcXKwG3tyVU7QZBa7oNpSmQkY4ClK0RNXzPtGDEVXbSJjRcmt6rpHEdV13lFeQu+Myt9Ek42GAC3W4eXE8q3W+uN/3i8DStCdXcWQOcySYnS/mmegZkNuPvzKtXAAAgiANKls7zTGksclvk2dd+NJxXxFpOVk1hPHLtkju65LoAg4RDKgft1+/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4JiaGVS2xpxkILhVgYnuKjm9X8QliaE5VPYjJOcchU=;
 b=PUye+jXiZScnt4Ls8cKGo8EIw3MSaBvZbYM3v3GpMhyGz/NFLtLiE3ZBVUIK+XYcwXR9n0DHPrQ0uJ2STfsoSMwVvSfgcvL4hV7fUvszuGy9Ldz9HT4J1LimjhPyyc+zK5gKsidXuCikNXfUWI6ZNb54oBf8lQBHY7ft+/wrv9qLjGheFRAowFbVPCm9eQP6VUgwjTVFo5s9tyouvCKQ6Qv+lxFFjC2iAoq1LXU0NgagxuT4vJv83N0nwaHgnFvmXznQUQRw05jBvvHhnWeihQiZz2TJPdttNfojAtKxdbaUD4ivQgp6aOpoGpH+Dx+mY6m4onkd0hOEQ1iatTlrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4JiaGVS2xpxkILhVgYnuKjm9X8QliaE5VPYjJOcchU=;
 b=fbzaCnf10b36mCD9hJB4keV4aK2vNw3YZIKVEz2gESdeCV0/8CXXrEpMZaYrJDLyoSsHazX8+BUvQqu5UAiiI8Zi+UhpqXOHiPkki1f0SHbH/pZs26YNZmW+BZBhJIC3xakPKJm/pnRdQYEOgkmwYl8OylvZfSfp7DlyR97cb+M=
Received: from BY5PR02MB6260.namprd02.prod.outlook.com (2603:10b6:a03:1b0::29)
 by BYAPR02MB4677.namprd02.prod.outlook.com (2603:10b6:a03:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 05:33:26 +0000
Received: from BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5]) by BY5PR02MB6260.namprd02.prod.outlook.com
 ([fe80::7183:fa14:bfcf:8ff5%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:33:26 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
Thread-Topic: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
Thread-Index: AQHWxeLU/QqdfVxGqkCi67mkKmZopKnjFfSAgAA21lA=
Date:   Wed, 2 Dec 2020 05:33:26 +0000
Message-ID: <BY5PR02MB6260860E8B61453DE5CF73F1BBF30@BY5PR02MB6260.namprd02.prod.outlook.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201202021429.GC22103@yilunxu-OptiPlex-7050>
In-Reply-To: <20201202021429.GC22103@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [98.207.149.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c309e39c-18f9-4962-9140-08d89683cb27
x-ms-traffictypediagnostic: BYAPR02MB4677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB467731C8FAD770CDAC1E46F9BBF30@BYAPR02MB4677.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lc89ZC8jqSf3frlMQjKR+6tjmM2m6QJ57vLmmLOF8nAm33CXWWQN/db5QlwpL7K/s1ZlPjwFURQIchXmhc9/p3gUbmV2DywndkNPVis9vZKroJHqk8+JYMHCjNgKAXgFffG7XfktfhmgU6SCLJ70ogsSloEMpaHFMJIiFHk2XrSDeE53VgC5EzqkDxDs8JB/jXpyrpRIq4FEbFlgxGj8/gVHjOgqSYUaVeufMo5I3/fLlSRHzu3/pvqTcdf3mKyzzhNTpgInd07+Ml4mbRlVQX5VvEPKoymPcrpa1DEQZrpUa/ibTvjvn2qUd0FU6tUPRvrUrrJFwaJ3l0POy4rIC27SCBVjko1m9Skq5lOdhdQiZn0XInKT4lzamWuotAMyS0pPoNkOkL8R43ZqqHkMXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6260.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(316002)(53546011)(186003)(5660300002)(86362001)(9686003)(55016002)(66556008)(966005)(66476007)(76116006)(66946007)(54906003)(64756008)(83380400001)(8676002)(6506007)(26005)(2906002)(52536014)(6916009)(71200400001)(4326008)(7696005)(478600001)(30864003)(8936002)(33656002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S4bPedsxDIt+42YbDXjZ2HGfORiY42AIvAcVQIMklaj+5/Kz5gR31C7DtWxp?=
 =?us-ascii?Q?L9WGy9YE2NrdWxC6SZXLvsWHlyLNZcd/KEB4gHeWhlIYvG2Q5Dvw0AYJrx7A?=
 =?us-ascii?Q?xnRd5XgzqYl9f5WcTz52oN4f7s06mGNaAB76yAdz27IOmG86mbojEGWt02BG?=
 =?us-ascii?Q?PpVgqohRatu2xp4KC+iMgDrnHKbaJ5R9m0cD1fWT9Q2Y9IY2VCFrbshDBb9F?=
 =?us-ascii?Q?K0Jji2rCTDffP7KzuScvPtaJVlTC9e9n0FsONAufw4LFr1zwt/orgFVecT6c?=
 =?us-ascii?Q?7JiW+51Vf9AOS8xxgq3rypFWrdzu4myschEznq2D7fCA11LqD2WIl3F88CJQ?=
 =?us-ascii?Q?rYT1dxr2j5o9bhF6y5i+tzKsAkDHv1bJ4IKzPHAhI7gOCsWBdT6dtTrEBSmT?=
 =?us-ascii?Q?GJ3dvDUClYUk7o50hjmIJzKdSryIwhTnI7gy9ZF4tv3hTfqvZ4zc9x1ISgSi?=
 =?us-ascii?Q?N+D4cZ4AbTQuCzXAteTgmhVBtD3gAvGp33wxFkTZmUGexjvl8c+ZXnsyeUkK?=
 =?us-ascii?Q?BvlC40jtNrPw2nAfuRGWk0hAw8xgFRERfUFgppr1rjVhQgm2GCr2mEuLUEgb?=
 =?us-ascii?Q?zWSA3KihP2vdX8/9s9jvnnSfNYu712evaOFM7BVdcfZZUmCnxTsw8caCIRiO?=
 =?us-ascii?Q?+NZxodNO+C592F5Gq6lH/KPTeWEYBFifXyJ9mlhUKmXn37x1pNk07ePIBaGP?=
 =?us-ascii?Q?sZ+v73d8l0Aa3etndQ3GJUTiGmzRGAnyUUlUjKBwWDEc0/wdgPTtLX9dlbsv?=
 =?us-ascii?Q?D+KRNWRzfzi5HjBdYuqUkooKA9c8K2OJjxWEvNKkduBkSzSDWtMjvM+lQFdu?=
 =?us-ascii?Q?oWhbJv6TKuT0taX2eTV7pRJGyuFlQZjrMG8Xxgk9/6P1ip+8drEpQ3IOv63F?=
 =?us-ascii?Q?EDQ5GY7oY1uGBEDIY/8+yHWe0inhyVtWIIf/e/bo93WiWPV+N4+qEsvYwaAb?=
 =?us-ascii?Q?zaWcFg59JJM4ynqkvhhnh/69QvturOPiUXt+k5PEf48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6260.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c309e39c-18f9-4962-9140-08d89683cb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 05:33:26.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vh8vftDb6ohd2AhuZl4Ifb/w/1lm5oz5WKbHeHFnnrGoexyGE1nc39Ck8DOZCPkwqjFtmYOhaqH+vyhrXsfGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4677
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Tuesday, December 1, 2020 6:14 PM
> To: Sonal Santan <sonals@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; Sonal Santan <sonals@xilinx.com>; linux=
-
> fpga@vger.kernel.org; Max Zhen <maxz@xilinx.com>; Lizhi Hou
> <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>; Stefano Stabellin=
i
> <stefanos@xilinx.com>; devicetree@vger.kernel.org
> Subject: Re: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
>=20
> On Sat, Nov 28, 2020 at 04:00:32PM -0800, Sonal Santan wrote:
> > Hello,
> >
> > This patch series adds management physical function driver for Xilinx
> > Alveo PCIe accelerator cards,
> > https://www.xilinx.com/products/boards-and-kits/alveo.html
> > This driver is part of Xilinx Runtime (XRT) open source stack.
> >
> > The patch depends on the "PATCH Xilinx Alveo libfdt prep" which was
> > posted before.
> >
> > ALVEO PLATFORM ARCHITECTURE
> >
> > Alveo PCIe FPGA based platforms have a static *shell* partition and a
> > partial re-configurable *user* partition. The shell partition is
> > automatically loaded from flash when host is booted and PCIe is
> > enumerated by BIOS. Shell cannot be changed till the next cold reboot. =
The
> shell exposes two PCIe physical functions:
> >
> > 1. management physical function
> > 2. user physical function
> >
> > The patch series includes Documentation/xrt.rst which describes Alveo
> > platform, xmgmt driver architecture and deployment model in more more
> detail.
> >
> > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > image using Vitis
> > https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> > tools. The image is packaged as xclbin and contains partial bitstream
> > for the user partition and necessary metadata. Users can dynamically
> > swap the image running on the user partition in order to switch between
> different workloads.
> >
> > ALVEO DRIVERS
> >
> > Alveo Linux kernel driver *xmgmt* binds to management physical
> > function of Alveo platform. The modular driver framework is organized
> > into several platform drivers which primarily handle the following
> functionality:
> >
> > 1.  Loading firmware container also called xsabin at driver attach
> > time 2.  Loading of user compiled xclbin with FPGA Manager integration
> > 3.  Clock scaling of image running on user partition 4.  In-band
> > sensors: temp, voltage, power, etc.
> > 5.  Device reset and rescan
> > 6.  Flashing static *shell* partition
> >
> > The platform drivers are packaged into *xrt-lib* helper module with a
> > well defined interfaces the details of which can be found in
> Documentation/xrt.rst.
> >
> > xmgmt driver is second generation Alveo management driver and
> > evolution of the first generation (out of tree) Alveo management
> > driver, xclmgmt. The sources of the first generation drivers were
> > posted on LKML last year--
> > https://lore.kernel.org/lkml/20190319215401.6562-1-sonal.santan@xilinx
> > .com/
> >
> > Changes since the first generation driver include the following: the
> > driver has been re-architected as data driven modular driver; the
> > driver has been split into xmgmt and xrt-lib; user physical function
> > driver has been removed from the patch series.
> >
> > Alveo/XRT security and platform architecture is documented on the
> > following GitHub pages:
> > https://xilinx.github.io/XRT/master/html/security.html
> > https://xilinx.github.io/XRT/master/html/platforms_partitions.html
> >
> > User physical function driver is not included in this patch series.
> >
> > TESTING AND VALIDATION
> >
> > xmgmt driver can be tested with full XRT open source stack which
> > includes user space libraries, board utilities and (out of tree) first
> > generation user physical function driver xocl. XRT open source runtime
> > stack is available at https://github.com/Xilinx/XRT. This patch series
> > has been validated on Alveo U50 platform.
> >
> > Complete documentation for XRT open source stack can be found here--
> > https://xilinx.github.io/XRT/master/html/index.html
> >
> > Thanks,
> > -Sonal
> >
> > Sonal Santan (8):
> >   Documentation: fpga: Add a document describing Alveo XRT drivers
> >   fpga: xrt: Add UAPI header files
> >   fpga: xrt: infrastructure support for xmgmt driver
> >   fpga: xrt: core infrastructure for xrt-lib module
> >   fpga: xrt: platform drivers for subsystems in shell partition
>=20
> Seems the Patch #5 is missing in this seriies.

Patch #5 was posted along with the rest. You can find a copy here--
https://lore.kernel.org/lkml/20201129000040.24777-6-sonals@xilinx.com/

Thanks,
Sonal
>=20
> Thanks,
> Yilun
>=20
> >   fpga: xrt: header file for platform and parent drivers
> >   fpga: xrt: Alveo management physical function driver
> >   fpga: xrt: Kconfig and Makefile updates for XRT drivers
> >
> >  Documentation/fpga/index.rst                  |    1 +
> >  Documentation/fpga/xrt.rst                    |  588 +++++
> >  drivers/fpga/Kconfig                          |    2 +
> >  drivers/fpga/Makefile                         |    3 +
> >  drivers/fpga/alveo/Kconfig                    |    7 +
> >  drivers/fpga/alveo/common/xrt-metadata.c      |  590 +++++
> >  drivers/fpga/alveo/common/xrt-root.c          |  744 +++++++
> >  drivers/fpga/alveo/common/xrt-root.h          |   24 +
> >  drivers/fpga/alveo/common/xrt-xclbin.c        |  387 ++++
> >  drivers/fpga/alveo/common/xrt-xclbin.h        |   46 +
> >  drivers/fpga/alveo/include/xmgmt-main.h       |   34 +
> >  drivers/fpga/alveo/include/xrt-axigate.h      |   31 +
> >  drivers/fpga/alveo/include/xrt-calib.h        |   28 +
> >  drivers/fpga/alveo/include/xrt-clkfreq.h      |   21 +
> >  drivers/fpga/alveo/include/xrt-clock.h        |   29 +
> >  drivers/fpga/alveo/include/xrt-cmc.h          |   23 +
> >  drivers/fpga/alveo/include/xrt-ddr-srsr.h     |   29 +
> >  drivers/fpga/alveo/include/xrt-flash.h        |   28 +
> >  drivers/fpga/alveo/include/xrt-gpio.h         |   41 +
> >  drivers/fpga/alveo/include/xrt-icap.h         |   27 +
> >  drivers/fpga/alveo/include/xrt-mailbox.h      |   44 +
> >  drivers/fpga/alveo/include/xrt-metadata.h     |  184 ++
> >  drivers/fpga/alveo/include/xrt-parent.h       |  103 +
> >  drivers/fpga/alveo/include/xrt-partition.h    |   33 +
> >  drivers/fpga/alveo/include/xrt-subdev.h       |  333 +++
> >  drivers/fpga/alveo/include/xrt-ucs.h          |   22 +
> >  drivers/fpga/alveo/lib/Kconfig                |   11 +
> >  drivers/fpga/alveo/lib/Makefile               |   42 +
> >  drivers/fpga/alveo/lib/subdevs/xrt-axigate.c  |  298 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-calib.c    |  291 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c  |  214 ++
> >  drivers/fpga/alveo/lib/subdevs/xrt-clock.c    |  638 ++++++
> >  .../fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c   |  343 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c |  322 +++
> > drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h |  135 ++
> > .../fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c  |  320 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c   |  361 ++++
> >  .../fpga/alveo/lib/subdevs/xrt-cmc-sensors.c  |  445 ++++
> >  drivers/fpga/alveo/lib/subdevs/xrt-cmc.c      |  239 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-gpio.c     |  198 ++
> >  drivers/fpga/alveo/lib/subdevs/xrt-icap.c     |  306 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c  | 1905 +++++++++++++++++
> >  .../fpga/alveo/lib/subdevs/xrt-partition.c    |  261 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-qspi.c     | 1347 ++++++++++++
> >  drivers/fpga/alveo/lib/subdevs/xrt-srsr.c     |  322 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-test.c     |  274 +++
> >  drivers/fpga/alveo/lib/subdevs/xrt-ucs.c      |  238 ++
> >  .../fpga/alveo/lib/subdevs/xrt-vsec-golden.c  |  238 ++
> >  drivers/fpga/alveo/lib/subdevs/xrt-vsec.c     |  337 +++
> >  drivers/fpga/alveo/lib/xrt-cdev.c             |  234 ++
> >  drivers/fpga/alveo/lib/xrt-main.c             |  275 +++
> >  drivers/fpga/alveo/lib/xrt-main.h             |   46 +
> >  drivers/fpga/alveo/lib/xrt-subdev.c           | 1007 +++++++++
> >  drivers/fpga/alveo/mgmt/Kconfig               |   11 +
> >  drivers/fpga/alveo/mgmt/Makefile              |   28 +
> >  drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c      |  194 ++
> >  drivers/fpga/alveo/mgmt/xmgmt-fmgr.h          |   29 +
> >  drivers/fpga/alveo/mgmt/xmgmt-main-impl.h     |   36 +
> >  drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c  |  930 ++++++++
> >  drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c      |  190 ++
> >  drivers/fpga/alveo/mgmt/xmgmt-main.c          |  843 ++++++++
> >  drivers/fpga/alveo/mgmt/xmgmt-root.c          |  375 ++++
> >  include/uapi/linux/xrt/flash_xrt_data.h       |   67 +
> >  include/uapi/linux/xrt/mailbox_proto.h        |  394 ++++
> >  include/uapi/linux/xrt/mailbox_transport.h    |   74 +
> >  include/uapi/linux/xrt/xclbin.h               |  418 ++++
> >  include/uapi/linux/xrt/xmgmt-ioctl.h          |   72 +
> >  67 files changed, 17710 insertions(+)  create mode 100644
> > Documentation/fpga/xrt.rst  create mode 100644
> > drivers/fpga/alveo/Kconfig  create mode 100644
> > drivers/fpga/alveo/common/xrt-metadata.c
> >  create mode 100644 drivers/fpga/alveo/common/xrt-root.c
> >  create mode 100644 drivers/fpga/alveo/common/xrt-root.h
> >  create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.c
> >  create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.h
> >  create mode 100644 drivers/fpga/alveo/include/xmgmt-main.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-axigate.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-calib.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-clkfreq.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-clock.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-cmc.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-ddr-srsr.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-flash.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-gpio.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-icap.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-mailbox.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-metadata.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-parent.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-partition.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-subdev.h
> >  create mode 100644 drivers/fpga/alveo/include/xrt-ucs.h
> >  create mode 100644 drivers/fpga/alveo/lib/Kconfig  create mode 100644
> > drivers/fpga/alveo/lib/Makefile  create mode 100644
> > drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-calib.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clock.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-icap.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-partition.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-test.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
> >  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c
> >  create mode 100644 drivers/fpga/alveo/lib/xrt-cdev.c  create mode
> > 100644 drivers/fpga/alveo/lib/xrt-main.c  create mode 100644
> > drivers/fpga/alveo/lib/xrt-main.h  create mode 100644
> > drivers/fpga/alveo/lib/xrt-subdev.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/Kconfig  create mode
> > 100644 drivers/fpga/alveo/mgmt/Makefile  create mode 100644
> > drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main.c
> >  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-root.c
> >  create mode 100644 include/uapi/linux/xrt/flash_xrt_data.h
> >  create mode 100644 include/uapi/linux/xrt/mailbox_proto.h
> >  create mode 100644 include/uapi/linux/xrt/mailbox_transport.h
> >  create mode 100644 include/uapi/linux/xrt/xclbin.h  create mode
> > 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
> >
> > --
> > 2.17.1

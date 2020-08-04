Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBAC23BAC8
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHDM4Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 08:56:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:36708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHDM4Y (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 Aug 2020 08:56:24 -0400
IronPort-SDR: l9OgzazSLXy2yoAwSAIYcQ4yODlrFtmYVXMbKMXgUnDA2VG0Goi50P6a7qMwTGLwIfAb+Ms+9T
 7/UIQS3ifs8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="216694648"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="216694648"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 05:56:17 -0700
IronPort-SDR: cWGk9fVa3g4pnRqlf3jy70UHQppk1EwbNqf7TiUV1HTPMOTYBb4A9kdSNUdxcbhr39t6e1OIFq
 8uIC++yiV09A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="330599399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 05:56:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Aug 2020 05:56:16 -0700
Received: from orsmsx108.amr.corp.intel.com (10.22.240.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Aug 2020 05:56:16 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Aug 2020 05:56:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Aug 2020 05:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlA7irg7pQqLEiT/6Oh9QdyW6ATSKmA3By7oQ1pPsiwlSVB3pNXu46MjBpCd5kxOew2jca97CKGB5y4OR7jkvZN3M53h0YhdZNf2I/+Uph+YJKlsSM804ZSdD0UK13iQtM/mWqyALQHdRRQwbkbR9/Gyj/xmuVSyWHRXf43j+Bo8bx730tP7K1zkopxlIKCO1shfluXVIhUfxkei/ZpQdoN3r5SoT5Am5i1YNn+rdLnMSBDofXplSpnAu1dJjUXgYQOa0nwha8Q5f5Sa78AEvgnibaBgi/EfyBIyCDRqe/j7vMnqfXporxWHsAsXsLwN3UiFZGpkMs75VnKv9vXHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRp30NwGwlpwJs4vSSAWitUJxX2AxbfjDCJFeM/n50o=;
 b=NeCW62T74mfLO5hb2ODigwO3471+3kNdD3IlGGjxRSHAr3idHRej55k6M1h01IGdyyGJRjw0OcyJQBV75I1s1n5i9zwACnkxR5QuBtbN/TVnBepMZ7PMnS/2pGaDJdVRxOOIKKA9ENcM6fdUbcMtmdrU7YryG582lGyvilfxLfjcXwx6ob6kNI+T5n3lE16RFrSQZmTE0DZcQQXkmEpxNWFNXf+EZTF2EaK1skkrQKzINbi8M7w6WWmd645EaJE5cJIBPBmuAG58Z5K/YYI5+BTipVlFraVn0WgQU5+OsO8ZK1K+a409thv8on5129uTQd1soK/6E/KXb2x2p1JPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRp30NwGwlpwJs4vSSAWitUJxX2AxbfjDCJFeM/n50o=;
 b=ZsGS+3m2w9yhXXydnay3RjjQFNnxpCCA7icQ+hRLFYzmNIs7FFWdEvZSLMTI0d/ACRxzPBzNePt7DIrfnYfaDhCvQ2qrVuvBfDahkyaUMcY4e2z8WJ3MPe3FrzHeF1WxNHogzqN7kJs93TJl9wjtt8dhxN4oYiYueWWeIWLI2Qc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (20.178.231.223) by
 DM6PR11MB2777.namprd11.prod.outlook.com (20.176.95.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Tue, 4 Aug 2020 12:56:12 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 12:56:12 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
 feature
Thread-Topic: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
 feature
Thread-Index: AQHWai4v42ESr8/OQECMeaNPHPamLqkn1W9g
Date:   Tue, 4 Aug 2020 12:56:12 +0000
Message-ID: <DM6PR11MB38196B703EA0772783466AA9854A0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74f6c9c8-9d16-457d-54ab-08d83875c424
x-ms-traffictypediagnostic: DM6PR11MB2777:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2777DB237A69551BB237DDB2854A0@DM6PR11MB2777.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qSTMiEnUuyApTFOf0k/J9jZ9rrqYuo2bIxNHRWJvZuidoPulKbiANMJpEqz79pF1lAuOVS/BY1tDR4e2wqWLfQdhvSQi+2h2gi+WL8U6FkKcf8ugtk7Wihv2TFp8w7Sin0ZXdLdqa9gGNIxIc7U5jV9x6F5uJ7c+Gr3M6hFwyeXAnu0QL6MyODtCdtCZ3+QkCFSIRF33GCfmdPTh5Fo8RqWF1zJOQ1jEgUCWvugcHHv4OkqBWGZ3/JNw9VzSREdUnZvEuZu2Jf5O/qtew7tXP8BkE30ac3racpezkNQFbX7oSSUMI7sQT4hnpARIDaIBz/w3r/GtBWII9LyEID7og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(52536014)(478600001)(2906002)(7696005)(8936002)(8676002)(76116006)(66946007)(6506007)(30864003)(66446008)(64756008)(66476007)(66556008)(83380400001)(55016002)(86362001)(71200400001)(54906003)(9686003)(26005)(4326008)(186003)(316002)(5660300002)(33656002)(110136005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lpnU65TOaLTpVeSISqKty1R+ZUxE3wuyeWlGCnPYxYb0eWFqpuSLxL7WTGQSeccV51ZsAYvejbSHVI7kQfcO/TjbAg1GEcfGe4r2QcECXYERxC2l5baqKWM94xnKJOYIOodxSFOJ/zz/tNWbWYjoG0Pe9MdMDZGdGm6CGep3AXrgFibQihvyC4TPy6MUSaP77pyf/IBm9TBYpXrAZLq83KDupZhHjFR9F5eJ4G9mbBf2RG8ZIrws12J9f17Mgvycs3/dOK8GqVmJAJOsbG0R/Ida7dg/Gsr/GOSN8bJFU72u+CfGKpyNv1YvGvseCbEYVib1SMhGus0LSZ/XSVowrzBYZKuwCUcE10qFinh+d59nEKbhYO50qem6qwdNf7kwspJOWnuB13SfhOfxfPfaGIUL00jqrDQTUftSR+uthSAHrrX1hfN//Hht8VykVVGrWXIop9mB9xmRqWPfD9ReVs0iTpK8WS3W+imAmmpzhY2ThJrzCu9cHFqxTSGonQ8NecTjna2VL77kcDT5rIq/yCMnxKr60iwbNzmsJ6JttfF39Ofdfvdxs6oEOm4ThcDTvSZg229q5NBYRLm+xWIHMcKamIMfiTlZIA3bDsrbHoku5GfcpVc4ZQ4kGhKl0xxpLOAgNw1KNWYUfg6Iw7tDVA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f6c9c8-9d16-457d-54ab-08d83875c424
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 12:56:12.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gw6N1Gs0jhVCFRbvmtFQH0Zhhjesk7fYKJKS4d8qgnXwayqqw9aOafEeNw6/o7b+KLqGVgb4pRwzWzaG5XPgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2777
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private fea=
ture
>=20
> This patch adds support for the nios handshake private feature on Intel
> N3000 FPGA Card. This private feature provides a handshake interface to
> FPGA NIOS firmware, which receives retimer configuration command from
> host
> and executes via an internal SPI master. When nios finished the
> configuration, host takes over the ownership of the SPI master to control
> an Intel MAX10 BMC Chip on the SPI bus.

Maybe you can add some more description on what NIOS is here for people
to understand this better.

>=20
> For NIOS firmware handshake part, this driver requests the retimer
> configuration for NIOS with parameters from module param, and adds some
> sysfs nodes for user to query NIOS state.
>=20
> For SPI part, this driver adds a spi-altera platform device as well as
> the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> handle following the SPI work.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v3: Add the doc for this driver.
>     Minor fixes for comments from Tom.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
>  Documentation/fpga/dfl-n3000-nios.rst              |  39 ++
>  Documentation/fpga/index.rst                       |   1 +
>  drivers/fpga/Kconfig                               |  12 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 518 +++++++++++++++=
++++++
>  6 files changed, 590 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-
> n3000-nios
>  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> new file mode 100644
> index 0000000..fcfcdbd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> @@ -0,0 +1,18 @@
> +What:		/sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
> +Date:		July 2020
> +KernelVersion:	5.9

I don't think we can catch up the 5.9-rc1 at this moment, so 5.10 please.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the FEC mode of the ethernet retimer
> +		configured by NIOS firmware. "rs" for RS FEC mode, "kr" for
> +		KR FEC mode, "no" FOR NO FEC mode. The FEC mode could
> be set
> +		by module parameters, but it could only be set once after the
> +		board powers up.
> +		Format: string
> +
> +What:		/sys/bus/dfl/devices/dfl-fme.X.X/nios_fw_version

I think you have already modified the device name to dfl-dev.X, right?

> +Date:		July 2020
> +KernelVersion:	5.9

Ditto.

> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the NIOS firmware version in FPGA. It=
s
> +		format is "major.minor.patch".
> +		Format: %x.%x.%x
> diff --git a/Documentation/fpga/dfl-n3000-nios.rst
> b/Documentation/fpga/dfl-n3000-nios.rst
> new file mode 100644
> index 0000000..391528e
> --- /dev/null
> +++ b/Documentation/fpga/dfl-n3000-nios.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DFL N3000 Nios Private Feature Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The dfl n3000 nios driver supports for the nios handshake private featur=
e
> on
> +Intel N3000 FPGA Card.
> +
> +This private feature provides a handshake interface to FPGA NIOS firmwar=
e,
> +which receives the ethernet retimer configuration command from host and
> +do the configuration via an internal SPI master. When nios finished the
> +configuration, host takes over the ownership of the SPI master to contro=
l an
> +Intel MAX10 BMC Chip on the SPI bus.

Maybe it's better to unify the naming - Nios

> +
> +So the driver does 2 major tasks on probe, requires NIOS firmware to
> configure
> +the ethernet retimer by operating the handshake interfaces, and then
> creates a
> +spi master platform device with the MAX10 device info in spi_board_info.
> +
> +Module Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The dfl n3000 nios driver supports the following module parameters:
> +
> +* fec_mode: string
> +  Require the NIOS firmware to set the FEC mode of the ethernet retimer =
on
> +  the PAC N3000 FPGA card. The possible values could be:
> +
> +  - "rs": RS FEC mode (default)
> +  - "kr": KR FEC mode
> +  - "no": NO FEC mode
> +
> +  The configuration could only be set once after the board powers up, th=
e
> +  firmware will not accept a second configuration afterward. So the fec
> mode
> +  will not be changed if the module is reloaded with a different param v=
alue.
> +
> +  The configured value of the fec mode could be queried from sysfs node:
> +
> +  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f956..5fd3c37 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>      :maxdepth: 1
>=20
>      dfl
> +    dfl-n3000-nios
>=20
>  .. only::  subproject and html
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29..f820142 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -191,6 +191,18 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>=20
> +config FPGA_DFL_N3000_NIOS
> +        tristate "FPGA DFL N3000 NIOS Driver"
> +        depends on FPGA_DFL
> +        select REGMAP
> +        help
> +	  This is the driver for the nios handshake private feature on Intel
> +	  N3000 FPGA Card. This private feature provides a handshake
> interface
> +	  to FPGA NIOS firmware, which receives retimer configuration
> command
> +	  from host and executes via an internal SPI master. When nios
> finished
> +	  the configuration, host takes over the ownership of the SPI master
> to
> +	  control an Intel MAX10 BMC Chip on the SPI bus.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21df..27f20f2 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -44,5 +44,7 @@ dfl-fme-objs +=3D dfl-fme-perf.o
>  dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs +=3D dfl-afu-error.o
>=20
> +obj-$(CONFIG_FPGA_DFL_N3000_NIOS)      +=3D dfl-n3000-nios.o
> +
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.=
c
> new file mode 100644
> index 0000000..041d759
> --- /dev/null
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -0,0 +1,518 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for DFL N3000 NIOS private feature

Maybe "DFL device driver for Nios private feature on Intel PAC N3000".
It must be described clearly to avoid confusing.

> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xu Yilun <yilun.xu@intel.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/stddef.h>
> +#include <linux/spi/altera.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include "dfl.h"
> +
> +/**
> + * DOC: fec_mode (string)
> + *
> + * Require the NIOS firmware to set the FEC mode of the ethernet retimer
> on
> + * PAC N3000 FPGA card.
> + *
> + * "rs": RS FEC mode (default)
> + *
> + * "kr": KR FEC mode
> + *
> + * "no": NO FEC mode
> + *
> + * The configuration could only be set once after the board powers up, t=
he
> + * firmware will not accept a second configuration afterward. So the fec
> mode
> + * will not be changed if the module is reloaded with a different param
> value.
> + *
> + * The configured value of the fec_mode could be queried from sysfs node=
:
> + *
> + * /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode

s/dfl-fme.X.X/dfl-dev.X/

> + */
> +static char *fec_mode =3D "rs";
> +module_param(fec_mode, charp, 0444);
> +MODULE_PARM_DESC(child, "FEC mode");

Why it's child here? This description string doesn't help at all I think. :=
 (
You can put the description from code comments into this description.

> +
> +/* N3000 NIOS private feature registers */
> +#define NIOS_SPI_PARAM			0x8
> +#define PARAM_SHIFT_MODE_MSK		BIT_ULL(1)
> +#define PARAM_SHIFT_MODE_MSB		0
> +#define PARAM_SHIFT_MODE_LSB		1
> +#define PARAM_DATA_WIDTH		GENMASK_ULL(7, 2)
> +#define PARAM_NUM_CS			GENMASK_ULL(13, 8)
> +#define PARAM_CLK_POL			BIT_ULL(14)
> +#define PARAM_CLK_PHASE			BIT_ULL(15)
> +#define PARAM_PERIPHERAL_ID		GENMASK_ULL(47, 32)
> +
> +#define NIOS_SPI_CTRL			0x10
> +#define CTRL_WR_DATA			GENMASK_ULL(31, 0)
> +#define CTRL_ADDR			GENMASK_ULL(44, 32)
> +#define CTRL_CMD_MSK			GENMASK_ULL(63, 62)
> +#define CTRL_CMD_NOP			0
> +#define CTRL_CMD_RD			1
> +#define CTRL_CMD_WR			2
> +
> +#define NIOS_SPI_STAT			0x18
> +#define STAT_RD_DATA			GENMASK_ULL(31, 0)
> +#define STAT_RW_VAL			BIT_ULL(32)
> +
> +/* nios handshake registers, indirect access */

Ditto

> +#define NIOS_INIT			0x1000
> +#define NIOS_INIT_DONE			BIT(0)
> +#define NIOS_INIT_START			BIT(1)
> +/* Mode for PKVL A, link 0, the same below */
> +#define REQ_FEC_MODE_A0_MSK		GENMASK(9, 8)
> +#define REQ_FEC_MODE_A1_MSK		GENMASK(11, 10)
> +#define REQ_FEC_MODE_A2_MSK		GENMASK(13, 12)
> +#define REQ_FEC_MODE_A3_MSK		GENMASK(15, 14)
> +#define REQ_FEC_MODE_B0_MSK		GENMASK(17, 16)
> +#define REQ_FEC_MODE_B1_MSK		GENMASK(19, 18)
> +#define REQ_FEC_MODE_B2_MSK		GENMASK(21, 20)
> +#define REQ_FEC_MODE_B3_MSK		GENMASK(23, 22)
> +#define REQ_FEC_MODE_NO			0x0
> +#define REQ_FEC_MODE_KR			0x1
> +#define REQ_FEC_MODE_RS			0x2

What does REQ mean?

> +
> +#define NIOS_FW_VERSION			0x1004
> +#define NIOS_FW_VERSION_PATCH		GENMASK(23, 20)
> +#define NIOS_FW_VERSION_MINOR		GENMASK(27, 24)
> +#define NIOS_FW_VERSION_MAJOR		GENMASK(31, 28)
> +
> +#define PKVL_A_MODE_STS			0x1020
> +#define PKVL_B_MODE_STS			0x1024
> +#define PKVL_MODE_STS_GROUP_MSK		GENMASK(15, 8)
> +#define PKVL_MODE_STS_GROUP_OK		0x0
> +#define PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
> +
> +#define NS_REGBUS_WAIT_TIMEOUT	10000		/* loop count */
> +#define NIOS_INIT_TIMEOUT		10000000	/* usec */
> +#define NIOS_INIT_TIME_INTV		100000		/* usec */
> +
> +struct dfl_n3000_nios {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct platform_device *altera_spi;
> +};
> +
> +static int n3000_nios_writel(struct dfl_n3000_nios *ns, unsigned int reg=
,
> +			     unsigned int val)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(ns->regmap, reg, val);
> +	if (ret)
> +		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
> +			reg, val, ret);

Maybe this log printing should be added in regmap implementation side?
Then every user can save some code.

> +
> +	return ret;
> +}
> +
> +static int n3000_nios_readl(struct dfl_n3000_nios *ns, unsigned int reg,
> +			    unsigned int *val)
> +{
> +	int ret;
> +
> +	ret =3D regmap_read(ns->regmap, reg, val);
> +	if (ret)
> +		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
> +
> +	return ret;
> +}
> +
> +static ssize_t nios_fw_version_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_n3000_nios *ns =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%x.%x.%x\n",
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
> +}
> +static DEVICE_ATTR_RO(nios_fw_version);
> +
> +static ssize_t fec_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_n3000_nios *ns =3D dev_get_drvdata(dev);
> +	unsigned int val, mode;
> +	int ret;
> +
> +	ret =3D n3000_nios_readl(ns, NIOS_INIT, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * FEC mode should always be the same for all links, as we set them
> +	 * in this way.
> +	 */
> +	mode =3D FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
> +	if (mode !=3D FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
> +	    mode !=3D FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
> +		return -EFAULT;
> +
> +	switch (mode) {
> +	case REQ_FEC_MODE_NO:
> +		return sprintf(buf, "no\n");
> +	case REQ_FEC_MODE_KR:
> +		return sprintf(buf, "kr\n");
> +	case REQ_FEC_MODE_RS:
> +		return sprintf(buf, "rs\n");
> +	}
> +
> +	return -EFAULT;
> +}
> +static DEVICE_ATTR_RO(fec_mode);
> +
> +static struct attribute *n3000_nios_attrs[] =3D {
> +	&dev_attr_nios_fw_version.attr,
> +	&dev_attr_fec_mode.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(n3000_nios);
> +
> +static bool init_error_detected(struct dfl_n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val))
> +		return true;
> +
> +	if (FIELD_GET(PKVL_MODE_STS_GROUP_MSK, val) =3D=3D
> PKVL_MODE_STS_GROUP_OK)
> +		return true;
> +
> +	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val))
> +		return true;
> +
> +	if (FIELD_GET(PKVL_MODE_STS_GROUP_MSK, val) =3D=3D
> PKVL_MODE_STS_GROUP_OK)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void dump_error_stat(struct dfl_n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val)) {
> +		dev_err(ns->dev, "Could not read register
> PKVL_A_MODE_STS\n");

Why similar error log here again?

> +		return;
> +	}
> +
> +	dev_info(ns->dev, "PKVL_A_MODE_STS %x\n", val);
> +
> +	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val)) {
> +		dev_err(ns->dev, "Could not read register
> PKVL_B_MODE_STS\n");
> +		return;
> +	}
> +
> +	dev_info(ns->dev, "PKVL_B_MODE_STS %x\n", val);
> +}
> +
> +static int n3000_nios_init_done_check(struct dfl_n3000_nios *ns)
> +{
> +	struct device *dev =3D ns->dev;
> +	unsigned int val, mode;
> +	int ret;
> +
> +	/*
> +	 * this SPI is shared by NIOS core inside FPGA, NIOS will use this SPI
> +	 * master to do some one time initialization after power up, and then
> +	 * release the control to OS. driver needs to poll on INIT_DONE to
> +	 * see when driver could take the control.
> +	 *
> +	 * Please note that after 3.x.x version, INIT_START is introduced, so
> +	 * driver needs to trigger START firstly and then check INIT_DONE.
> +	 */
> +
> +	ret =3D n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If NIOS version register is totally uninitialized(=3D=3D 0x0), then =
the
> +	 * NIOS firmware is missing. So host could take control of SPI master
> +	 * safely, but initialization work for NIOS is not done. This is an
> +	 * issue of FPGA image. We didn't error out because we need SPI
> master
> +	 * to reprogram a new image.
> +	 */
> +	if (val =3D=3D 0) {
> +		dev_warn(dev, "NIOS version reg =3D 0x%x, skip INIT_DONE
> check, but PKVL may be uninitialized\n",
> +			 val);
> +		return 0;
> +	}
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >=3D 3) {
> +		/* read NIOS_INIT to check if PKVL INIT done or not */
> +		ret =3D n3000_nios_readl(ns, NIOS_INIT, &val);
> +		if (ret)
> +			return ret;
> +
> +		/* check if PKVLs are initialized already */
> +		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
> +			goto nios_init_done;
> +
> +		/* configure FEC mode per module param */
> +		val =3D NIOS_INIT_START;
> +
> +		/* FEC mode will be ignored by hardware in 10G mode */
> +		if (!strcmp(fec_mode, "no"))
> +			mode =3D REQ_FEC_MODE_NO;
> +		else if (!strcmp(fec_mode, "kr"))
> +			mode =3D REQ_FEC_MODE_KR;
> +		else if (!strcmp(fec_mode, "rs"))
> +			mode =3D REQ_FEC_MODE_RS;
> +		else
> +			return -EINVAL;
> +
> +		/* set the same FEC mode for all links */
> +		val |=3D FIELD_PREP(REQ_FEC_MODE_A0_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A1_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A2_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A3_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B0_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B1_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B2_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B3_MSK, mode);
> +
> +		ret =3D n3000_nios_writel(ns, NIOS_INIT, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +nios_init_done:
> +	/* polls on NIOS_INIT_DONE */
> +	ret =3D regmap_read_poll_timeout(ns->regmap, NIOS_INIT, val,
> +				       val & NIOS_INIT_DONE,
> +				       NIOS_INIT_TIME_INTV,
> +				       NIOS_INIT_TIMEOUT);
> +	if (ret) {
> +		dev_err(dev, "NIOS_INIT_DONE %s\n",
> +			(ret =3D=3D -ETIMEDOUT) ? "timed out" : "check error");
> +		goto dump_sts;
> +	}
> +
> +	/*
> +	 * after INIT_DONE is detected, it still needs to check if any ERR
> +	 * detected.
> +	 * We won't error out here even if error detected. Nios will release
> +	 * spi controller when INIT_DONE is set, so driver could continue to
> +	 * initialize spi controller device.
> +	 */
> +	if (init_error_detected(ns)) {
> +		dev_warn(dev, "NIOS_INIT_DONE OK, but err found during
> init\n");
> +		goto dump_sts;
> +	}
> +	return 0;
> +
> +dump_sts:
> +	dump_error_stat(ns);
> +
> +	return ret;
> +}
> +
> +struct spi_board_info m10_n3000_info =3D {
> +	.modalias =3D "m10-n3000",
> +	.max_speed_hz =3D 12500000,
> +	.bus_num =3D 0,
> +	.chip_select =3D 0,
> +};
> +
> +static int create_altera_spi_controller(struct dfl_n3000_nios *ns)
> +{
> +	struct altera_spi_platform_data pdata =3D { 0 };
> +	struct platform_device_info pdevinfo =3D { 0 };
> +	void __iomem *base =3D ns->base;
> +	u64 v;
> +
> +	v =3D readq(base + NIOS_SPI_PARAM);
> +
> +	pdata.mode_bits =3D SPI_CS_HIGH;
> +	if (FIELD_GET(PARAM_CLK_POL, v))
> +		pdata.mode_bits |=3D SPI_CPOL;
> +	if (FIELD_GET(PARAM_CLK_PHASE, v))
> +		pdata.mode_bits |=3D SPI_CPHA;
> +
> +	pdata.num_chipselect =3D FIELD_GET(PARAM_NUM_CS, v);
> +	pdata.bits_per_word_mask =3D
> +		SPI_BPW_RANGE_MASK(1, FIELD_GET(PARAM_DATA_WIDTH,
> v));
> +
> +	pdata.num_devices =3D 1;
> +	pdata.devices =3D &m10_n3000_info;
> +
> +	dev_dbg(ns->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> +		pdata.num_chipselect, pdata.bits_per_word_mask,
> +		pdata.mode_bits);
> +
> +	pdevinfo.name =3D "subdev_spi_altera";
> +	pdevinfo.id =3D PLATFORM_DEVID_AUTO;
> +	pdevinfo.parent =3D ns->dev;
> +	pdevinfo.data =3D &pdata;
> +	pdevinfo.size_data =3D sizeof(pdata);
> +
> +	ns->altera_spi =3D platform_device_register_full(&pdevinfo);
> +	return PTR_ERR_OR_ZERO(ns->altera_spi);
> +}
> +
> +static void destroy_altera_spi_controller(struct dfl_n3000_nios *ns)
> +{
> +	platform_device_unregister(ns->altera_spi);
> +}
> +
> +/* ns is the abbreviation of nios_spi */
> +static int ns_bus_poll_stat_timeout(void __iomem *base, u64 *v)

Why adding "bus" here? I just see it's polling on register bits, right?
It's a little confusing on ns_bus.

> +{
> +	int loops =3D NS_REGBUS_WAIT_TIMEOUT;
> +
> +	/*
> +	 * We don't use the time based timeout here for performance.
> +	 *
> +	 * The image reprograming engine is on max10 bmc chip, which is the
> spi
> +	 * device connected to altera spi controller. So the regbus read/write
> +	 * is on the critical path of PAC N3000 image reprograming. And
> usually
> +	 * the state changes in few loops, the time based timeout checking
> will
> +	 * add too much overhead on it.
> +	 *
> +	 * Anyway, 10000 times loop is large enough.
> +	 */
> +	do {
> +		*v =3D readq(base + NIOS_SPI_STAT);
> +		if (*v & STAT_RW_VAL)
> +			break;
> +		cpu_relax();
> +	} while (--loops);
> +
> +	return loops ? 0 : -ETIMEDOUT;
> +}
> +
> +static int ns_bus_reg_write(void *context, unsigned int reg, unsigned in=
t val)
> +{
> +	void __iomem *base =3D context;
> +	u64 v =3D 0;
> +
> +	v |=3D FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_WR);
> +	v |=3D FIELD_PREP(CTRL_ADDR, reg);
> +	v |=3D FIELD_PREP(CTRL_WR_DATA, val);
> +	writeq(v, base + NIOS_SPI_CTRL);
> +
> +	return ns_bus_poll_stat_timeout(base, &v);
> +}
> +
> +static int ns_bus_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	void __iomem *base =3D context;
> +	u64 v =3D 0;
> +	int ret;
> +
> +	v |=3D FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_RD);
> +	v |=3D FIELD_PREP(CTRL_ADDR, reg);
> +	writeq(v, base + NIOS_SPI_CTRL);
> +
> +	ret =3D ns_bus_poll_stat_timeout(base, &v);
> +	if (!ret)
> +		*val =3D FIELD_GET(STAT_RD_DATA, v);
> +
> +	return ret;
> +}
> +
> +static const struct regmap_config ns_regbus_cfg =3D {
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.fast_io =3D true,
> +
> +	.reg_write =3D ns_bus_reg_write,
> +	.reg_read =3D ns_bus_reg_read,
> +};
> +
> +static int dfl_n3000_nios_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev =3D &dfl_dev->dev;
> +	struct dfl_n3000_nios *ns;
> +	int ret;
> +
> +	ns =3D devm_kzalloc(dev, sizeof(*ns), GFP_KERNEL);
> +	if (!ns)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&dfl_dev->dev, ns);
> +
> +	ns->dev =3D dev;
> +
> +	ns->base =3D devm_ioremap_resource(&dfl_dev->dev, &dfl_dev-
> >mmio_res);
> +	if (IS_ERR(ns->base)) {
> +		dev_err(dev, "get mem resource fail!\n");

devm_ioremap_resource should print some error message, will that be enough?

> +		return PTR_ERR(ns->base);
> +	}
> +
> +	ns->regmap =3D devm_regmap_init(dev, NULL, ns->base,
> &ns_regbus_cfg);
> +	if (IS_ERR(ns->regmap))
> +		return PTR_ERR(ns->regmap);
> +
> +	ret =3D n3000_nios_init_done_check(ns);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D create_altera_spi_controller(ns);
> +	if (ret)
> +		dev_err(dev, "altera spi controller create failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void dfl_n3000_nios_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_n3000_nios *ns =3D dev_get_drvdata(&dfl_dev->dev);
> +
> +	destroy_altera_spi_controller(ns);
> +}
> +
> +#define FME_FEATURE_ID_N3000_NIOS	0xd
> +
> +static const struct dfl_device_id dfl_n3000_nios_ids[] =3D {
> +	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
> +	{ }
> +};
> +
> +static struct dfl_driver dfl_n3000_nios_driver =3D {
> +	.drv	=3D {
> +		.name       =3D "dfl-n3000-nios",
> +		.dev_groups =3D n3000_nios_groups,
> +	},
> +	.id_table =3D dfl_n3000_nios_ids,
> +	.probe   =3D dfl_n3000_nios_probe,
> +	.remove  =3D dfl_n3000_nios_remove,
> +};
> +
> +module_dfl_driver(dfl_n3000_nios_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, dfl_n3000_nios_ids);
> +MODULE_DESCRIPTION("DFL N3000 NIOS driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4


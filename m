Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B8240226
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Aug 2020 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgHJHAq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Aug 2020 03:00:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:17403 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgHJHA3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Aug 2020 03:00:29 -0400
IronPort-SDR: Di75cboBqSF+FKuKmg1pcNcl41yOJBdWTX9YBFuNFt1apqRp+mdXJa0pJjzLfQcJ6Q5IIXNoX0
 i2HSpzt02+Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="217828246"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="217828246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 00:00:23 -0700
IronPort-SDR: wSOmBzl/jFzS4Ud0k2A8/fUl3JmR0LSiAzVJdeiZNAZNy28L52hp2xwneQFh7n9Gp914wS3vxH
 QQsMze8baG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="307990070"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2020 00:00:22 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 00:00:22 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 00:00:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 00:00:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgaAzCeoVToUvt7xJHu9EIG2HWh98VRtXhfbkFeYvs0rqZiPwmC6pxbc+uqBATUx8P+up8ykuSfEgdvJ5NmUPM/d05TTVfpcHdofSoA66XDU2LAk/yTPFkT/HjLGkaDDtlXIMGdxeSxN0eWT1O14LdFTZb8QuzfkkVmVbshkp0sZBTkhi3HQZhbYgzhX4gFN9mA9HQ+hpKUTMumDuyXjebofPjpzPLAt5hopEwyDts7iLh3FQ26uK+VC6NThM9wwkYSzRJIGQyygozy4lXuPjgcfyNBX3gAIBDkwWga1XX/15y+/3XtePJMP2uOuBdo8wPGwLfz7dC+rsW8RIWFaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvb3PyYmKJ9KVT5V1K20rcct9HMc0sBKyDk0zfWtdK8=;
 b=N0FQqQgLyROOl5Fm5Y+YBI/vRQpTpwAjN2EdRW3mRDItuElNoDDpf5kduZM9IgONtdApBdX2kUYd3LvF/CvbQMUMKsHrDN2VkI9PfYfxcy3tkO70a2s9GUASBh7BDrztZBsTdEY41kVSsC/Sr7d85LJzwZZCMN8PdVxQXEKug8/1Ns6sIgUjX+jDs3Tst6m7S2NeBOBNvA+NGbvXy7y/caaTE2mHlBb20Dr9DWt+4rGvisu9QwqAXuc6hGOraB3rPAab8KEP9WCCbsDmZ0cfaul80FV8q/LxBoL/UYp0gpkWzeo6fZfoLUWImyIs/fDfOX+wwEKPXA9Yd49vwzTwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvb3PyYmKJ9KVT5V1K20rcct9HMc0sBKyDk0zfWtdK8=;
 b=vMsO9rbvpuKMInImOrhJgZFmv5zSmNA8954/sgqWu7qYfUAWMyyn0HKJJopKtt1Q9dSmwnIumrgJxwX+A03PlADAlHW1JiYx15fBV1c3wP1SMQwKV2kdv0KDVpAINXBVGNzstjjNpOTG8r7ZZbc/H3zJ9OAUaNx0x7cHdyCoKoE=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4219.namprd11.prod.outlook.com (2603:10b6:5:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 07:00:08 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 07:00:08 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v4 4/4] fpga: dfl: add support for N3000 Nios private
 feature
Thread-Topic: [PATCH v4 4/4] fpga: dfl: add support for N3000 Nios private
 feature
Thread-Index: AQHWbsBaFjuOCKIHT0S5JT/Oy3III6kw4xyQ
Date:   Mon, 10 Aug 2020 07:00:08 +0000
Message-ID: <DM6PR11MB3819E95FA24F088EE44DD31B85440@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-5-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1597027273-25288-5-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbb95355-0e0f-4fc8-ddc3-08d83cfb0490
x-ms-traffictypediagnostic: DM6PR11MB4219:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB421975E00CDB859EAA99DA6985440@DM6PR11MB4219.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AbW+FUG9nc1/POtM1mwB+rHwUNpntQzLNOVlhY+neuqrWsxuGFU8r5GwD6xsz03gLZQWivO9ia+TusQ7yET8T9vx286VbLfuV9zh6JpWb2QXF6qxky0m1t+X6ZgJTFsVuA7/LkF5qIkLt7AgLnVgzt77dkMKkKzZU2ni/l3+jUuK3MsvnxSRCw606YQI+f9voFTPTalj00gNRwE/Vd4KCmZGD/ciYj/KZ0y+e6OSyVsGfVgFqS3Et7VOaXYRPDUaKYrZczT1ZTflRNn0quuaGE19XPWoTA9QuxjY9+c+k/XPFRfiOJsnQBl0m4pcdAfCEU1E35l+3Gs8N2yHKNZ3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(52536014)(66946007)(83380400001)(110136005)(64756008)(66556008)(76116006)(66446008)(316002)(5660300002)(8936002)(186003)(9686003)(26005)(54906003)(86362001)(4326008)(66476007)(30864003)(478600001)(55016002)(2906002)(6506007)(71200400001)(8676002)(33656002)(7696005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ajkfR1uciI6glDf2UWFYh5B6hoACMEKyKKW9prV4HhQWfKNzT5wmhSDpz5uG/WIR7pMW7fcCoHrZgq+uuplLUxb35hvOcmDPEs38v5fM0PhfNV4Mkrc1v/Dfbr1CWPp6ij0rbY3puz3GSL48BMVGtJSTgoRQDdYba0+gfvNcirI3s7qNX9D3ZCDRU6wAgXl/1C7UOTB71hMwSxl8OJ9oPtPgIS7XpruShJyV2HCYsPy8FgMwIajjepmSmMWx1SlCEYmXXTFPNEGKzmvQf2Wrkv35A1B9vGidgnTa/QoEzL6K48O2LH2JHZCFeCSJFkCCQUhhAXPmALIRY8r9NvUhC++XHahrYNerGmpkdy8KwGY7izxSyKX2L9cW/x4GuvRZjTwngCIjaYnliAH6mgc9ZtYjlKRWlT1Q4hAKS+1GIMXBObfKZ+rOq0dZ06z69M7BigPvXB1fAh63WP5OqUx+SBwXSN+YLYkGJsfBN2MwzcZu1uGMY35yvfbZFFoh+UcEbJJtgknne+7Ycv1nJ+gpg96eTQsVXGahuL5h7ZX31d6NKzp7p+eWsB6Y0uFK4kWf8kqiAb7jqpmtxXO/4gLPFsvb5kwC5qdcZjNRLE9wH6tZGI5WdAtInWH8zMSBhWNqKEx1qVHr+U/OMmila61nJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb95355-0e0f-4fc8-ddc3-08d83cfb0490
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 07:00:08.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPYDmVQnUmlkL+85d0Twxm65cxXW/jWsAanaxYsPevhBJKIkqjWGMEhB3zGvmrDITqy/lEWrnAwNcl7VwKneAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4219
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v4 4/4] fpga: dfl: add support for N3000 Nios private fea=
ture
>=20
> This patch adds support for the Nios handshake private feature on Intel
> N3000 FPGA Card.
>=20
> The terminology "Nios" stands for the NIOS II - 32 bit embedded soft
> processor designed for FPGAs. This private feature provides a handshake
> interface to FPGA Nois firmware, which receives retimer configuration
> command from host and executes via an internal SPI master. When Nios
> finishes the configuration, host takes over the ownership of the SPI
> master to control an Intel MAX10 BMC Chip on the SPI bus.
>=20
> For Nios firmware handshake part, this driver requests the retimer
> configuration for Nios with parameters from module param, and adds some
> sysfs nodes for user to query Nios state.
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
> v3: Add the doc for this driver
>     Minor fixes for comments from Tom
> v4: Move the err log in regmap implementation, and delete
>      n3000_nios_writel/readl(), they have nothing to wrapper now.
>     Some minor fixes and comments improvement.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
>  Documentation/fpga/dfl-n3000-nios.rst              |  41 ++
>  Documentation/fpga/index.rst                       |   1 +
>  drivers/fpga/Kconfig                               |  12 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 475 +++++++++++++++=
++++++
>  6 files changed, 549 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-
> n3000-nios
>  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> new file mode 100644
> index 0000000..4b2b9c5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> @@ -0,0 +1,18 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> +Date:		July 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the FEC mode of the ethernet retimer
> +		configured by NIOS firmware. "rs" for RS FEC mode, "kr" for
> +		KR FEC mode, "no" FOR NO FEC mode. The FEC mode could
> be set
> +		by module parameters, but it could only be set once after the
> +		board powers up.
> +		Format: string
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
> +Date:		July 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the NIOS firmware version in FPGA. It=
s
> +		format is "major.minor.patch".
> +		Format: %x.%x.%x
> diff --git a/Documentation/fpga/dfl-n3000-nios.rst
> b/Documentation/fpga/dfl-n3000-nios.rst
> new file mode 100644
> index 0000000..ecc14e3
> --- /dev/null
> +++ b/Documentation/fpga/dfl-n3000-nios.rst
> @@ -0,0 +1,41 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DFL N3000 Nios Private Feature Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The dfl N3000 Nios driver supports for the Nios handshake private featur=
e
> on
> +Intel N3000 FPGA Card.
> +
> +The terminology "Nios" stands for the NIOS II - 32 bit embedded soft
> processor
> +designed for FPGAs. This private feature provides a handshake interface =
to
> FPGA
> +Nios firmware, which receives the ethernet retimer configuration command
> from
> +host and does the configuration via an internal SPI master. When Nios
> finishes
> +the configuration, host takes over the ownership of the SPI master to
> control
> +an Intel MAX10 BMC Chip on the SPI bus.
> +
> +So the driver does 2 major tasks on probe, uses the Nios firmware to
> configure
> +the ethernet retimer, and then creates a spi master platform device with
> the
> +MAX10 device info in spi_board_info.
> +
> +Module Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The dfl N3000 Nios driver supports the following module parameters:
> +
> +* fec_mode: string
> +  Require the Nios firmware to set the FEC (Forward Error Correction) mo=
de
> of
> +  the ethernet retimer on the PAC N3000 FPGA card. The possible values
> could
> +  be:
> +
> +  - "rs": Reed Solomon FEC (default)
> +  - "kr": Fire Code FEC
> +  - "no": No FEC
> +
> +  The configuration can only be set once after the board powers up, the
> +  firmware will not accept second configuration afterward. So the fec mo=
de
> +  will not be changed if the module is reloaded with a different param v=
alue.
> +
> +  The configured value of the fec mode could be queried from sysfs node:
> +
> +  /sys/bus/dfl/devices/dfl_dev.X/fec_mode
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
> index 0000000..b3093a2
> --- /dev/null
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL device driver for Nios private feature on Intel PAC N3000
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
> +static char *fec_mode =3D "rs";
> +module_param(fec_mode, charp, 0444);
> +MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on
> PAC N3000 FPGA card");

Intel PAC..
> +
> +/* N3000 Nios private feature registers */
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
> +/* Nios handshake registers, indirect access */
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
> +static ssize_t nios_fw_version_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_n3000_nios *ns =3D dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
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
> +	ret =3D regmap_read(ns->regmap, NIOS_INIT, &val);
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
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return true;
> +
> +	if (FIELD_GET(PKVL_MODE_STS_GROUP_MSK, val) =3D=3D
> PKVL_MODE_STS_GROUP_OK)
> +		return true;
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
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
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return;
> +
> +	dev_info(ns->dev, "PKVL_A_MODE_STS %x\n", val);
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> +		return;
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
> +	 * this SPI is shared by Nios core inside FPGA, Nios will use this SPI
> +	 * master to do some one time initialization after power up, and then
> +	 * release the control to OS. driver needs to poll on INIT_DONE to
> +	 * see when driver could take the control.
> +	 *
> +	 * Please note that after 3.x.x version, INIT_START is introduced, so
> +	 * driver needs to trigger START firstly and then check INIT_DONE.
> +	 */
> +
> +	ret =3D regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If Nios version register is totally uninitialized(=3D=3D 0x0), then =
the
> +	 * Nios firmware is missing. So host could take control of SPI master
> +	 * safely, but initialization work for Nios is not done. This is an
> +	 * issue of FPGA image. We didn't error out because we need SPI
> master
> +	 * to reprogram a new image.
> +	 */
> +	if (val =3D=3D 0) {
> +		dev_warn(dev, "Nios version reg =3D 0x%x, skip INIT_DONE
> check, but PKVL may be uninitialized\n",

Seems no place introduced the PKVL or just use retimer to replace PKVL?

Thanks
Hao

> +			 val);
> +		return 0;
> +	}
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >=3D 3) {
> +		/* read NIOS_INIT to check if PKVL INIT done or not */
> +		ret =3D regmap_read(ns->regmap, NIOS_INIT, &val);
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

So always no fec mode from hardware? Or software should force it
in 10G mode? Or 10G mode, below code can be skipped?

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
> +		ret =3D regmap_write(ns->regmap, NIOS_INIT, val);
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
> +static int ns_poll_stat_timeout(void __iomem *base, u64 *v)
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
> +static int ns_reg_write(void *context, unsigned int reg, unsigned int va=
l)
> +{
> +	struct dfl_n3000_nios *ns =3D context;
> +	u64 v =3D 0;
> +	int ret;
> +
> +	v |=3D FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_WR);
> +	v |=3D FIELD_PREP(CTRL_ADDR, reg);
> +	v |=3D FIELD_PREP(CTRL_WR_DATA, val);
> +	writeq(v, ns->base + NIOS_SPI_CTRL);
> +
> +	ret =3D ns_poll_stat_timeout(ns->base, &v);
> +	if (ret)
> +		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
> +			reg, val, ret);
> +
> +	return ret;
> +}
> +
> +static int ns_reg_read(void *context, unsigned int reg, unsigned int *va=
l)
> +{
> +	struct dfl_n3000_nios *ns =3D context;
> +	u64 v =3D 0;
> +	int ret;
> +
> +	v |=3D FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_RD);
> +	v |=3D FIELD_PREP(CTRL_ADDR, reg);
> +	writeq(v, ns->base + NIOS_SPI_CTRL);
> +
> +	ret =3D ns_poll_stat_timeout(ns->base, &v);
> +	if (ret)
> +		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
> +	else
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
> +	.reg_write =3D ns_reg_write,
> +	.reg_read =3D ns_reg_read,
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
> +	if (IS_ERR(ns->base))
> +		return PTR_ERR(ns->base);
> +
> +	ns->regmap =3D devm_regmap_init(dev, NULL, ns, &ns_regbus_cfg);
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
> +MODULE_DESCRIPTION("DFL N3000 Nios private feature driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4


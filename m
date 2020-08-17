Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9140C2463A2
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Aug 2020 11:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHQJn5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Aug 2020 05:43:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:24243 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHQJn4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Aug 2020 05:43:56 -0400
IronPort-SDR: VdqGgTBftXhM1TUNcWzc6Q6rUN/aF9FD3FTLROdb5452O58Crtscm7Hut1y19IPSjrsqsxHzB+
 ciBO//fjhm4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="172722627"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="172722627"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 02:43:55 -0700
IronPort-SDR: Zt7RfYjoZHi6nJXinnWUiA16RLjtnY9kGBOqgWpzk9tBvCgd0/R6V+67y7egW4rZiR1kIrzde6
 xq5A9enlgCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="292384367"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 02:43:54 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 02:43:53 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 02:43:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 02:43:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 17 Aug 2020 02:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZWd1YepTT7ojEFhITvG6z6yXtYSsCdxDlnSL+WAQ7A61zoezCxasQ5V7EcpTlOlIIkjxLCWEI1LVC7kXPq++T+M0uPmlaDeZmGrClZfUiHN8BymkXDYWjolV5+N12FrN7j2MWcs49Gqtzx5fpUL4chAR9ono7566L2cDAELtCcUxXODowbbZQ6QRXSXsqxx7QVAQrQcJnVVe2YP73fTycH06XtVTKuulgxTSrjEBq03ASGzhCmqMz+JUuzs5NTHWqXEiGavQrnT0fR6OBe8/Q2N+KF8K5bzufPag5qESJB/YzBm6I9z00DrUkVqjhEn5iFF5CHivi3Y4reJEV6KXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTFoUY5Jz3BFDzvkfAv9cCY9nEt2APAO0uWOC+Y28Kg=;
 b=e1A4cd0IhVdPPdpEy0s1znKmuOrqz1x7xueeYLKxCIZoc1C3C2xLQh69aLz2qGJ25Le72zNDIsOET65ltDogMsLpV3JtwSbrr+uNHoSbL3l2nTSiDu9U6XCHGFgZjGfAwk7c+oGS5EWVNSQSiJCtt2d9ldr/Ccu0H8vWVg75o+WbV9oEzf9J/xmrTU8tocql4nde2X45XqUo5lT7vl9cIbec8SagucgM2/HpIO2z6/Zm+d/zXRn+EaDWmlKC0Kn9xsUv/FrugGLxju6xK6DQLhUk0iq6bpKCoujeGNMmSmskcF+8N5WDDlPDYj7nVa5vymUNuY09NlgUKVBGOP0AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTFoUY5Jz3BFDzvkfAv9cCY9nEt2APAO0uWOC+Y28Kg=;
 b=ujaJI6PMSV3MBeZIzWKGQZST6XZ1VyqdBNc12A08JSiqFrwqFyQdUaoVfEErJEo1Z3IZiBxnKyUGDlIAOuL+49kFmWWyM0b5xt67QfwtU1pKAKAxq/RFcmiYG8aj0Ncp0Ggm0xhVDWUt2ytCJenMoy1dIdyLAgsrRpi2ahPLwkI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3658.namprd11.prod.outlook.com (2603:10b6:5:142::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 09:43:51 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:43:51 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v6 3/3] fpga: dfl: add support for N3000 Nios private
 feature
Thread-Topic: [PATCH v6 3/3] fpga: dfl: add support for N3000 Nios private
 feature
Thread-Index: AQHWdHK+jHEg10awVU6wbNj41OuRaqk8Bz8Q
Date:   Mon, 17 Aug 2020 09:43:51 +0000
Message-ID: <DM6PR11MB3819D440AA27D2BC466B61E5855F0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1597653612-5064-1-git-send-email-yilun.xu@intel.com>
 <1597653612-5064-4-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1597653612-5064-4-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd5b729b-3450-4d5f-0cba-08d842920c96
x-ms-traffictypediagnostic: DM6PR11MB3658:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3658F5F3B68160F3B0179DBA855F0@DM6PR11MB3658.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IS9PI2hLe8PZnfwP7sYpXuSgKaptCHLLBcn622t+MFareWPP3lf7gLAYNQrE6u1AABCn4OgKdLXqG4sS8QKWwTbORyy/EUjEzNHielpgfSXdSDzSV3izbC+1Ic+LaaRmFKhwfso1PPyfEW9oqxXPCxzBMX1EU9kBDXCsAq4WgSXZ+7qoQA+/bZfoJXkUErdLYekqg/hHuTykGwHYflhEc21it+pe7jGZBtRPq6LkM3lBz/U7lNFDL9vvH1D9ujheSffDcg0i0itCXmyOVHBHyl1vVJmBGuEK7Ti1JdrRe4ccXDXdHNGztOPzNDfWc9aSW/+Ipk7o+I8iN/pK3XM1IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(316002)(6506007)(110136005)(54906003)(83380400001)(7696005)(5660300002)(26005)(86362001)(186003)(64756008)(33656002)(478600001)(30864003)(66476007)(66446008)(76116006)(66556008)(66946007)(52536014)(9686003)(8936002)(71200400001)(4326008)(2906002)(55016002)(8676002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: znf4TxHShjlZ5HnMIj1oU7d7SzVL7JlrzAzGGALNtHqCytnYcFuRKO++wj1wQdpc9vLcDbhauibtugY0Vy4I8xnl4NazQHoenAPOFAopprraTe4N7CIIXsHQvLeID/nZL9om7IuBaLPxuEp1uhqw0KbAqrlU2c3DWBIDsDUOmfmCYb3NJF7tPY1WomZCvo08lYh1GThUG8wePXv3EDdsTmjggZQtWpkr8BwHbXCBsEo2uQpCjQqxZySFaUPTWzRHGR82RMzmbkcvzsH6LBw2m8ppjSEyKF1Di7ssxKEolAXBWrvI+JjKUcJcMI8gmvnIykY8ehnpTSdP9Fx4MfksE6oC1zq0Re7Op7uDNQI3nQtN6xeUZZjiKTWMXGvG8NEwvyXSkeh21Ij6L/g7UlBXYckAdZu1wq4sCPXMP6dXGmDxRq6H2Ma1hJZN4J6FVyuRcF9ugPG90x54+4gCb+XjP4beWrhCeFE8lPmJddZQ421XCSUGh1Mq92vBQXyZcqisCvqKG0O6km8kchfSW3UbsRFzPO9n6gpfczPSn7H0bPZLi0u6S3XxWuiAzja0rhXhkvNI2q28Nh4Kdi0IUiJH2XtpWOZCB5JO0BMafq8X0KnNL3KvzgeFHxatZxgInG3WUKuP0Eep5eQoTV5kcCYEQg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5b729b-3450-4d5f-0cba-08d842920c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 09:43:51.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMfXy+CgMiQFaDJNnKJF70DJM1hinXeSlOld5KSGl980r6IldTRU75+BT9rqQX3H+hx82nRx92OSywe+J3gxxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3658
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v6 3/3] fpga: dfl: add support for N3000 Nios private fea=
ture
>=20
> This patch adds support for the Nios handshake private feature on Intel
> PAC (Programmable Acceleration Card) N3000.
>=20
> The Nios is the embedded processor on the FPGA card. This private feature
> provides a handshake interface to FPGA Nois firmware, which receives
> retimer configuration command from host and executes via an internal SPI
> master (spi-altera). When Nios finishes the configuration, host takes ove=
r
> the ownership of the SPI master to control an Intel MAX10 BMC (Board
> Management Controller) Chip on the SPI bus.
>=20
> For Nios firmware handshake part, this driver requests the retimer
> configuration for Nios with parameters from module param, and adds some
> sysfs nodes for user to query the onboard retimer's working mode and
> Nios firmware version.
>=20
> For SPI part, this driver adds a spi-altera platform device as well as
> the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> handle the following SPI work.
>=20
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

With some minor fixings below,

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

> ---
> v3: Add the doc for this driver
>     Minor fixes for comments from Tom
> v4: Move the err log in regmap implementation, and delete
>      n3000_nios_writel/readl(), they have nothing to wrapper now.
>     Some minor fixes and comments improvement.
> v5: Fix the output of fec_mode sysfs inf to "no" on 10G configuration,
>      cause no FEC mode could be configured for 10G.
>     Rename the dfl_n3000_nios_* to n3000_nios_*
>     Improves comments.
> v6: Fix the output of fec_mode sysfs inf to "not supported" if in 10G,
>      or the firmware version major < 3.
>     Minor fixes and improves comments.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  21 +
>  Documentation/fpga/dfl-n3000-nios.rst              |  79 +++
>  Documentation/fpga/index.rst                       |   1 +
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 539 +++++++++++++++=
++++++
>  6 files changed, 653 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-
> n3000-nios
>  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> new file mode 100644
> index 0000000..ce5b474
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the FEC mode of the 25G links of the
> +		ethernet retimers configured by NIOS firmware. "rs" for Reed
> +		Solomon FEC, "kr" for Fire Code FEC, "no" for NO FEC.
> +		"not supported" if the FEC mode setting is not supported,
> this
> +		happens when the Nios firmware version major < 3, or no
> link is
> +		configured to 25G. The FEC mode could be set by module

or all links are configured to 10G.

> +		parameters, but it could only be set once after the board
> +		powers up.
> +		Format: string
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
> +Date:		Aug 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the version of the NIOS firmware in
> FPGA.
> +		Its format is "major.minor.patch".
> +		Format: %x.%x.%x
> diff --git a/Documentation/fpga/dfl-n3000-nios.rst
> b/Documentation/fpga/dfl-n3000-nios.rst
> new file mode 100644
> index 0000000..276f93b
> --- /dev/null
> +++ b/Documentation/fpga/dfl-n3000-nios.rst
> @@ -0,0 +1,79 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +N3000 Nios Private Feature Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The N3000 Nios driver supports for the Nios handshake private feature on
> Intel
> +PAC (Programmable Acceleration Card) N3000.
> +
> +The Nios is the embedded processor in the FPGA, it will configure the 2
> onboard
> +ethernet retimers on power up. This private feature provides a handshake
> +interface to FPGA Nios firmware, which receives the ethernet retimer
> +configuration command from host and does the configuration via an
> internal SPI
> +master (spi-altera). When Nios finishes the configuration, host takes ov=
er
> the
> +ownership of the SPI master to control an Intel MAX10 BMC (Board
> Management
> +Controller) Chip on the SPI bus.
> +
> +So the driver does 2 major tasks on probe, uses the Nios firmware to
> configure
> +the ethernet retimer, and then creates a spi master platform device with
> the
> +MAX10 device info in spi_board_info.
> +
> +
> +Configuring the ethernet retimer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Intel PAC N3000 is a FPGA based SmartNIC platform which could be
> programmed
> +to various configurations (with different link numbers and speeds, e.g.
> 8x10G,
> +4x25G ...). And the retimer chips should also be configured correspondin=
gly
> by
> +Nios firmware. There are 2 retimer chips on the board, each of them
> supports 4
> +links. For example, in 8x10G configuration, the 2 retimer chips are both=
 set
> to
> +4x10G mode, while in 4x25G configuration, retimer A is set to 4x25G and
> retimer
> +B is in reset.

Only support 10G and 25G mode.

> +
> +For all 25G links, their FEC (Forward Error Correction) mode could be
> further
> +configured by Nios firmware for user's requirement. For 10G links, they
> don't
> +have the FEC mode at all, the firmware ignores the FEC mode setting for
> them.
> +The FEC setting is not supported if the firmware version major < 3.
> +
> +The retimer configuration can only be done once after the board powers u=
p,
> the
> +Nios firmware will not accept second configuration afterward. So it is n=
ot
> +proper for the driver to create a RW sysfs node for the FEC mode. A bett=
er
> way
> +is that the driver accepts a module parameter for the FEC mode, and does
> the
> +retimer configuration on driver probe, it also creates a RO sysfs node f=
or
> the
> +FEC mode query.
> +
> +Module Parameters
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The N3000 Nios driver supports the following module parameters:
> +
> +* fec_mode: string
> +  Require the Nios firmware to set the FEC mode for all 25G links of the
> +  ethernet retimers. The Nios firmware configures all these links with t=
he
> same
> +  FEC mode. The possible values of fec_mode could be:
> +
> +  - "rs": Reed Solomon FEC (default)
> +  - "kr": Fire Code FEC
> +  - "no": No FEC
> +
> +  Since the firmware doesn't accept second configuration, The FEC mode w=
ill
> not
> +  be changed if the module is reloaded with a different parameter value.
> +
> +  The parameter has no effect for 10G links. It has no effect to all the=
 links
> +  if firmware version major < 3.
> +
> +
> +Sysfs Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The driver creates the sysfs file in /sys/bus/dfl/devices/dfl_dev.X/
> +
> +* fec_mode:
> +  Read-only. It shows the FEC mode of the 25G links of the ethernet reti=
mers.
> +  The possible values are the same as the fec_mode module parameter. An
> extra
> +  value "not supported" is returned if firmware version major < 3, or no=
 link
> +  is configured to 25G.
> +
> +* nios_fw_version:
> +  Read-only. It shows the version of the Nios firmware in FPGA.
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
> index 7cd5a29..38c7130 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -191,6 +191,17 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>=20
> +config FPGA_DFL_NIOS_INTEL_PAC_N3000
> +        tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
> +        depends on FPGA_DFL
> +        select REGMAP
> +        help
> +	  This is the driver for the N3000 Nios private feature on Intel
> +	  PAC (Programmable Acceleration Card) N3000. It communicates
> +	  with the embedded Nios processor to configure the retimers on
> +	  the card. It also instantiates the SPI master (spi-altera) for
> +	  the card's BMC (Board Management Controller) control.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21df..18dc9885 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -44,5 +44,7 @@ dfl-fme-objs +=3D dfl-fme-perf.o
>  dfl-afu-objs :=3D dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs +=3D dfl-afu-error.o
>=20
> +obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+=3D dfl-n3000-nios.o
> +
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+=3D dfl-pci.o
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.=
c
> new file mode 100644
> index 0000000..52fffc1
> --- /dev/null
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL device driver for Nios private feature on Intel PAC (Programmable
> + * Acceleration Card) N3000
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
> Intel PAC N3000");
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
> +/* Mode for retimer A, link 0, the same below */
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
> +/* The retimers we use on Intel PAC N3000 is Parkvale, abbreviated to PK=
VL
> */
> +#define PKVL_A_MODE_STS			0x1020
> +#define PKVL_B_MODE_STS			0x1024
> +#define PKVL_MODE_STS_GROUP_MSK		GENMASK(15, 8)
> +#define PKVL_MODE_STS_GROUP_OK		0x0
> +#define PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
> +/* When GROUP MASK field =3D=3D GROUP_OK  */
> +#define PKVL_MODE_ID_RESET		0x0
> +#define PKVL_MODE_ID_4X10G		0x1
> +#define PKVL_MODE_ID_4X25G		0x2
> +#define PKVL_MODE_ID_2X25G		0x3
> +#define PKVL_MODE_ID_2X25G_2X10G	0x4
> +#define PKVL_MODE_ID_1X25G		0x5
> +
> +#define NS_REGBUS_WAIT_TIMEOUT		10000		/* loop count
> */
> +#define NIOS_INIT_TIMEOUT		10000000	/* usec */
> +#define NIOS_INIT_TIME_INTV		100000		/* usec */
> +
> +struct n3000_nios {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct platform_device *altera_spi;
> +};
> +
> +static ssize_t nios_fw_version_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct n3000_nios *ns =3D dev_get_drvdata(dev);
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
> +#define IS_MODE_STATUS_OK(mode_stat)				\
> +	(FIELD_GET(PKVL_MODE_STS_GROUP_MSK, (mode_stat)) =3D=3D	\
> +	 PKVL_MODE_STS_GROUP_OK)
> +
> +#define IS_RETIMER_FEC_SUPPORTED(retimer_mode)	\
> +	((retimer_mode) !=3D PKVL_MODE_ID_RESET &&	\
> +	 (retimer_mode) !=3D PKVL_MODE_ID_4X10G)
> +
> +static int get_retimer_mode(struct n3000_nios *ns, unsigned int
> mode_stat_reg,
> +			    unsigned int *retimer_mode)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(ns->regmap, mode_stat_reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return -EFAULT;
> +
> +	*retimer_mode =3D FIELD_GET(PKVL_MODE_STS_ID_MSK, val);
> +
> +	return 0;
> +}
> +
> +static ssize_t fec_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct n3000_nios *ns =3D dev_get_drvdata(dev);
> +	unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
> +	int ret;
> +
> +	/* FEC mode setting is not supported in early FW versions */
> +	ret =3D regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) < 3)
> +		return sprintf(buf, "not supported\n");
> +
> +	/* If no 25G links, FEC mode setting is not supported either */
> +	ret =3D get_retimer_mode(ns, PKVL_A_MODE_STS, &retimer_a_mode);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D get_retimer_mode(ns, PKVL_B_MODE_STS, &retimer_b_mode);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_RETIMER_FEC_SUPPORTED(retimer_a_mode) &&
> +	    !IS_RETIMER_FEC_SUPPORTED(retimer_b_mode))
> +		return sprintf(buf, "not supported\n");
> +
> +	/* get the valid FEC mode for 25G links */
> +	ret =3D regmap_read(ns->regmap, NIOS_INIT, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * FEC mode should always be the same for all links, as we set them
> +	 * in this way.
> +	 */
> +	fec_mode =3D FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
> +	if (fec_mode !=3D FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
> +	    fec_mode !=3D FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
> +		return -EFAULT;
> +
> +	switch (fec_mode) {
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
> +static int init_error_detected(struct n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return true;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return true;
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> +		return true;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void dump_error_stat(struct n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return;
> +
> +	dev_err(ns->dev, "PKVL_A_MODE_STS 0x%x\n", val);
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> +		return;
> +
> +	dev_err(ns->dev, "PKVL_B_MODE_STS 0x%x\n", val);
> +}
> +
> +static int n3000_nios_init_done_check(struct n3000_nios *ns)
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

It's must be very clear that, >=3D 3.0.0 version.

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

It's not very clear, why it's an issue of FPGA image. Should be "it" instea=
d of
"we"?

> +	 * to reprogram a new Nios firmware.
> +	 */
> +	if (val =3D=3D 0) {
> +		dev_err(dev, "Nios version reg =3D 0x%x, skip INIT_DONE check,
> but the retimer may be uninitialized\n",
> +			val);
> +		return 0;
> +	}
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >=3D 3) {
> +		/* read NIOS_INIT to check if retimer initialization is done */
> +		ret =3D regmap_read(ns->regmap, NIOS_INIT, &val);
> +		if (ret)
> +			return ret;
> +
> +		/* check if retimers are initialized already */
> +		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
> +			goto nios_init_done;
> +
> +		/* configure FEC mode per module param */
> +		val =3D NIOS_INIT_START;
> +
> +		/*
> +		 * When the retimer is to be set to 10G mode, there is no FEC
> +		 * mode setting, so the REQ_FEC_MODE field will be ignored
> by
> +		 * Nios firmware in this case. But we should still fill the FEC
> +		 * mode field cause host could not get the retimer working
> mode
> +		 * until the Nios init is done.
> +		 */
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

s/ERR/error/

> +	 * detected.
> +	 */
> +	if (init_error_detected(ns)) {
> +		/*
> +		 * We won't error out here even if error detected. Although
> the

Same?

> +		 * retimer configuration is fail, the Nios will still release
> +		 * the spi controller for host to communicate with the BMC.
> So
> +		 * the driver could continue to instantiate the spi controller
> +		 * device.
> +		 */
> +		dev_err(dev, "NIOS_INIT_DONE OK, but err found during
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
> +static int create_altera_spi_controller(struct n3000_nios *ns)
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
> +static void destroy_altera_spi_controller(struct n3000_nios *ns)
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
> +	 * The regbus read/write is on the critical path of Intel PAC N3000
> +	 * image programing. The time based timeout checking will add too
> much
> +	 * overhead on it. Usually the state changes in 1 or 2 loops on the
> +	 * test server, and we set 10000 times loop here for safety.
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
> +	struct n3000_nios *ns =3D context;
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
> +	struct n3000_nios *ns =3D context;
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
> +static int n3000_nios_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev =3D &dfl_dev->dev;
> +	struct n3000_nios *ns;
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
> +static void n3000_nios_remove(struct dfl_device *dfl_dev)
> +{
> +	struct n3000_nios *ns =3D dev_get_drvdata(&dfl_dev->dev);
> +
> +	destroy_altera_spi_controller(ns);
> +}
> +
> +#define FME_FEATURE_ID_N3000_NIOS	0xd
> +
> +static const struct dfl_device_id n3000_nios_ids[] =3D {
> +	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
> +	{ }
> +};
> +
> +static struct dfl_driver n3000_nios_driver =3D {
> +	.drv	=3D {
> +		.name       =3D "n3000-nios",
> +		.dev_groups =3D n3000_nios_groups,
> +	},
> +	.id_table =3D n3000_nios_ids,
> +	.probe   =3D n3000_nios_probe,
> +	.remove  =3D n3000_nios_remove,
> +};
> +
> +module_dfl_driver(n3000_nios_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, n3000_nios_ids);
> +MODULE_DESCRIPTION("DFL N3000 Nios private feature driver");

Let's unify this description here as well.

> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F31325026
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Feb 2021 14:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBYNIC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Feb 2021 08:08:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:16655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhBYNIA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Feb 2021 08:08:00 -0500
IronPort-SDR: YVATC/jrDeH4IH34hNxwnCOl4X0yFkOnVfXDlNU1v2xTbwkhxQ4dSdPC9QtUvCvsXQ0b0n2nvY
 l9sNIuSdeHgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="183053004"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="183053004"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 05:07:18 -0800
IronPort-SDR: s+yAFdjOPw9+ZGVdS8Wwa3ngPyfoAoyzjycSbwbZwSyRW3S0P/ZbZRhXA3NqKEWPk5zfJ6Nx1R
 Vfe+aYx+Gw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="594094066"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2021 05:07:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 05:07:18 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 05:07:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 25 Feb 2021 05:07:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 25 Feb 2021 05:07:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFe+XT+L0zsbgS4HVLyRNqndTDXQ77vQMp+0m51zH3VETh+VXcFtLFg79UNTDnBVubiQa8U3mEisF7W0dtPxrIbkK8t6zzL5GU+wAILctTuSg1ZHB1i5RAqyX6pPd3MOrT/TSFoYdmFBWw6ZF3f+p4Bl/8KQlJG/lSeVj08Gaz4v5XzE6/KN+grGQO+6adNjmUISwgYky9vqOlnjvgAS8o1CaqrifLnVV5013vFHb77tiqUXMLOTj1wrtGea8LX69wuD+9pQ8/7qS4qDVE2t5NoiDPi6l1DewKyeWdkGu/Ho8WUkevA5X2leT5nDO1C8jA+ae7HRjekTAYp7M+o2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0gaQmRz/9cKulq5Go0L5bPCjR/Km6iCOWmTHKS/W+o=;
 b=mVX2874GLoMmQeBNWY51MJ7HEVrhYi2tlE7qBWHp3/PToLc/P7gydG6XmzCZ/VeysPf1I1UMwAocC+7NOrKiM3he2fFxwWynKGcTQOvB5tG9KIpubeiyb+527ReauwSxvYaUkInVUzIR860Y4PhyoaTOAquxPOeU5XMk+zILXmwrQQSKTnBae3MILvuUwdMLHp8rsws2rHPGLEh+GVvlo0Vg4XQO7VjbjcDSo8kJWU5hQ0uMcH0Q84G7LqSu19ImUWTnEq8+/sRo/dzQIOyJIZod9GSyjkOw0IHvbZqPWPzKIfIfXTwAu/LXQQjpX6liBxJL4QKnIesc/b273o5iUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0gaQmRz/9cKulq5Go0L5bPCjR/Km6iCOWmTHKS/W+o=;
 b=sTS/XhHjS24mM7Qy/jiuMes9HTtLAOCYMlQ0TpvOSjABT24diOZ2SejyyUK8M+ovfuDHoPyImyuAMuIkffLE9IvXos8ginqYS38t7AAFeMjBLHAVNc/gFjNUycFOM74Jg6yJS/X48K7TOvfSnHAYNxTzsAeSkibeEUNAx46Ik1Q=
Received: from MWHPR11MB0015.namprd11.prod.outlook.com (2603:10b6:301:66::12)
 by MWHPR11MB1565.namprd11.prod.outlook.com (2603:10b6:301:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28; Thu, 25 Feb
 2021 13:07:14 +0000
Received: from MWHPR11MB0015.namprd11.prod.outlook.com
 ([fe80::98d5:e852:7771:8dfe]) by MWHPR11MB0015.namprd11.prod.outlook.com
 ([fe80::98d5:e852:7771:8dfe%6]) with mapi id 15.20.3846.045; Thu, 25 Feb 2021
 13:07:14 +0000
From:   "Gong, Richard" <richard.gong@intel.com>
To:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
Subject: RE: [PATCHv5 0/7]  Extend Intel service layer, FPGA manager and
 region
Thread-Topic: [PATCHv5 0/7]  Extend Intel service layer, FPGA manager and
 region
Thread-Index: AQHW/y9FNeB4/8Bh2EWxt3f+uoFq16po7q3A
Date:   Thu, 25 Feb 2021 13:07:14 +0000
Message-ID: <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [68.21.146.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aed3c8a3-1de3-4eda-fcd3-08d8d98e4574
x-ms-traffictypediagnostic: MWHPR11MB1565:
x-microsoft-antispam-prvs: <MWHPR11MB156566F66B031B9DC4823D88879E9@MWHPR11MB1565.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+m0rd0P2U091fWA8zMbSh/zBrwig/aaz8xb9qEfmpEVL14+Kw2V74kKd3qwY19ePR4H9AU77xybbgcPvgKgqt/rhkN6ctNyAMd5H90O+coYjtc49s55eTsrPY4G2TaKgHhVTzwtxWbjoHJGohZEfM84rjtWjSWzdVOTW0nL/aNUgWab4NCXyfNJnuDiaKS7aP6mL9x9kAqcuVsJ7dIVnd3S/SiLi1yOuCd7yqQuclsES8K5D08u/xBEMeCrBbS+4UtVTaKO3WDBANY/+y2234popFMJ5GfltbRtff0RewZUKz7t59qjZ/BlwWlijWZPXh6JemPaiRnaBHaT0zoDmMSS8k/4G9In9d+1l0WrZw1k5lqanIkG6IkhC0E3P5HaoBkptrlPW5fPwXV0CZ2uj5ZEBc7LvQyBrnW5ZQaSm2ezvrHApGrmpjM4wR4Nds65iKbFuw7iVtNOUfE2os2LirJWeZYjnnyQH4nRTamGJDk/oxb4twiOR/G+fht1e63r71y080Coyn/s2kU/f4qTNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(64756008)(71200400001)(66446008)(5660300002)(2906002)(110136005)(8936002)(8676002)(33656002)(478600001)(53546011)(26005)(7696005)(86362001)(84040400003)(6506007)(83380400001)(9686003)(66476007)(55016002)(66556008)(76116006)(66946007)(4326008)(316002)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TV87W5JgS9tQBO6b7ckpK957NTOQ5GAtoNoFI4ofp4TsJ0JTIcSzu+UUKEFn?=
 =?us-ascii?Q?er97oAHTrZdEbvYVNmGF1UEe40iLK0ZeSb0L0JBFypcvGsNDUf44Wiokg0RS?=
 =?us-ascii?Q?HRMqRG1cYTf92DP+5OOb7ns/+T0ouYf4YGWgdnRZmjNuPfZBgOkCtvLwG8uR?=
 =?us-ascii?Q?y3bFOMUB8Z2y5cjDMBMBY5QIPecnr4lhhL1llqiOV3f9ex+iFeBYsRyHNgN1?=
 =?us-ascii?Q?T88JJQtq0CvXgoudDyJjiGtIdD84PQmPzwWbWsaTLfxpvYEaqW6ntDhFEs4I?=
 =?us-ascii?Q?ED6Bq8sgfT8uAamrJZ4V++v+MCzFuIBmkv+OGBuYN2dMrOKYSIXxAvciOyXw?=
 =?us-ascii?Q?wqUWlJZOP9Y3tpKsWGdHC1v6UPFtykMSX0IMjN3iBtq1bctZVM1dVSq3xkdG?=
 =?us-ascii?Q?734YfYxrC/pwdvwlChVp20mHpaRg/hFAT1JT3KnWDYCIv+AC4jh/pU0bibcl?=
 =?us-ascii?Q?lKLhGglV9L7L65dkC1Ng9dWJNQVPr/ANfiJ6UPQnb5hcym+9RVb3fwmi+fx5?=
 =?us-ascii?Q?gT03z7SCY9riSS2sJxbc41J5kfuH7xn4p2flVC4ojywfcvpoU7MY0KdHqEFU?=
 =?us-ascii?Q?6ubgCiqJZcX7AnpSqB1lcj2faT04J41tXVJmhcUxtkKgA98NsYldLUB9n54m?=
 =?us-ascii?Q?RuIKPyRpcz1K1m7oDhqjPQs6S59YJ4YjFvTp1uhrc3jG+y9t4mGIOloed29Y?=
 =?us-ascii?Q?g5AsRKKnwixaPEOYoF/4PN6aKEGI1hYmRSuLbbE3CLGKFg2yH+9v308ZiaNH?=
 =?us-ascii?Q?ZucSjFgkUrBHRVmXUTSGB/uKuYojlgngPJCUddpnJ55+53E5+4gu/K1jt/ke?=
 =?us-ascii?Q?zNlPd+9iPVjefAIOqJsns2ig3LyIEorbrMv4NlA+tLM44xm04cH+KlGWABR5?=
 =?us-ascii?Q?6wpRG1WuO/RjRyZk8+PD1shKSYMo/63q1vNeEIxs7GUJ5kSSQ9zU5OjaR/KI?=
 =?us-ascii?Q?sfOI3x1rUzI2px2Qp8xFaHmF6Z1y8uT5EFIVpMPFFILLuEwHB3xYAhBiZFQM?=
 =?us-ascii?Q?8g6w6stdQU3PNJnF8ij6WRP5XJ52Xpv7sXpy76XNRcVg6MnHBu/uW/83MVNW?=
 =?us-ascii?Q?6siJ7CU811J2LLgwkdEEBsZIsgS+G64p7d/aPifDdCdiV3lRARCn4ApYXkeq?=
 =?us-ascii?Q?kHGX2o+0L8KhhzfqC8wPy6c/qQGqeNqv8wVb9RiHGgWDTY3Oj7zjErVH49CE?=
 =?us-ascii?Q?XALPxeanRQzs5qeOAMZ2dgcBFARiW3MfTD0p9XeP4OGZ5xW4ErLlWHDAapX9?=
 =?us-ascii?Q?UK/XXrLKXn7G9uHTdmugcnZDrmGbbkiQ1UHHL2u1rMQ7UIbNZogEYfKgKMqE?=
 =?us-ascii?Q?zCgO1Nk9Kh8riZg6KeMyXLrB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed3c8a3-1de3-4eda-fcd3-08d8d98e4574
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 13:07:14.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zne09Wh+ubdAJRQwAxC7tVagV0ayIMTjsq9GHhxCSMgsX0NcQMvHIUh+nfT+emqKS07NX2E/3FL5OQCjtlehmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

Sorry for asking.

When you have chance, can you help review the version 5 patchset submitted =
on 02/09/21?

Regards,
Richard

-----Original Message-----
From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>=20
Sent: Tuesday, February 9, 2021 4:20 PM
To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga=
@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Gong, Richard <richard.gong@intel.com>
Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region

From: Richard Gong <richard.gong@intel.com>

This is 5th submission of Intel service layer and FPGA patches, which inclu=
des the missing standalone patch in the 4th submission.

This submission includes additional changes for Intel service layer driver =
to get the firmware version running at FPGA SoC device. Then FPGA manager d=
river, one of Intel service layer driver's client, can decide whether to ha=
ndle the newly added bitstream authentication function based on the retriev=
ed firmware version. So that we can maintain FPGA manager driver the back c=
ompatible.

Bitstream authentication makes sure a signed bitstream has valid signatures=
.

The customer sends the bitstream via FPGA framework and overlay, the firmwa=
re will authenticate the bitstream but not program the bitstream to device.=
 If the authentication passes, the bitstream will be programmed into QSPI f=
lash and will be expected to boot without issues.

Extend Intel service layer, FPGA manager and region drivers to support the =
bitstream authentication feature.=20

Richard Gong (7):
  firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
  firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
  firmware: stratix10-svc: extend SVC driver to get the firmware version
  fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
  fpga: of-fpga-region: add authenticate-fpga-config property
  dt-bindings: fpga: add authenticate-fpga-config property
  fpga: stratix10-soc: extend driver for bitstream authentication

 .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
 drivers/firmware/stratix10-svc.c                   | 12 ++++-
 drivers/fpga/of-fpga-region.c                      | 24 ++++++---
 drivers/fpga/stratix10-soc.c                       | 62 ++++++++++++++++++=
+---
 include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
 .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
 include/linux/fpga/fpga-mgr.h                      |  3 ++
 7 files changed, 125 insertions(+), 18 deletions(-)

--
2.7.4


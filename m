Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2D1ABC9F
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441464AbgDPJQ1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 05:16:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:51144 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440234AbgDPIGz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 04:06:55 -0400
IronPort-SDR: UNXyBisfBdbIkFlJ9abnRQb+bEZM65WnsNXRlcNzPLwJmFraqDBneVEQGpvtYBTGxzeJazLPN1
 KqOWCf57bhkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:06:22 -0700
IronPort-SDR: DFTGoNJIc6gOtBQ0c0VA9eJF7kdDagdNl2QIHfugzrioU0dK0Fa/Y5z+l4Nn9noMDeqKafZjWj
 zoJLh0l1MSUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="277908531"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 01:06:22 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 01:06:21 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX155.amr.corp.intel.com (10.22.240.21) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 01:06:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 01:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLh3bFeNFP0o9eSLA+FBKGTcPfTcMqVAWgfmxgxeJatrsb8p9nmnvr4G68d49gEshnFupz+YnzHQJwcWVPvnyetEoXE19i7iLQtxAHtEEY+gGCZyfjj3dYYpN/rSyaDZj35u/w+YZJWfRxvV2Opp5vi3wKG2IDMoVQrX2ISWqhL+VXlUlVJN2ntvQ76wKBF2m00Muc6yCITXfsaQP6NSJWQTNadiSBcYu4P/M5E/jHunYiGfxUaDAIaTyPTKXdc5ZxKK9k8esD0wGEtHvWLC2R1UiaKAF4u77NsVZVZf3Y6idQdpS4C+qXTogGjfNJ0JsRwJy8FqRph+YjRMC8cajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqGPTpmakIKV7ZEIIwt7ru9Z4QDIzR0HelfcZjcfnIU=;
 b=KnHwtkj0bF8eDmWjGDouc2Avh3Ov7Ie/m+GnPWUX3gzMmX6fk7ozLLTrznDh6UnLaUdCfPW7002OJuEKU3gLhstWrzezZm207NHaci1rYEnfSomMhQsNSz241YwsoERD/Kk6QplpOZI6vLClRDtNg5HijO04k0Ycflco6A1UPsJFFuN8FKxPdKk324JS4Il1fsDJewI9VLQkYDOUaHgaS9t3yH5x/DsfVucEUeGGZTMHVpkCP6J8Z57MUsdf7aujiqB6w+yCpImT1sDs3EQBSBKtSpa6d4V+nipmRtv+l63IzEznrzJ7dvxz5wxj3OxCBb4XUZwoFdX6HT5/5sjU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqGPTpmakIKV7ZEIIwt7ru9Z4QDIzR0HelfcZjcfnIU=;
 b=WTUflOrJkYb4/LhaGX7/9yX6M2ujrxkk+Hl0sDjoikDdfxW6KboZnM4dVYD3QQX1gdcqx5Qkb/hK893mfkwmxZu1vhiGBqgE9r/ng50QAS/5A4gU9ZH7vKzMsraq9ilMC4JB4sH2fvb3e3SOliU2dCIomO86HAd2jnIWGOWn0sk=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Thu, 16 Apr
 2020 08:06:17 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 08:06:17 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: fix bug in port reset handshake
Thread-Topic: [PATCH 2/2] fpga: dfl: fix bug in port reset handshake
Thread-Index: AQHWE52IkB2SGtNF80OKjurJ2t/Pbah7ZCHw
Date:   Thu, 16 Apr 2020 08:06:17 +0000
Message-ID: <DM6PR11MB381991FD47E055D344B77D2985D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587006712-22696-3-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hao.wu@intel.com; 
x-originating-ip: [192.102.204.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5efc5064-f30c-45ef-5416-08d7e1dd0a68
x-ms-traffictypediagnostic: DM6PR11MB2809:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2809DDEE32B4FEC720EF203985D80@DM6PR11MB2809.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39860400002)(376002)(346002)(366004)(66476007)(64756008)(66446008)(6506007)(110136005)(478600001)(52536014)(54906003)(86362001)(316002)(55016002)(53546011)(5660300002)(66946007)(186003)(66556008)(71200400001)(76116006)(26005)(4326008)(9686003)(33656002)(7696005)(81156014)(8676002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j42wy1Kplr5sWdh1baHG2d+joJz/vjKshcnfcfhBXEHmyph4I4bKeLn7/x+Y8BbWXT+N5xvjBaA7CLWWsCQHI952NqCX1zu+owjNkAoCqkLY0MSCStZX8tk4PWHMBfPAuAp8fbYqH1FbTjR7vO2x1C9f9QGSXl2XU89WER7eI7axV6Bw2pkKAUDXXvd7lZa2PN3EYeOTOc31SHuHczDfq9H5q5DdTaRwAuXyjnx7qaOmBBscwHgrB475uLk7c0aSABtTfwsIZXfSDYQdUGAUofFfQX9wxq2dyGqXBgEYpBQEDizmhhAkmlF/JjcVTbhyhtKMtfW9t6/kdMr9WA0pIfMJ+nXZ/Q4d6peZbc/70q+42BIl5pgHJ23Bo1a0MVwpTBkUES7AUzPFf6DVplOq2N3BTqj8705GGfB2bmWXVztvsRgLUHDbtsvGdzcbF9+8
x-ms-exchange-antispam-messagedata: HanXiDOjuYvIIUmvkuJs6tahNeE2Tm6/C0u0vDrvz+aFcNAXDKDjwNiVSv0kzSvlflgNsnCrueP4ho4ilh4UUDV+Bhj+p1GhR44gvHwmWKyDuRLGprpHSXGmrz7NC4V0z4dLhPeNDW2K+T12JVyX9A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efc5064-f30c-45ef-5416-08d7e1dd0a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 08:06:17.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzO9Nhv19hktOBfWpDCQ5cWcMO+4IWiHgwmY/Zg8zqhhyH7H+X9lPPlFrW4OMECMjKDPmw+ZipTCohWCaYjysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Thursday, April 16, 2020 11:12 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Xu, Yilun <yilun.xu@intel.com>
> Subject: [PATCH 2/2] fpga: dfl: fix bug in port reset handshake
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> When putting the port in reset, driver must wait for the soft reset
> acknowledgment bit instead of the soft reset bit.
>=20
> Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Thanks for catching this.

Acked-by: Wu Hao <hao.wu@intel.com>

> ---
>  drivers/fpga/dfl-afu-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index b0c3178..3fa2c59 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
>  	 * on this port and minimum soft reset pulse width has elapsed.
>  	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
>  	 */
> -	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v &
> PORT_CTRL_SFTRST,
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
>  		dev_err(&pdev->dev, "timeout, fail to reset device\n");
>  		return -ETIMEDOUT;
> --
> 2.7.4


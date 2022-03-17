Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3154DBCA6
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 02:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbiCQBtG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 21:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQBtF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 21:49:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9EDAA;
        Wed, 16 Mar 2022 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647481670; x=1679017670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lVM+DtRh9yEhiN6ZwIiANEmzUeR3XeyCG3Y5/USt0Cc=;
  b=HYyRMDEk7LTWQccrSIMNK6qQ+1VMR36IVjoKsFzMSz2eEK0r9dRLg7sX
   im6ejsSW/0Uc6VkG7iSXb9vmhlYNOYFSot8AU22xlz6kFeaNIC7KbKL8j
   3Qomh6h6f7y/zSpbAd5kYoCzhxBvsh1pqtuAfuZ7Qj0XVfZH28GUjO5ew
   t1JTwDeKaSHLLe/A+gNsOTpFJY/QFEim3U5o+LW051dyeaCBiMxSBQAV8
   Eegnh/W8hXFxq86L1E6bMHNNyMSdkiCWlywsTSGZ4wR1bW6/XCXw0tW+3
   MeGXcX2TxWg4tlKFwl8Hk64pDaav5VsQ6NREkGyjk/eDLeBRYgGP53zZY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256709004"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256709004"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 18:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="550189698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 16 Mar 2022 18:47:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 18:47:48 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 18:47:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 18:47:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 18:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkWYz/P+xCW8WMm8PW15xm+Z5qrWoH8XOodT6ev/o17W3BAoe6sxzpahsZRBtUMwKPNEWHttquf3WffKB6MwGHq0SgIZ9AdrBv6rEtCVBM3qjqHvHjDYNmDFw8Yrx8CZVLOqEAEhKvK5lmIwH+vNWnEqhKp4t16EIulg6PPDqeFvSkq8KhEDy8Nylj9DZthTwjN0SCoUe+r7qXGIhXQdhk+tol8GrDAx1TJc8/HRqo4QqE1LahAtOS/kDyBpF+XESNH/trjIxJeoQYaBTub9MXJWDCh1McXhOBqdVwkI3+7ZT3ZjMbPsIL7g2HRT18tIy8rmegnRyOKv0WWsqo17Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNG2x6brF0AU8YILf0n935FBGLFzXPgDVXk2WZqAc+k=;
 b=Z9kVDl6zOiHitD8Tjm+JbyXnQWE05OTp9FntZkiFOQahvAhuEj4PuvrQitc9zIMLbR/yeg6kN7cOgQ+6DdAQagWvDpJttmQuXBX3bjJGQIb6NciHFIswdS/Wmn7KkVvifA0n1gWPVVL1FnN2wUjlpH7qKHP++tswMl87A8l+cm7lQRxhcNTLBQj07mfrmo8d+MRn/1efxOiGTbVyOxqg8KVUjPWC/6dcBw3oyDxD6EapBJ/ySEz2+ncmdy4T/w1m+IM9PJBNS+/79d0uRgh61xl7/fg9TlkEiz6csCOHzOIM6GPnZlTVg9Z/mLZHYTdHU9rpavdLCULJxdgZaliOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3816.namprd11.prod.outlook.com (2603:10b6:a03:f8::32)
 by DM6PR11MB2586.namprd11.prod.outlook.com (2603:10b6:5:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 17 Mar
 2022 01:47:45 +0000
Received: from BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55]) by BYAPR11MB3816.namprd11.prod.outlook.com
 ([fe80::b03a:2ea1:4a3d:1e55%4]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 01:47:45 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v3] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYNO3MXtNRF3jnJE2Dc78P5iqqW6zCxhFA
Date:   Thu, 17 Mar 2022 01:47:45 +0000
Message-ID: <BYAPR11MB3816A2AD9C59AC3A1B6494C485129@BYAPR11MB3816.namprd11.prod.outlook.com>
References: <20220311021121.1504442-1-tianfei.zhang@intel.com>
In-Reply-To: <20220311021121.1504442-1-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95760b3d-706e-45bf-1b84-08da07b821fa
x-ms-traffictypediagnostic: DM6PR11MB2586:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB25862474656C6CCAE66211AA85129@DM6PR11MB2586.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMOlvochkuyuKtlgfsyrimC4C3zeN8CXuraL3LVqg663SfO6Xj9c2wA3aziGPn4iyzBoSLDs1Ifxp/8B1kqykfIm019/HUawwPZ/jFVR56+uAiHgzRzMnp0Q+Bc7PppHJSpUZHkPWoUw3a7BATcfupvUygw6rJt7f2sAleMEWWLyRaeMDHrST1wAy0txusxrr03pw6tBHyHvVZDo8FrCNyCFj0HC4QNpo//kSs3Cr34IdPqM96W1qVthnbXKmRRXpzH+qGjJA4q96rkf18wDLwoVVT0RL4td28DewqK9B6+SSGx0uGjQTwIfhcpv1cFojhJrzsCdRE78+MujQSq1ES9zxKcSCMGVfgZ1Nxvnh37UmcOBDnDpHJkOCs9AeXkbBXpRXBvvphhOGKzxVKMNze8D1cvu2fHC5qIi8zQWgG6F/hQcOFWNPv0IfwNSFniSzBjfKtlREGU0n8DBbCZXK2uAaJ5Xp0PYqRUZZqe6EWzBuAmVkrZPsCBZD+mNf3W4yDM+2iqIRooSKHNR360ePPaJ/K9nPits3EIY00LDpzaRrmvidmUpfwPOaE/XhoQ2ybp9mRR7O9k9TsXw1z1JkmXzidci5nbKf8R1mYIcmUQLKLoVGTRSbPBgavOzlOTLmVk2Jk6QjHUELgC2erYjeYvu2PWbCKJ8fL93gN6GnpGROsDG60XzbAq8LBh1GVvDDr2Fv+Y/XZ5ALTDQPxGgktSwIZe9RMnFcZUBbHydFaQpoOGqjzHe4ZtjnUBfXMykydd6r/60DL99isC0gWJJTsVQf3z/rIqPxaRRn06t5wOGMmsvr39/jx4WVpx1ejusfXFT91WIviOAQp2yiUNhPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(71200400001)(76116006)(52536014)(64756008)(53546011)(7696005)(508600001)(6506007)(38100700002)(66946007)(26005)(5660300002)(33656002)(66556008)(66446008)(82960400001)(186003)(9686003)(122000001)(110136005)(66476007)(316002)(83380400001)(8676002)(4326008)(55016003)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyc7+rByeDKhuUgIrC82ahu/7FScB4c5z1n2uqW4yU9m+F+FOyPRcQHhhYzL?=
 =?us-ascii?Q?M2R6gfqEKbaNXmPfbI15kGnrD16cV4UHObH+W3Li0AYqipRiFGsF3GskytqJ?=
 =?us-ascii?Q?2F2TWn9grT+XZxzoVVE85o05r+ADbvgMqvCLKNBwL4MvFjscf6qjI3WGo0br?=
 =?us-ascii?Q?klOU7MBhqcI28w94+U0nYfs9i7be8fW+yyeFnR9x+WkiGPrY40GmeP20QmVv?=
 =?us-ascii?Q?1XGINZd/bP2WQ90yxA3/PK6lcX5XjpjSi90xoa6MECs97NbbW2zGGnReRa/d?=
 =?us-ascii?Q?V0ovXWu/44BWKl9ey5mp6I1cvz1dnZdLY1DTM2qZO7vNvMcuQ99ZcapkNfsT?=
 =?us-ascii?Q?Ik/8nH7HIGOIHa9D5TvJnT6jadOdzWWwb+wP8R2UVkvxOj9sxvViPx/Vxq8V?=
 =?us-ascii?Q?haddM18MszY1KugKprJcwRrONnF5A4nCvciQ+yjBWkiQXqovYWv8H8ptcDfm?=
 =?us-ascii?Q?Qf/HGvi6RIhAjYfpt5Fh/vzuipirGU1Hx/sA1HurOSjgekRm8eYeeMiZ1a8N?=
 =?us-ascii?Q?DURmeUbh9BqwApUWPPm+vK5ve6unOO0jVFOyLDsxnacWbvVWVMGVYleaxg+W?=
 =?us-ascii?Q?jXDelrJ7ds+Zm/Ics4eYvrrTYdQXPXx1dCbmhAOdhe4TEBimeeUt4zJAll0q?=
 =?us-ascii?Q?E06ia8a2lAlcfFaEG5c64ld6bPvxwTkgu8mQeL7r0dZvxbCrDpldKEnscEVQ?=
 =?us-ascii?Q?ZuvikmIMUTCViDb93Te3V/ArI0vTdu3nqt++2uJiUWEv/4YeI10VIQYVK9Yp?=
 =?us-ascii?Q?oAbKIkwB2Cm/Ta+GeEbXo2rF8VBjSezwJaIaYB5InWH8l/8V2hy7V8RU2mfc?=
 =?us-ascii?Q?IMvdpJufVCm5Eu9nCAChUaNOdvoai4twjOKd33ZZ+T7PEiywKuJVKArx96W3?=
 =?us-ascii?Q?U8j4I8Mm+YGmtVWMW6rDU7G5Mtkec6sO8GcgvB649rs8uUDgSjy+PZan8YNq?=
 =?us-ascii?Q?P6sBPFkC5CuTdWtPmugtrICc4bLpJRS470AkQZTriaUKQhIbJa3ku5ksii91?=
 =?us-ascii?Q?WEJQCT7ZJxXmo2rO90r0OixMDs3iocnDUHHwYv4U2dRsx+h1xi3uIjMmR9QJ?=
 =?us-ascii?Q?XkO50s336sKVnI9/eLXdhRoIb05Qk8Z+gY2hUyJV1aw4G1hCiO0hjDXl4Jut?=
 =?us-ascii?Q?K4Lp2ZKzOkTxqmLBQrvrJJDqRSYcuiZ9gQ7EwJvrWCuOP1LGJI96Q27duTy4?=
 =?us-ascii?Q?3wdlhj+xVpXETizrPfeXUexrhXaXTut9arUon0E9yd5kMJ8xdUC3ucPhikET?=
 =?us-ascii?Q?wS1m9lnctfilkRkB7wVj+MpKyr/OsTh+Vcic96H2t5l8inBXRWKNzgoWs6Kn?=
 =?us-ascii?Q?4o5mmQvM+fAdNG1t3yl97E9Io/iAE682zHynkcXQCDSzR0mElk8nwHTZv/cs?=
 =?us-ascii?Q?o7IZ9GLVN3QqE/o4U8NKHGg8ehoJsojpRYzo6iBxkHQT+yG+jbZn9ofUhDVu?=
 =?us-ascii?Q?E7KDO8FVIlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95760b3d-706e-45bf-1b84-08da07b821fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 01:47:45.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wwhf5mH/i+ftcyDsfb/IlDiCP8Xqrou6yUfe2obyziTkzIq3DIEnsMxzZ+5mkSmvONfM2ojHBJOgVk9OEMMXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Friday, March 11, 2022 10:11 AM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net; Zhang, Tianfei <tianfei.zhang@intel.com>
> Subject: [PATCH v3] fpga: dfl: check feature type before parse irq info
>=20
> The feature ID of "Port User Interrupt" and the
> "PMCI Subsystem" are identical, 0x12, but one is for FME,
> other is for Port. It should check the feature type While
> parsing the irq info in parse_feature_irqs().
>=20

What about this
"Previously the feature IDs defined are unique, no matter which
feature type. But currently we want to extend its usage to have
a per-type feature ID space, so this patch adds feature type
checking as well just before look into feature ID for different
features which have irq info."

> ---
> v3: Remove "Fixes" in commit log with Hao's comment, this is a
>     extension not a bug fix.
>=20
> v2: add DFL Feature ID Registry in documentation.
>=20
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Move up your signed off line before these changelogs.=20

> ---
>  Documentation/fpga/dfl.rst | 11 +++++++++++
>  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
>  2 files changed, 33 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..14f342bb85e4 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,17 @@ Developer only needs to provide a sub feature driver
> with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme=
-pr.c)
>  could be a reference.
>=20
> +Individual DFL drivers are bound DFL devices based on Feature Type and
> Feature ID.
> +The definition of Feature Type and Feature ID can be found:
> +
> +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids=
.rst
> +
> +If you want to add a new feature ID for FPGA DFL feature device, we
> recommend that

"recommend" or "must"

> +use a pull request to reserve a feature ID for DFL. Here is the DFL Feat=
ure ID
> +Registry:
> +
> +https://github.com/OPAE/linux-dfl-feature-id
> +

Actually we don't have to put all details in kernel doc, and feature ID is =
used
inside the device, it could be used in linux or windows or other OS.
What about putting a README file in your repo to describe the detailed proc=
ess,
not in kernel doc. And we can just put a link to that README here.
Then split this one into another patch? How do you think?

>  Location of DFLs on a PCI Device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  The original method for finding a DFL on a PCI device assumed the start =
of the
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..6bff39ff21a0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  {
>  	void __iomem *base =3D binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr =3D 0;
> +	enum dfl_id_type type;
>  	int virq;
>  	u64 v;
>=20
> +	type =3D feature_dev_id_type(binfo->feature_dev);
> +
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
>  	 * current version DFL only provides mmio resources information for
> @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  	 * code will be added. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.
>  	 */
> -	switch (fid) {
> -	case PORT_FEATURE_ID_UINT:
> -		v =3D readq(base + PORT_UINT_CAP);
> -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -		break;
> -	case PORT_FEATURE_ID_ERROR:
> -		v =3D readq(base + PORT_ERROR_CAP);
> -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> -		break;
> -	case FME_FEATURE_ID_GLOBAL_ERR:
> -		v =3D readq(base + FME_ERROR_CAP);
> -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		break;
> +	if (type =3D=3D PORT_ID) {
> +		switch (fid) {
> +		case PORT_FEATURE_ID_UINT:
> +			v =3D readq(base + PORT_UINT_CAP);
> +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +			break;
> +		case PORT_FEATURE_ID_ERROR:
> +			v =3D readq(base + PORT_ERROR_CAP);
> +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +			break;
> +		}
> +	} else if (type =3D=3D FME_ID) {
> +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> +			v =3D readq(base + FME_ERROR_CAP);
> +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		}
>  	}
>=20
>  	if (!inr) {
> --
> 2.26.2


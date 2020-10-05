Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB58E28300B
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 07:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEFSx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 01:18:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:29337 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEFSx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Oct 2020 01:18:53 -0400
IronPort-SDR: saKvWjbad7nhq7FctxoPQQ8jYjHtFcSfEZU+YJOsLFcvL28wP9gifMt+Wl3U5bWLU9vmQ2XYee
 msKaAjk/vRFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="163435701"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="163435701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 22:18:48 -0700
IronPort-SDR: kcIllYgrvcUJQNatMxo5FWR/hw/N/q55N0ifuWyVi9zGJV9TocCU+Sbgf+QByeibP25liRF7RZ
 3G0TiViN62KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="326474436"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2020 22:18:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 4 Oct 2020 22:18:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 4 Oct 2020 22:18:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 4 Oct 2020 22:18:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 4 Oct 2020 22:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZpoNmo5oD78QOPkNL2WhK99opdKvd3CIS4MgYC/6kddLKqyCqNuOzPoZ8Wxm73xSc8DDoSj7lIAlL8YilZiP6PCbN59DPWThtyg4+rZtBXT0VEKUtEVAdVE8uKgQV4bnVydd4iL4HpHnYJOkswu4fTvGnGo8OtKam+xOYasxnyGOlBvqcitvBkTadWB7vEFU84i3JtE5Ox0DFsqL39Ivs+gAK70t6PiEGRvDJh69ArgdqWNVOzV+12SaZIrLJ5hIlqEDokOhzQKUBB/11GdnC9yatHnxzL5+Dx8WMuhs1QTYb72FJzvWVmTfOpAAbSguZrSS6JHMuaJVFo2jPWZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKoOUOuxYQPPiqtI+uQQ5eIHSvr5KAMH83uJ1GhQUpY=;
 b=lJ2mj/vN/TX6po+dwgp09VjHnSovohzD5myOBRYjbQf3h+JIAX539aSdkmU00eLoZ2HAFpmeHX1dY+c/TAKgbHxW8j9Gq59VK0RcH+paLSlBAmUJ4/5EH+OqEAY+VQwMbNkUD2eO6v7XOOIdzLsTktKZNfgMjqiFQLdCfSc1m2sXy3q7RhWpDOeJsh/1mRC7kRYeC9SIWpNklZ9x8psTMX8dcP9u+Juz+Xx4VB1osXs0FYzeY6O7JWAwoouDJExSD5NbC7WShivFsgFdVjDHcGLqkOCSeQtZgcaohEqmeh1HjDeeB1ggbxsllea0uALe2TcKdRMKO7ca+L9rZeMm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKoOUOuxYQPPiqtI+uQQ5eIHSvr5KAMH83uJ1GhQUpY=;
 b=k2xbJgnoWs44LyMHZGzLqaWhLHF7gvHFhdBlZdJTtY/oBcgNWsVXd0AfdD7LewNT2O6VG+9/erdXIcaypbPzFfOWhy1kJgbG+3egauJM2gENb97s6UHtj4SJjS088hVKApJ+7pusfk/AQVBS5iYvL4RjZnovD0ZXH0Krxwza4GE=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR1101MB2075.namprd11.prod.outlook.com (2603:10b6:4:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 05:18:40 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::8daf:2295:b5df:2c7e%3]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 05:18:40 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: RE: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Thread-Topic: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Thread-Index: AQHWmg1Ngfg1tE1JrUKRNw70LtcoGamIZl1g
Date:   Mon, 5 Oct 2020 05:18:40 +0000
Message-ID: <DM6PR11MB3819DC09D49EBE947F558F36850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-2-mdf@kernel.org>
In-Reply-To: <20201004051423.75879-2-mdf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761b25c0-3374-49a9-3872-08d868ee1f31
x-ms-traffictypediagnostic: DM5PR1101MB2075:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB20756BF870F19A4ECF1E3718850C0@DM5PR1101MB2075.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RX5nIgqxJYObmmmdLbN44bdNk3Tlj+PmRDU86MuLhWWVQIEuLY+cPdlFtK9ILu+LJIziHAWveqd8QsBppkpbCJKHq/mS78bSjdjs/TuxocfB543t9YSVp6NiJZlwzU/z7qyqNoQOBCvDCXgVX3KeENOp4k78zG/0Z1D9jgG8kNwqXbEImtOKwh63/0kChXyRBdDjQy13JR4nfVGntz3obM9rEJXkTGdag+4TYl6oOFxN/RnUCAOB9FIYDkj9JHitqJ5bP8Gv4Zl9Ga9O0H/4pPEgoAN1p/jsPJYpgDVaqxT+y9zjm5sQrF5Yn4Rd32xUbKEmwdu3602xSdP2Ik0VQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(107886003)(86362001)(83380400001)(7696005)(6506007)(26005)(478600001)(8676002)(33656002)(9686003)(8936002)(186003)(55016002)(110136005)(54906003)(71200400001)(66476007)(64756008)(66446008)(66556008)(66946007)(316002)(4326008)(52536014)(2906002)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UBp6TW4loedS5Dt22U0DIMHuOoEXsUetv/TqBeqpNPouMYLwlFIrHipIfT8LUfru/WQscWuKdC20kFWZucr3CXRHdFKVZmMmGJ4cjY5EdAkTBqWUk/5c/6HZKdglI90wl/j0UeWkGLSywv5OkUALU6Z053wPtbvqR+siwvZAyREV5graffiCfSKXUoYXoY9eh8LP4lI5hXSg5i/Gi7bTa2K73ILlKWdRYFmfmDe4eSuNnXMop7LrSgHVg8CvdoIPUvxPxI0i5cfB3IqKL0tLtkTGLOOK56+DaGE4rwY5Rbk8vytzl46Yhk73RrVucsmq0pf7PI40Vys9nOyd3TqWRm74P6JTcdB2MOc7rXBiBgCbVkc/cDxeGtby3c3wmvrN8LNdE3t8vngDsyWIMi7LB5E+xpC5jTy6G6BJUkxLCS+ZbsWbGS29SoVHYs+QmrSZoL4jfSZ8ybcV1UVx0gDj2fgDulpbY8OGDH7uFZTv4OhyJjDjeS1Xilp/Mzp2/H3EmdFMat8yZMZkUiQZZmisSpXbPPRy7oErHCSWKhUW5vOS4j6fzcQAAJdfeQ7z2csZAJFQGcXb5HD6KEo0dQ1dv1ERUi3Q0rVGSjdhA3Z48n9lmX8gCfc0v1pfhYiZ5ctAV/BWDNCgLO3VpCdvDp55hA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761b25c0-3374-49a9-3872-08d868ee1f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 05:18:40.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETCYjoykB/gBAxzk/tIaRwycoYRl0KBEVWtpFXU9YQmoM0tPdx0EmAp7WBEYTqIAVdWEmdMrveYK1r1MxKVb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2075
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
>=20
> Add a devm_fpga_mgr_register() API that can be used to register a FPGA
> Manager that was created using devm_fpga_mgr_create().
>=20
> Introduce a struct fpga_mgr_devres that makes the devres
> allocation a little bit more readable and gets reused for
> devm_fpga_mgr_create() devm_fpga_mgr_register().
>=20
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-mgr.c       | 76 ++++++++++++++++++++++++++++++-----
>  include/linux/fpga/fpga-mgr.h |  2 +
>  2 files changed, 68 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index f38bab01432e..774ac98fb69c 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -21,6 +21,10 @@
>  static DEFINE_IDA(fpga_mgr_ida);
>  static struct class *fpga_mgr_class;
>=20
> +struct fpga_mgr_devres {
> +	struct fpga_manager *mgr;
> +};
> +
>  /**
>   * fpga_image_info_alloc - Allocate a FPGA image info struct
>   * @dev: owning device
> @@ -651,21 +655,21 @@ struct fpga_manager
> *devm_fpga_mgr_create(struct device *dev, const char *name,
>  					  const struct fpga_manager_ops
> *mops,
>  					  void *priv)
>  {
> -	struct fpga_manager **ptr, *mgr;
> +	struct fpga_mgr_devres *dr;
>=20
> -	ptr =3D devres_alloc(devm_fpga_mgr_release, sizeof(*ptr),
> GFP_KERNEL);
> -	if (!ptr)
> +	dr =3D devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);

Should we update devm_fpga_mgr_release function to use fpga_mgr_devres as w=
ell?

> +	if (!dr)
>  		return NULL;
>=20
> -	mgr =3D fpga_mgr_create(dev, name, mops, priv);
> -	if (!mgr) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr =3D mgr;
> -		devres_add(dev, ptr);
> +	dr->mgr =3D fpga_mgr_create(dev, name, mops, priv);
> +	if (!dr->mgr) {
> +		devres_free(dr);
> +		return NULL;
>  	}
>=20
> -	return mgr;
> +	devres_add(dev, dr);
> +
> +	return dr->mgr;
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
>=20
> @@ -722,6 +726,58 @@ void fpga_mgr_unregister(struct fpga_manager
> *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>=20
> +static int fpga_mgr_devres_match(struct device *dev, void *priv,

Maybe it's better to use "res" instead of "priv" which matches the
dr_match_t, and also devm_fpga_mgr_release function.=20

> +				 void *match_data)
> +{
> +	struct fpga_mgr_devres *dr =3D priv;
> +
> +	return match_data =3D=3D dr->mgr;
> +}
> +
> +static void devm_fpga_mgr_unregister(struct device *dev, void *priv)
> +{

Same.

> +	struct fpga_mgr_devres *dr =3D priv;
> +
> +	fpga_mgr_unregister(dr->mgr);
> +}
> +
> +/**
> + * devm_fpga_mgr_register - resource managed variant of
> fpga_mgr_register()
> + * @dev: managing device for this FPGA manager
> + * @mgr: fpga manager struct
> + *
> + * This is the devres variant of fpga_mgr_register() for which the unreg=
ister
> + * function will be called automatically when the managing device is
> detached.
> + */
> +int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> +{
> +	struct fpga_mgr_devres *dr;
> +	int err;
> +
> +	/* Make sure that the struct fpga_manager * that is passed in is
> +	 * managed itself.
> +	 */

Should we use the same style for code comments here,=20
I see other places in this file are using style like

/*
  * ......
  */

Thanks
Hao

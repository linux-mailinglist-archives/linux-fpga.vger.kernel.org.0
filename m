Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A153C40E6
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Jul 2021 03:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGLBbK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Jul 2021 21:31:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:56727 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhGLBbJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Jul 2021 21:31:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209880808"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209880808"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 18:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="486118356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2021 18:28:20 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 11 Jul 2021 18:28:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 11 Jul 2021 18:28:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 11 Jul 2021 18:28:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 11 Jul 2021 18:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNkv8YssMxs1EPNg36ulJrF6M0GjPq8yWly+YsLq/ba022CsI9W0oQYRdg1t5XG0jCKMyaJ47/x9BbPuYdWiBR6V48mMyrQXawO9GhmEo8/wr6066lKyHFaT6Xva+iAnZUk4huTl+UFbtZzgLVn/RTco3rMyl7IiXoWKE6UpccnCwsckrfGYzWx3QYX3F/B7CRKON2WRYcjKGndkLOB8O+V6rrEQqynypVSxXuJxK8ZQyOtkXpaxy/69GM1egBXPta5z9JatBQMLCYy+GUGvWAu9wGyXiluE4GLrhKmxu2sxazHGW1ZC6s02XFmS8I0zU1TOLaThrhCzEYvW+JdziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9G7mNCRY6KWADUgEC2QbQTLuKw/inKoxFJ6WwqDsug=;
 b=HwfBWhiti0N1oLloM1uo6ss/B6k5eCvuyVbrNcDk3FnKjWsCYAuiuOhp8Vrao0t0tA/Ov61m72HedWakOSNTEA1s0c088Hrm/AeWMC8/FzJNu7Yu6uyC1qZxdzQfViwHt3g/KwNhLDIzUNE7iQnBcT1YBQryxqU4j4FEwt/wDWOJofZlonMD4oG5+LvjtDsviyygNyno00Eehb8V2tFlG6SWhlRe602I4nVcuaK+CPPVUgNW0yHm8gzvEiWgXfprcCBFcSiORpEb94/MlAbl4LEclFHAfZOz3WMDAWS7TobfrlupdvxwNJHD+CxJIFW39CJ4uI4mKoibL34RgOVkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9G7mNCRY6KWADUgEC2QbQTLuKw/inKoxFJ6WwqDsug=;
 b=RAQqSUOc3cNlywURgUb+oVOPiHlbhSlRV38TUyUTHKWKZIK4eBbshCQ9bPKc47LTWchd3dFViSwxQd8kwYOvCuNx4pWWGaLYaU9RvNTcW6xcMTineuDFBf3Wyd4Ta1HJ5rHFmCx/7I1xmCa76f76wf7QIAMIPELkVB8Kc8iTPiE=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4594.namprd11.prod.outlook.com (2603:10b6:5:2a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 01:27:51 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 01:27:51 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] fpga: dfl: implement the compat_id_show region op
Thread-Topic: [PATCH v2 3/4] fpga: dfl: implement the compat_id_show region op
Thread-Index: AQHXdMhaYtV05DKfXECOPKHkfysLZKs+jdGA
Date:   Mon, 12 Jul 2021 01:27:51 +0000
Message-ID: <DM6PR11MB381991CB430F222FE05EE88D85159@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210709134229.2510349-1-trix@redhat.com>
 <20210709134229.2510349-5-trix@redhat.com>
In-Reply-To: <20210709134229.2510349-5-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83986f0-9008-41a9-1a18-08d944d4441f
x-ms-traffictypediagnostic: DM6PR11MB4594:
x-microsoft-antispam-prvs: <DM6PR11MB45948FDCE28BF647590519C385159@DM6PR11MB4594.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ytsu+sxrmeDhOlzzN/l0Rklc1X9B1pJry57no5gHTgSOz/JGu0tU34aen5xjF+R/7JpDibtkUrDyCZUjDJK7uuPUM0BAOm2YVOPLsIwtqs99SmJEmTsQ033+BIm49GVoi41H6muIbBZgI1Aa+RxiGxb8zEw0/gu9IPlnPW4gQy8Nr8hef4X8S5WtEmzUJAINkNcyIMR7cvmDJZGI465A5u7HwOdNgkyKv7EgjbPpO/Yie4grcBBH9EBAyU8AFjYR3WD+XTHpQHACRpJuc1EYZRANs4K7gA/erPv5hxLAJdz0krCFTtvwUsSjHKlmehH/tpk26CmpOBEJrd43r5r9yrtE+TVhZ5Y9VhXUz5+NQt+0bC0Vi/bocgYNgGUXVoCJspLD63oG9jFz68GXmjnIBWa5USw3cgqvtq4uxHr2R7S7+12TbwNMxMMqnlKQdSYNe7dUTMUUUMdhCf1SETs412YgNMTD4FSZW/6kCkV6cjC2lwqQdRtibfx2HnqEu98YUBofvgTEKRtLIZPZOXEBGOY2VivUOX4A+RncOPwvH9TNjNic8E3IqA6RlYGuFg2/I73Dg+u2SrPWugfCvTDE0IrmRMaYzT8DnPC1YOAYJSwrlYIFLlvWFMN/nAjaw5sibT9H35Sr2uLHJtwUUcr7Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(76116006)(5660300002)(7696005)(6506007)(8936002)(66946007)(55016002)(478600001)(66446008)(64756008)(66476007)(2906002)(66556008)(83380400001)(8676002)(4326008)(52536014)(71200400001)(186003)(86362001)(38100700002)(122000001)(54906003)(33656002)(110136005)(9686003)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fw0oQlYMSpheSyasGfRx/+QWLlnLy0OXJUCSwRJPy4h/JQtGzeM8z06lHR4J?=
 =?us-ascii?Q?687+ygYEVYSaj2zcZYObVArXOWa4no0F9jwemV/W0SMB0OnvN9oLbPY6rbGj?=
 =?us-ascii?Q?jRJBOwhG3ZWlZtO+4OjBX59MxZ5mAD6bEAMOikH4hZ1XRLLAu4JV0wqiiZnB?=
 =?us-ascii?Q?PXa3KNxijAeFv8MzE07QDeErhCmfna3HLiLQoR8Z6bJdH35x81jZNGbn9F7L?=
 =?us-ascii?Q?3tP4sYkzcRUFr2Dsf2xGngJaWgFv5yAKaD11XZlqya5kFF+MCH+pKtTFKG6J?=
 =?us-ascii?Q?UKBFQ7oki5NoZzY0uOm8jdnwEvbI43jv01SdC66gWtMD9pKhzZeQ097GHukX?=
 =?us-ascii?Q?MT/WKzGpx2FCVkGdcE/C2Ln2nqbPz6BczvVIYNjJ+AqW9vTkIz8EAwfU4jwR?=
 =?us-ascii?Q?KgtF3ifalOjyFhnlmUSfB2NDSFYOMZVwcBaTc2Z6pYnruH3FNYMrkPUYWJaX?=
 =?us-ascii?Q?eO360PaEYEtD5kX+fSZlFdYt+r75PM7Gmnp2+ToR8TlxgO/Nugm/rj44hpkn?=
 =?us-ascii?Q?0aOVExZh844/UcMz6Dhzqr3aKQMx5TfNpMb4xbdqja7vzlR1obYsdXYk6Fbw?=
 =?us-ascii?Q?VD8Q65jX+9dSkiQ53pZvkuz2WGT8W1NEuQRjzT2Bilt0vpsjHchS/lXgyx2Y?=
 =?us-ascii?Q?+J3fgrlh8CkqjeDiMXZl/90NgJ41naaJeHvl/Jsueq/NNVHSI06GJTnMc1PZ?=
 =?us-ascii?Q?qt5I0U5ADhskkseUQNARPYVgdZFAccZ6+vSgHuxyGs1ozc+9EREJszUXHEG0?=
 =?us-ascii?Q?gyEk3W+NxA3DYsaRTWxlnvZNe4kpD/GSJHRuEfZIBcjHVQ16mOWlO5oW76Wy?=
 =?us-ascii?Q?wIepkPmDN/9x4bGmzcM+MLpo17hrxw/NGwrHH8T0bs71rFcvkzlbZOgDC4XL?=
 =?us-ascii?Q?RZ2i9tytN2tfNVN9ut3kGYLiyOTLc1eZvQg5NBPuZhNgbVU6v8XabCZEGvL+?=
 =?us-ascii?Q?wFCsZM3BxVRxkhs8/uTRQMuFrcAsjfBxakMLIktEsp/zubn49QnzpqW9sWyc?=
 =?us-ascii?Q?XMCfKCKtshC+e8IjNNxQzJAwjC0qlZeRJHD0S3DOnaKOljlp2YjOz71QDFYG?=
 =?us-ascii?Q?3MYloD3Wbd47WfhuQWZ6PWjfO88vtAson6jD5fk95Ez2CeUYkVHYj+9cNPhs?=
 =?us-ascii?Q?FdS0I7lhjarOMJ/gij0aqIu+oJf3uGoPypF9U0ohXg/4UOFtck9G2U64zCZZ?=
 =?us-ascii?Q?7npzX+YArtfKj2GV/cPQ0K1VuCSAAqeagFnYBvqLo/9O/J5VWk8axvRD2CEV?=
 =?us-ascii?Q?rWzXkZAr3/xiB+CB1YbXSV+OJH2iOM4ZdZQTBl7QQ4wjxALp9Sju68UVDYiB?=
 =?us-ascii?Q?X8I6TFCN7+9CHKBSZVWwQdO2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83986f0-9008-41a9-1a18-08d944d4441f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 01:27:51.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaNiJKDKA7kVExKRr32zY8c/+ZMJxANlbKhcknR2XS0+SivO9Pipl+T3IpQpTV9Eit2+LevuRLfdA4BYYibeXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4594
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 3/4] fpga: dfl: implement the compat_id_show region op
>=20
> From: Tom Rix <trix@redhat.com>
>=20
> Make sure dfl will work as previously when compat_id is removed
> from struct fpga_manager.  Store and pass the compat_id values
> internal to dfl.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-fme-mgr.c    | 16 +++++++++++++---
>  drivers/fpga/dfl-fme-region.c | 14 ++++++++++++++
>  drivers/fpga/dfl.h            | 14 ++++++++++++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index d5861d13b3069..cd0b9157ea6e5 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -22,6 +22,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/fpga/fpga-mgr.h>
>=20
> +#include "dfl.h"
>  #include "dfl-fme-pr.h"
>=20
>  /* FME Partial Reconfiguration Sub Feature Register Set */
> @@ -70,6 +71,7 @@
>  struct fme_mgr_priv {
>  	void __iomem *ioaddr;
>  	u64 pr_error;
> +	struct dfl_compat_id compat_id;
>  };
>=20
>  static u64 pr_error_to_mgr_status(u64 err)
> @@ -272,13 +274,21 @@ static const struct fpga_manager_ops fme_mgr_ops
> =3D {
>  	.status =3D fme_mgr_status,
>  };
>=20
> -static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> -				  struct fpga_compat_id *id)
> +static void _fme_mgr_get_compat_id(void __iomem *fme_pr,
> +				   struct dfl_compat_id *id)
>  {
>  	id->id_l =3D readq(fme_pr + FME_PR_INTFC_ID_L);
>  	id->id_h =3D readq(fme_pr + FME_PR_INTFC_ID_H);
>  }
>=20
> +void fme_mgr_get_compat_id(struct fpga_manager *mgr,
> +			   struct dfl_compat_id *id)
> +{
> +	struct fme_mgr_priv *priv =3D mgr->priv;
> +	*id =3D priv->compat_id;
> +}
> +EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
> +
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> @@ -306,7 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev=
)
>  	if (!compat_id)
>  		return -ENOMEM;
>=20
> -	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> +	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
>=20
>  	mgr =3D devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
>  				   &fme_mgr_ops, priv);
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.=
c
> index ca7277d3d30a9..d21eacbf2469f 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -17,6 +17,7 @@
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
>=20
> +#include "dfl.h"
>  #include "dfl-fme-pr.h"
>=20
>  static int fme_region_get_bridges(struct fpga_region *region)
> @@ -27,8 +28,21 @@ static int fme_region_get_bridges(struct fpga_region
> *region)
>  	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list)=
;
>  }
>=20
> +static ssize_t fme_region_compat_id_show(struct fpga_region *region, cha=
r
> *buf)
> +{
> +	struct fpga_manager *mgr =3D region->mgr;
> +	struct dfl_compat_id compat_id;
> +
> +	fme_mgr_get_compat_id(mgr, &compat_id);

It's better to have a common interface, otherwise this region driver depend=
s on
one specific mgr driver FPGA_DFL_FME_MGR. Ideally this region driver can be
reused with a new fpga mgr driver.

Compat id can be per-region or shared one from fpga-mgr. In this hardware, =
all
regions share the same compat_id from fpga-mgr.

I think reuse fpga-mgr compatibility id can be done via fpga-mgr data struc=
ture
or some common API exposed by fpga-mgr. In the first implementation, we
added it to fpga-mgr data structure which has less code.

Thanks
Hao

> +
> +	return sysfs_emit(buf, "%016llx%016llx\n",
> +			  (unsigned long long)compat_id.id_h,
> +			  (unsigned long long)compat_id.id_l);
> +}
> +
>  static const struct fpga_region_ops fme_fpga_region_ops =3D {
>  	.get_bridges =3D fme_region_get_bridges,
> +	.compat_id_show =3D fme_region_compat_id_show,
>  };
>=20
>  static int fme_region_probe(struct platform_device *pdev)
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c7..a83fd11b390fc 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -169,6 +169,20 @@
>  #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts
> num */
>  #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector
> */
>=20
> +/**
> + * struct dfl_compat_id - id for compatibility check
> + *
> + * @id_h: high 64bit of the compat_id
> + * @id_l: low 64bit of the compat_id
> + */
> +struct dfl_compat_id {
> +	u64 id_h;
> +	u64 id_l;
> +};
> +
> +void fme_mgr_get_compat_id(struct fpga_manager *mgr,
> +			   struct dfl_compat_id *id);
> +
>  /**
>   * struct dfl_fpga_port_ops - port ops
>   *
> --
> 2.26.3


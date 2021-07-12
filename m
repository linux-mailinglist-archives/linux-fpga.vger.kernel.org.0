Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417CB3C4108
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Jul 2021 03:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGLBnH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Jul 2021 21:43:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:12188 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhGLBnH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Jul 2021 21:43:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="273744562"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="273744562"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2021 18:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="486120297"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2021 18:40:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 11 Jul 2021 18:40:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 11 Jul 2021 18:40:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 11 Jul 2021 18:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+NpA+D/B3M/jdA5AyUC7uJwjJoJs/dZOxhiNFtHevl61nfbRFbA9oKRKOAMM9vhIXU7p27iFPysSibQ2TJ334thL0NcLNjs5vF53pBBDP5JYV8McbzSGc3kNEm2PyYy1DeJ3ruKg5H5tE43/C0uxsUhOCiGdFW2y4r6VMdVTum4oATWXhddUW7kGMz3MQdJpdtewGxVRKuinYiwzRgG8tzM0JKlZbEyCTc8mMGm1+nYP1rjRP8KpK8sGksOcBpdWO7qlWvLCMBm2pjGrEJv4snWdXaSxNAWLbzrFXqfkB3dKGl982ksQNqOaD24iBCdtB6jWTMKR4JGi547Sfnf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdEXtMmfQ4KfHJhW9m+LNapcwdHXuWX4Br2CgsVZZNs=;
 b=CgMxZS8h/osoEgEyE5WiRVB3xlJKS4qfITa3/gqOwBmxUF73RUoGXJMg4T1H9Di11GiTA/rRxVZnf9oXsHwbO9mgVljyho06SASuApUKJQbG0Gi/JWXm0GGlT2ECogiLdZL6A42/aFiR1LeRAgp+Ip1wd0QpY3mCyGnvGMdN1y0csQAjgu9V8HK4qbfc5Sq+bcBoPaoCNtHvZmf/EllilzRxz1eKniP3sUgfj6Vn4D1JS8BzSEnmsIyBzM1ziFuqSGmKrP63KAOTng3LCBOGC7poJEBeep1Ye423UtFSfxLetgzQC7dKUoluDi+3Iy58h0RN5apbKFa+4tQIgm1Hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdEXtMmfQ4KfHJhW9m+LNapcwdHXuWX4Br2CgsVZZNs=;
 b=u1bmh+eBmnRM0QaZYhrSxQU6Y7mCWZq0RXPl94Md9rf7ZllUXJzNjFSLRr2V47x1yGfmGU8Zd5eP5nxi4bi0qJz9fSlonpyzdEtYaVe4jQ2Ek2BKWAIEgr34DUh9XA9CRMmID9VGxDPpHS8twEs2Lb29e7FU5lEj3aTDgzGitAs=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2665.namprd11.prod.outlook.com (2603:10b6:5:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Mon, 12 Jul
 2021 01:40:17 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 01:40:17 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
 fpga_region
Thread-Topic: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
 fpga_region
Thread-Index: AQHXdMhnnZ/opknHKEOx9KM5yJtYvas+kL3Q
Date:   Mon, 12 Jul 2021 01:40:17 +0000
Message-ID: <DM6PR11MB3819098B673C54530B227D4385159@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210709134229.2510349-1-trix@redhat.com>
 <20210709134229.2510349-6-trix@redhat.com>
In-Reply-To: <20210709134229.2510349-6-trix@redhat.com>
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
x-ms-office365-filtering-correlation-id: 9342f36e-7ae6-47f4-c9bb-08d944d6008d
x-ms-traffictypediagnostic: DM6PR11MB2665:
x-microsoft-antispam-prvs: <DM6PR11MB2665EFC4AB42ED37C31938B085159@DM6PR11MB2665.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3J43on3mLLHbEl2aBYBn7sRm8XYOTfzhPnRLpGaKNV5bdlThIwyoCoyOFUTXT62Z3oeO+eZMghwcct0Auiapf9QW/ODMZ2VW0wBCDLahgZdlGhcAQhxyNE0+BPQiou8LLb1qvHCXPYPuxOe/Iv8Isq9kc9VsCVZWR6ErjMNOqJwRCSkoZq8v+jX+YusNk/YgBiWNmuQ9kjKPxVivJskbpmTFDoZbwHjzFzeUs6JhseHPoIOVXR1EuC8QUSDGgsdVG9AGkOj7TenhJIm8hI7HO7t3deNblpWgo8WAf9KdMLFaf0Kx/ZK8SRwckDIlFGMiE9qcUc+H7S4WJlxn4Wbq0J3N3oME5DnA0FRM4xe450jZWCU2VoZUx0Tw7yIBDHqD7Af5xri9kKvrYCtlrc16veTKKTNOHUiA4LBzaxio96u7MXDVLPBoDArDrSPEXNF10yUt8XF408Qa85UUBuM35phFlCyB52fWKBjnO0lcVBuguzsJrOinACVE6XHyRPE1VKv8ByCunOHdFezc/HOd5rsTlEGTvgDZ6U+sLnMtCVDjkfwrvMbRf5SjxLtm67rP1JEefPNwxa8ygD6MONGr9A64wpnOeKZv2WsHnleqE8aHWvCiFvnO9WFSUU+JDCL00Pzu8A7NkUAV73mNYJehzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(316002)(5660300002)(2906002)(9686003)(26005)(86362001)(122000001)(8936002)(33656002)(4326008)(8676002)(478600001)(71200400001)(83380400001)(7696005)(66476007)(64756008)(110136005)(76116006)(66946007)(54906003)(55016002)(53546011)(52536014)(6506007)(38100700002)(186003)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAf+aTDld/KdoIFhx6fR6oourAn9HkdGD5sKD220czU+Tv+nC/2792hv3EGA?=
 =?us-ascii?Q?N7cYUhDf+p4WCxI5Q3aD71PZruPRAct/ClqF+y38iE970hNLLnH2h0ZjDj9U?=
 =?us-ascii?Q?THVdXm+MtIXy3gZU7MJP6UvXlotFOvIqQFwJucD3HkbAdQYnjH8PGCc2E9ZJ?=
 =?us-ascii?Q?cARNzbFUteFF8zmpRlx2V6773ctpK/EWQs6ZZ2m0Xyt3B1+mb4BV9cOs2gJA?=
 =?us-ascii?Q?EEDN44CPj+Mjz6YqvCoXXIFcEmaRUQVaOBrKroQukc+rB7PXtAXl1u5GVesb?=
 =?us-ascii?Q?ARd7FPEtjGOlnZizideAz6bHEXx0OTs4JK3wVJakjvpRo2e5KAcCa/kaIjEG?=
 =?us-ascii?Q?cvI+Hl0U1bTgqUKjUOWdI6OiU+uQclF2eQwmryHuZSg7mUl09lHw7zwe7x5G?=
 =?us-ascii?Q?I28b5ATu4QFSzqUwNEHVoewwsE7XSduAONpynXdqWh32YdjHQB5y1HuFEjXB?=
 =?us-ascii?Q?oXz07iQBGlafdl1BrlBB9+ijeX7AuXAMBhOEsa45EjQdvGk4IYEiDCsJwi6W?=
 =?us-ascii?Q?ddZk9JwNjPlxySBc5DObB2oiFpz+CWVJ8DNBzKksm1qRF8Kd0Gd0UF2nbU0D?=
 =?us-ascii?Q?m2Bmx+v6LAcKdgRUU88UkFbWvZK07ahXk46r5BSmtmRSr98q81aqY/bkY5DD?=
 =?us-ascii?Q?o1ShPjlioOrqGBeuK7g2K3PWNw4LP9Vd+Kksnos/IG/edreExeKEvQcXwSvl?=
 =?us-ascii?Q?CnOEdRFTZNT9SXDIRxCWxZc9K9RtYnuuWsd1O0sgJmHyAj/Qe/180FwGXGvP?=
 =?us-ascii?Q?jwp8LcdaDRUrA05Tz46i+qhOsoQitLMbgWLnj06utlFoNmsZeoQQ+o3U9bMK?=
 =?us-ascii?Q?H3yy6Um5QJ7fMqD6MflktiIRD7Jl2xsJh/lapKaDT/lIXa/uAVR1w1iwOOGS?=
 =?us-ascii?Q?iUdO4sItteOnBBqBIqMBX1Um1aOtVbX7wM6guFqNYSS6eTgNYHDbQbJRppxO?=
 =?us-ascii?Q?gMjpbu+PxGI0TWK74N4ht9QlLU6Q9RUX/8KwmHx0+Z4zUIL1WQkFJARkL3Ru?=
 =?us-ascii?Q?1fl8/xb8+h15Hy5HJCGqUbzuo4KM6L8oL/0BC5Rkps5FWT6DyHSkUN6XCgr1?=
 =?us-ascii?Q?i6aeeE+kErRavf64yG8Kq/v5HWFbPNLyN3dTsRGQgEZpNl0Eq+drQ9HjeyJm?=
 =?us-ascii?Q?oTanUdwlU6JCUCEnRcBltH19Pk6gfZVaKLQPGNM6puNpLPnMt64df+uMsHL8?=
 =?us-ascii?Q?gUCgWSm0W+eQtL1ey7l0JQpa58s0J8G+8UrWzf39pvfb0RsB5SB/WR5H0jgD?=
 =?us-ascii?Q?GjyVkAjM0Aesj5LyfssyfeMukWARf0g3Bsqc4CdE+/zbUqtH4KVMrjG1nI99?=
 =?us-ascii?Q?Vm9wLdn6R7H4t3l/Z3o5ORgb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9342f36e-7ae6-47f4-c9bb-08d944d6008d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 01:40:17.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iB1NO9VwxXhBl6Cmlep8mgazqifdHsjF9GRZgDcl6paLgunE/W2xfHQE8O3aK4vd9N0O9O4ZWq1E2lhcA2FA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2665
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: trix@redhat.com <trix@redhat.com>
> Sent: Friday, July 9, 2021 9:42 PM
> To: mdf@kernel.org; corbet@lwn.net; Wu, Hao <hao.wu@intel.com>
> Cc: linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Tom Rix <trix@redhat.com>
> Subject: [PATCH v2 4/4] fpga: remove compat_id from fpga_manager and
> fpga_region
>=20
> From: Tom Rix <trix@redhat.com>
>=20
> compat_id is implementation specific.  So the data should be
> stored at the implemeation layer, not the infrastructure layer.
> Remove the compat_id elements and supporting code.

I think current compat_id format can meet the checking requirement.
Actually I hope other hardware which needs compatible checking
to expose the same format compat_id. Then we can have more=20
unified/common code, e.g. userspace application/lib handling.

Currently I didn't see any other usage or requirement on this part
now, only DFL uses it.  So should we leave it here at this moment?
I feel we don't have to change it for now to move it to a
Per-fpga-mgr format. : )

Thanks
Hao

>=20
> Printing out the compat_id is done with the fpga_region
> compat_id_show() op.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-fme-mgr.c       |  7 -------
>  drivers/fpga/dfl-fme-region.c    |  1 -
>  drivers/fpga/fpga-region.c       |  7 +------
>  include/linux/fpga/fpga-mgr.h    | 13 -------------
>  include/linux/fpga/fpga-region.h |  2 --
>  5 files changed, 1 insertion(+), 29 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index cd0b9157ea6e5..8c5423eeffe75 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -292,7 +292,6 @@ EXPORT_SYMBOL_GPL(fme_mgr_get_compat_id);
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata =3D dev_get_platdata(&pdev->dev);
> -	struct fpga_compat_id *compat_id;
>  	struct device *dev =3D &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> @@ -312,10 +311,6 @@ static int fme_mgr_probe(struct platform_device
> *pdev)
>  			return PTR_ERR(priv->ioaddr);
>  	}
>=20
> -	compat_id =3D devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> -	if (!compat_id)
> -		return -ENOMEM;
> -
>  	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
>=20
>  	mgr =3D devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> @@ -323,8 +318,6 @@ static int fme_mgr_probe(struct platform_device *pdev=
)
>  	if (!mgr)
>  		return -ENOMEM;
>=20
> -	mgr->compat_id =3D compat_id;
> -
>  	return devm_fpga_mgr_register(dev, mgr);
>  }
>=20
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.=
c
> index d21eacbf2469f..be1d57ee37666 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -64,7 +64,6 @@ static int fme_region_probe(struct platform_device *pde=
v)
>  	}
>=20
>  	region->priv =3D pdata;
> -	region->compat_id =3D mgr->compat_id;
>  	platform_set_drvdata(pdev, region);
>=20
>  	ret =3D fpga_region_register(region);
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 864dd4f290e3b..b08d3914716f0 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -172,12 +172,7 @@ static ssize_t compat_id_show(struct device *dev,
>  	if (region->rops && region->rops->compat_id_show)
>  		return region->rops->compat_id_show(region, buf);
>=20
> -	if (!region->compat_id)
> -		return -ENOENT;
> -
> -	return sprintf(buf, "%016llx%016llx\n",
> -		       (unsigned long long)region->compat_id->id_h,
> -		       (unsigned long long)region->compat_id->id_l);
> +	return -ENOENT;
>  }
>=20
>  static DEVICE_ATTR_RO(compat_id);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.=
h
> index ec2cd8bfceb00..ebdea215a8643 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -143,24 +143,12 @@ struct fpga_manager_ops {
>  #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
>  #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
>=20
> -/**
> - * struct fpga_compat_id - id for compatibility check
> - *
> - * @id_h: high 64bit of the compat_id
> - * @id_l: low 64bit of the compat_id
> - */
> -struct fpga_compat_id {
> -	u64 id_h;
> -	u64 id_l;
> -};
> -
>  /**
>   * struct fpga_manager - fpga manager structure
>   * @name: name of low level fpga manager
>   * @dev: fpga manager device
>   * @ref_mutex: only allows one reference to fpga manager
>   * @state: state of fpga manager
> - * @compat_id: FPGA manager id for compatibility check.
>   * @mops: pointer to struct of fpga manager ops
>   * @priv: low level driver private date
>   */
> @@ -169,7 +157,6 @@ struct fpga_manager {
>  	struct device dev;
>  	struct mutex ref_mutex;
>  	enum fpga_mgr_states state;
> -	struct fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
>  };
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-r=
egion.h
> index 236d3819f1c13..afc79784b2823 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -30,7 +30,6 @@ struct fpga_region_ops {
>   * @bridge_list: list of FPGA bridges specified in region
>   * @mgr: FPGA manager
>   * @info: FPGA image info
> - * @compat_id: FPGA region id for compatibility check.
>   * @priv: private data
>   * @rops: optional pointer to struct for fpga region ops
>   */
> @@ -40,7 +39,6 @@ struct fpga_region {
>  	struct list_head bridge_list;
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
> -	struct fpga_compat_id *compat_id;
>  	void *priv;
>  	const struct fpga_region_ops *rops;
>  };
> --
> 2.26.3


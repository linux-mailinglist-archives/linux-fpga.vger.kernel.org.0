Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37A30D5C4
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Feb 2021 10:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBCJDF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 04:03:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:19698 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232590AbhBCJCv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 04:02:51 -0500
IronPort-SDR: bHWvThKd1HjQnGCgcEXDdhEcGrP8AICMKanS9vitMFHBmMpPsieYdO03WIRdYTkpdmzLPqdubq
 3tEG20htzeyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242521599"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="242521599"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:02:08 -0800
IronPort-SDR: M6yBaJS2Ppzv0RV5QbphLU7prsqcVHy7/Ukqlmh6A2p1aMiyKD9tdNhRj/5boNHEHmnMUxkkDT
 LXXPsgjv22Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="582329591"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2021 01:02:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 01:02:04 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 01:02:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Feb 2021 01:02:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 3 Feb 2021 01:02:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSe+8EGGxlXJ+f+CQQiXFlq1VlSIUMoCOHzIUQRQttyl3Miv0zGHskFUvX1KetTBc0yrEOx7X0MOZEDi1JdekWRLPIoLMYO0BTNQxU2maUcWqfPj1f9Hd8+MDqR2U+s9MKP3J1OrXYhparWJ/EgpW+P7idjzbK1dnRqnZI0gclLzHm+wbskojifT42dfCi9DYvFpBTAWlx6R8XWTfYmHhEoSCZvmOt6Xi6Zg5RMq1M2NiZkmZ/VgZmWe8QljZH+ru4dC/sIZzUtk6JmuqsyyxuDm0ACIKBTHPE33gUA7MmwH/pT6nh9ZUd1In3pIltSiK86EcWnDsdA7TZ9gkNbIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nny78QjesxfaogmH0hE3OKX19t6mAvxB3DmfG49Zijk=;
 b=bMIsfOJG9QcJEW2NQi+aejWnIiW28hQxrJajTa8BdCw3ruNGMxyTeTEjnNyyxtwLQVgkJKLpJr81Mw6c3yReyvf2bZrF9n9VENFZTBYKTx26gBN7AxDHHHmNGiHdsAJjxY5TG8VTPhAQHUR798b8y9yj4P28xM7qXRLHOIhGxUP2XNIx70jO/+juVnASETNDUDwM8P9F2GRf+CmmOdfIX2F26c+4PBRKktrJHMI2pF+14Efireu5ZSLMU6ukyokhxTjxwwBkX5Gqh3deyadOdlT+WVK/VHD6FnqslcdERizWWEjeR9/gcpP1TikeR88zkaHHxHmIotNEij+FRhpXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nny78QjesxfaogmH0hE3OKX19t6mAvxB3DmfG49Zijk=;
 b=h9NY1A5dC9cyaMkg1pkhiND65SWRrLTvzdKVHozy2r9CGefGBdCo/tKCGX07v/sEZn5Y3dUuoGpYQ5Nx/xMk7BUVoEnXZdFylqN23HG0kr3uj/smVeCNMotOAPofSGrWfR4kWXz4TkD9YC8zEcdPc0R/DCmrQ4tmvj2jReWp+Gw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1851.namprd11.prod.outlook.com (2603:10b6:3:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 09:01:28 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3805.019; Wed, 3 Feb 2021
 09:01:28 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHW+bgQqd0GwODdHEqQahZtn2dJJ6pGHiiw
Date:   Wed, 3 Feb 2021 09:01:27 +0000
Message-ID: <DM6PR11MB3819173E2C84099BA5D6EB4785B49@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210202230631.198950-1-russell.h.weight@intel.com>
In-Reply-To: <20210202230631.198950-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e74ce43-6be4-4e7d-183f-08d8c8224ae5
x-ms-traffictypediagnostic: DM5PR11MB1851:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1851BE3375AA546B154E13E185B49@DM5PR11MB1851.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpDpuyFtI+UI0ySvRdfpGEWx9KuatS5nRbWbFrsERj+pLmsVQCnBvR3wyAXy+WHBLVTnl7BWGGRhjNuaN1gq0+D261ZZbd+vDaPuF6xydkDwKz6z8nNKCsf/vLzQljOzYVGILLE11vsTtQyTd6yES2X+CHH3ZdwLo0vHqb0EZAcNJc3FGwmPfIa97IKjIYWpIeiabtoSIqLTH+Cb/5EeSyOg1nlFPEIwb28d8YAgFMQV7A3lciI59WPhkkK6S/3IGCuIHqyyfsMp5/kIEQTikumZdDD2ypBKLHA1XxFtQAmRtKFnMF/z13Xo4Lw9UUXLBzzmtd8NWC2l8q2Wgrh0sbycP5VImNrEWrdc6JluTedMsV/2x3tbctzPC4AgIeXBX4M61NI8Sp3tBV/9zzreWAPA7nSdfiS6laIwXWghlHwjmu0Oyv87o8Mp7QbtvqZ8SLLLT8/600lavvkhtxNyXPK00oNycMHASM+y77k3L2VrNIJngXSkJGrWHKKPwGpGT8gzen/S4D9oNJQ+ngVpYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39860400002)(66946007)(4326008)(478600001)(107886003)(64756008)(66476007)(66556008)(66446008)(110136005)(7696005)(71200400001)(76116006)(8676002)(9686003)(55016002)(6506007)(52536014)(186003)(5660300002)(8936002)(26005)(2906002)(33656002)(83380400001)(86362001)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TH5jiSJJYLum7dUFdXWnzYlUG3+pjlNOqdcV2vyxa3DqzxMyB4lIzFZZ9BlR?=
 =?us-ascii?Q?RnejwkJAgcayfd2zYC4TjP+WBFh99av0hJk3difXXJw4u4x3nbbHUjHBsHDq?=
 =?us-ascii?Q?09cwmi/wDtAHIwml2DHabRp2i8ygLMAvJ/vxUVRH7QeMUy74NLi7BqkqRKpJ?=
 =?us-ascii?Q?QaKZv6bP8PLQfcpD33qikMVWZaNl5yIaS4PNNH1WTK6hSNtXr1cu7g42f/r/?=
 =?us-ascii?Q?5XY2l0l+G0z9scSXscVjHVhugZ9rqYggT+BXNf913eMb/cOaAOugkpLGwEnU?=
 =?us-ascii?Q?aPyvEhXXQ6qOkc79ebydj0Yg2ZL8uhBk6Xsc3cSTjie57LDiVSp1nt4eGQwE?=
 =?us-ascii?Q?ELuxKFgTOSXvr6AnyRtvTQ05YUTjlGXJvpF2i273kg1KU5bJPho6vknNk2yO?=
 =?us-ascii?Q?7bghKx/P4lxmxwRGyEYq5ebVXMJb6qmQLrV1SD5/6BU5L5LF8347k0vemwWG?=
 =?us-ascii?Q?R5ImOo6ukk9LvS30E9L+iqt6ZXaG++bXcQ1l+RIHKfdi9G7WOpTstTnelz6z?=
 =?us-ascii?Q?riGhHWjRSBJY5xjmUNto7c7bQ1ZJVbM4HfKWyZ8vVqFPiGyTa8hLGCF5v8/W?=
 =?us-ascii?Q?Y5xf88R0IRWx9lYqzKm580oiyihMB6Uhjsxj6+fVBjDN2HaAeNPdrFDcjdq8?=
 =?us-ascii?Q?AsaaCCIwBpvd5jvOHcEP4JG7E15V7ckVtHll/Cvm0Hvo7UM6IOGV1bYZGmUy?=
 =?us-ascii?Q?0nFougUhV1NMtO/huioQHArhXUbHqDpupdDP3QIo3DuTnE5bOkhiHLloSf5w?=
 =?us-ascii?Q?SU1Ztk1UPz+/zkKs9mxkssGRkXymMDrGgHP9VGMMeLhww869F0VAxv4R5wJh?=
 =?us-ascii?Q?fPw9FWFXZ1mMFQ0wGNhC2M+rRLg+nOMf8GmwnAFTx769TDcZqPEKSjA9pBTI?=
 =?us-ascii?Q?kyzhzy8fXvTbMhmubxsVP7uDUfwyxdzuymmSSgv+63mcgDxw0gpi8u9hLoh5?=
 =?us-ascii?Q?cabJLTutsjTQfByhfOXA/a5h6CMEZdkE9hhFajXZMNUCJ1BHwOd/NCrtji/C?=
 =?us-ascii?Q?w+qQ+mJidKv3MuyJk0HbQHrnqeymnwoB/FoWEOVfUc2MpJPEwxe42dkuwEfx?=
 =?us-ascii?Q?hzBZD1lh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e74ce43-6be4-4e7d-183f-08d8c8224ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 09:01:28.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5ppGRlu0iC8lgDt4FDwn3vB5vdn2kGWhjUVgDB12l9702uTM0eJx29Yl8RjTEVHHPUx/KP0jw4p2fpk4ViwTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1851
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
>=20
> Port enable is not complete until ACK =3D 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK =3D=3D 0.
>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v3:
>   - afu_port_err_clear() changed to prioritize port_enable failure over
>     other a detected mismatch in port errors.
>   - reorganized code in port_reset() to be more readable.
> v2:
>   - Fixed typo in commit message
> ---
>  drivers/fpga/dfl-afu-error.c |  8 ++++----
>  drivers/fpga/dfl-afu-main.c  | 31 ++++++++++++++++++++++---------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 27 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..2ced610059cc 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 e=
rr)
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(dev);
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	void __iomem *base_err, *base_hdr;
> -	int ret =3D -EBUSY;
> +	int enable_ret =3D 0, ret =3D -EBUSY;
>  	u64 v;
>=20
>  	base_err =3D dfl_get_feature_ioaddr_by_id(dev,
> PORT_FEATURE_ID_ERROR);
> @@ -102,12 +102,12 @@ static int afu_port_err_clear(struct device *dev, u=
64
> err)
>  	/* Clear mask */
>  	__afu_port_err_mask(dev, false);
>=20
> -	/* Enable the Port by clear the reset */
> -	__afu_port_enable(pdev);
> +	/* Enable the Port by clearing the reset */
> +	enable_ret =3D __afu_port_enable(pdev);
>=20
>  done:
>  	mutex_unlock(&pdata->lock);
> -	return ret;
> +	return enable_ret ? enable_ret : ret;

Maybe we should add some error message to notify user, there are more error=
s happened,
as some ret value is not returned.

>  }
>=20
>  static ssize_t errors_show(struct device *dev, struct device_attribute *=
attr,
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..729eb306062e 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -21,6 +21,9 @@
>=20
>  #include "dfl-afu.h"
>=20
> +#define RST_POLL_INVL 10 /* us */
> +#define RST_POLL_TIMEOUT 1000 /* us */
> +
>  /**
>   * __afu_port_enable - enable a port by clear reset
>   * @pdev: port platform device.
> @@ -32,7 +35,7 @@
>   *
>   * The caller needs to hold lock for protection.
>   */
> -void __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
>  	void __iomem *base;
> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>  	WARN_ON(!pdata->disable_count);
>=20
>  	if (--pdata->disable_count !=3D 0)
> -		return;
> +		return 0;
>=20
>  	base =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
> PORT_FEATURE_ID_HEADER);
>=20
> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
>  	v =3D readq(base + PORT_HDR_CTRL);
>  	v &=3D ~PORT_CTRL_SFTRST;
>  	writeq(v, base + PORT_HDR_CTRL);
> -}
>=20
> -#define RST_POLL_INVL 10 /* us */
> -#define RST_POLL_TIMEOUT 1000 /* us */
> +	/*
> +	 * HW clears the ack bit to indicate that the port is fully out
> +	 * of reset.
> +	 */
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       !(v & PORT_CTRL_SFTRST_ACK),
> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");

Maybe we can change dev_err message in port disable to "disable device" as =
well. : )

Hao

> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
>=20
>  /**
>   * __afu_port_disable - disable a port by hold reset
> @@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
>=20
>  	ret =3D __afu_port_disable(pdev);
>  	if (!ret)
> -		__afu_port_enable(pdev);
> +		return ret;
>=20
> -	return ret;
> +	return __afu_port_enable(pdev);
>  }
>=20
>  static int port_reset(struct platform_device *pdev)
> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device
> *pdev)
>  static int port_enable_set(struct platform_device *pdev, bool enable)
>  {
>  	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> -	int ret =3D 0;
> +	int ret;
>=20
>  	mutex_lock(&pdata->lock);
>  	if (enable)
> -		__afu_port_enable(pdev);
> +		ret =3D __afu_port_enable(pdev);
>  	else
>  		ret =3D __afu_port_disable(pdev);
>  	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
>  };
>=20
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
>  int __afu_port_disable(struct platform_device *pdev);
>=20
>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> --
> 2.25.1


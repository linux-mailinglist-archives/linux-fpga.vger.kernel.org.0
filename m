Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0795C32257F
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Feb 2021 06:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBWFof (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Feb 2021 00:44:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:42360 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhBWFoe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Feb 2021 00:44:34 -0500
IronPort-SDR: zV9duh3sMyG1ZV6IKCgG5/fqb4srZN5Y1X+vDVnqoNxXUZfP6gZKqGRYPLTcZO3Sq7mEtoj2uL
 2LDnm4L8T1bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="171835780"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="171835780"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 21:43:52 -0800
IronPort-SDR: OEUnwVmbzSDav9xGWk8JlCIcE/fHAvhOh8xAIjIkQe33mmN0+6O+kGPWERJMr0g80s2E7pXAUw
 m6XqS0MQAHyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="592958463"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 22 Feb 2021 21:43:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Feb 2021 21:43:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Feb 2021 21:43:51 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Feb 2021 21:43:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV3QF3H1sZUUTMN8Umqa1AuiRMRGmazcURLoTNUJp8EgUXeizoRHADKwpChisyoGTk2ECkJaVIwaPTveglfNTgwWm2bsV5MdaZBCB8jEZNxMjwMl+hziNEmuqjZSQsr3tFEaj+l3CXKGflh8fGv+7d4Jull2JSYlucXD3pe+9wgWBTCCK7jmtWwBL5c/nSF9mOGXbZXc3oUwVDZ/TnUCKp+wUhgyJ4mZ4v9DnfCx6WjjfCJ3FmObiwqsevDrkWaMCBOgyv/YQ3tXQkV/Xk6aG8OTcZeYt+gnTAxXBihzP5E3yllWO1tAsEUlYkj62ccHcbYnSMAAAtZ39DQOhGvolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVgbhn0n7cVit4+yQDLXPlrteEQlqLD6Puy3JOiDOmo=;
 b=hazzUa0vUnyKYB6o/SGd85GWTQBa6E8C2hUDUuOohYMcYFXuYGAdZBI3Cxxku1ySbPZlAu7CdURe55SOU01hMxv1ogzNLVjQdG6a/U8IkLiWmfEO2vKoQbkOTq8VvWB0pNM+VTMbn2p5n+4+SPh/7TARDMVMpfA2JNIiapOa5u9DwVbZnwAEnnu777+Tx05upfP9edc99eS87a6T8qgqw/SlGDTM/Jx+4sQlC4EmbI7v9LNMiYrsGjoKzGPGn9S0o9LZMmvPFfeox2bE4otvC44dBItIYYTG3Vz2c+Gh442bLfmBDhca/HmUv5CY9YDKlkwAwnpRymonimNSz4S8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVgbhn0n7cVit4+yQDLXPlrteEQlqLD6Puy3JOiDOmo=;
 b=W+ke2Fv9tsNrt5s0I9VEPmwz8jhCwlmWHI34rgKIZhExDrhTtk2Cjm/FOy0PYOBZWBw9RMpTfZuBOK3kiPffYCNSWxYD+6WOoTAfTUxGA8QTXS2OvdJC9GcmNJExF16UaPDKgyKvL+mWVNtJOhmGvzXMr8465Qc1wSIwjtEHbhY=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2890.namprd11.prod.outlook.com (2603:10b6:5:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 05:43:48 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7843:381e:c91c:f597%6]) with mapi id 15.20.3868.031; Tue, 23 Feb 2021
 05:43:48 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v6 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHXCUU14ftS6JTzE0ihdvso8D/6tqplOudA
Date:   Tue, 23 Feb 2021 05:43:48 +0000
Message-ID: <DM6PR11MB3819CFF78F88A3C94A54FA2385809@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210222180414.116014-1-russell.h.weight@intel.com>
In-Reply-To: <20210222180414.116014-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc2d19a9-bd7f-4676-5673-08d8d7bdfe32
x-ms-traffictypediagnostic: DM6PR11MB2890:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28906E70F9518182C7FC8FE785809@DM6PR11MB2890.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t81LwkIb8lAbf12WVI4rIXjWcrWl1czeXKU7f5U6YmKiJ/Wb2k+xPIRYdgiYH/FmBf4ZtpS3SDnyVVrmID952+3aoX+HZly4WNEXgB6WHpAIjTv9oZ03R5t3uzcZyzfDt9awfiWRN5A3QlUv2dSMKRSO8bjpNF0NX5WfbAXDbE4gslLXmdQjkkteoGGnse7cWNedhyDpE4nI/d7TVim48M7GvuNCDy6urxfhOVNgko0j4twwFUzz/mzbp+oiXWv02d97PGer5oIVXr40iEQmjdRlTSKLHVDbPCzYhol+QQLZ+sLEyInW6eW1fHQoiEAb7mG58kxWs4pn+eN/2Nzxicyx9Tz42GZP+oXCZoJy7tnOUILUN+7usBjjUygbd8DW3UT9A8lmi7aqNG43EL5KJ8lq4FE/1oE9EgUYnoosVcgP2Uc9AxGQPeA51O7vEUXJC/EnFid1WohUG+4Woa2roVreTzFlwAQjUm7BKa28Q8G/7cVraKn1gjrk6oimnq7+ZcmNGTXINKD9Sc+qoKTOdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(8676002)(8936002)(186003)(26005)(71200400001)(110136005)(66556008)(64756008)(316002)(66446008)(66946007)(54906003)(66476007)(86362001)(52536014)(2906002)(7696005)(5660300002)(6506007)(76116006)(4326008)(478600001)(55016002)(9686003)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BCngFU0pbsQWgEGbnOS5l7kHlLxAS+qrMRoh/6qUDbuhLGF0224IY+D6aQUS?=
 =?us-ascii?Q?sOJbwtm7Li/hmINPr/MgoV9ppABf4YgFG0pBxiqrWRDGK5+Rbf/+pJ1NLOuX?=
 =?us-ascii?Q?396GImiUza0W+Um6dZdACmXJ45kmV02O/0eWQ5mZY/PBXTfRfnWz988uNioT?=
 =?us-ascii?Q?4uHB4FZ+J+OA7XSURS4pk6ik7fnRUR1WR7iACLWcho0sJV93PIVHZcZMOpqO?=
 =?us-ascii?Q?YMvr83HNvn8oEmtVW80rgPdbm0JmEVqw3gSr381F7TzOVBonOD+A+Potdcsc?=
 =?us-ascii?Q?/zGkP4CC9A91Tp6xz6WJ2+EcxxLeB2yWxCwtvCkOFwH9fTgM9wsPXXGoR6Xt?=
 =?us-ascii?Q?b+JegZ8dn37ozn3Wp6bJsbqBAeTQ/v5hJsk9d4qjz3Bxlls9KMJci3NQJx9/?=
 =?us-ascii?Q?x83pvt8bAvTTyglPHEMBv2rj7LcVjJ6yVwHLYQT2SjFNplkBya7S2xK4eB5P?=
 =?us-ascii?Q?d7EZiOBCkhuxKWnxlcW2ZwCMv5WehGlTUN8y+8YgL3D4hnCnJ3JPYpb48A3X?=
 =?us-ascii?Q?CGPsXFuSeDFUeqI8ol/l1jAYKnT0BcfK4rr/BvpIdWFtHaPYcEEaBsiXJ+Dy?=
 =?us-ascii?Q?G/LVGbWm3s7UugAIpxRr8cWGesGYXt4BwkzPCUYsCMRiQ4oo5ng4+BFZzsHa?=
 =?us-ascii?Q?jJB0rRPp4Guc4b8AQuy0CRIMQoWX1pGcyU5Xz1CPfJPiWIzv8KAroH09CgUA?=
 =?us-ascii?Q?D09mK06UHtRUjrAX7fcgT3sEfl4pH2MB9nljm2UKxhmWZXsnbq+JQwAcxqAy?=
 =?us-ascii?Q?zqWXYiPDS+yUvTlEquR159FiA2yHyz48Gp+nMBMxco3ivdpLuP6zzsT0gMBm?=
 =?us-ascii?Q?294c1ZXcxzrV8+jSlZtqgqwFdZp02oN2nYW9/JCCEnc/yXYqEEs+Zu0kghDS?=
 =?us-ascii?Q?GUx78TJ/6KRvmWt9UtfBCn4fhblLqWKQZC4OcVjYy34/brfkZ5P1GewzyEVe?=
 =?us-ascii?Q?G4LmLgw4Y35+j6u5yOhr7Zi0+NvFY+pPNpKpB6XieZzuv8QRX3gm/sGan+Y2?=
 =?us-ascii?Q?vP/6qNOPv4l7dZB9Emga7mDGV5c3Cg8VIJ9/Xt4GE91jAWcuoSiSOl/bIG8z?=
 =?us-ascii?Q?Yu0Kvj5msQGNW8ZOYaMjMQGNqeHD4rarTbnzN0N8FaqfiUniTL9icl7EYRG0?=
 =?us-ascii?Q?ttQyJlGkPB4EsesaeLhgVYRxXptOTk63j8xaSnlGFX05Vfwc1GZBHfcn/gLU?=
 =?us-ascii?Q?a3nlkQIC+XRKJ6EZOH/T2T4dR03JmcKhG7OlBC+aSBppKIPePG82vWv/3WfA?=
 =?us-ascii?Q?/6X6Xei64ZmirJ7CW6RgTvUxp7mAOmpGz0uxpcdYTABhZLtE5xgP1PH670U5?=
 =?us-ascii?Q?hh1VqHNMgad36pBbkTu+ywxr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d19a9-bd7f-4676-5673-08d8d7bdfe32
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 05:43:48.5488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80B3OPketn9AjLLsLJYnOXCCM64wWTynZHBOJhA9mUSjw9dmnD5XHhaqqicRmDa+lI7AsOp8mZ6dKM6VYeMdEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2890
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v6 1/1] fpga: dfl: afu: harden port enable logic
>=20
> Port enable is not complete until ACK =3D 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK =3D=3D 0.

Looks good to me.

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

>=20
> Reviewed-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v6:
>   - Fixed the dev_warn statement, which had "__func__" embedded in the
>     string instead of treated as a parameter to the format string.
> v5:
>   - Added Reviewed-by tag to commit message
> v4:
>   - Added a dev_warn() call for the -EINVAL case of afu_port_err_clear()
>   - Modified dev_err() message in __afu_port_disable() to say "disable"
>     instead of "reset"
> v3:
>   - afu_port_err_clear() changed to prioritize port_enable failure over
>     other a detected mismatch in port errors.
>   - reorganized code in port_reset() to be more readable.
> v2:
>   - Fixed typo in commit message
> ---
>  drivers/fpga/dfl-afu-error.c | 10 ++++++----
>  drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..ab7be6217368 100644
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
> @@ -96,18 +96,20 @@ static int afu_port_err_clear(struct device *dev, u64=
 err)
>  		v =3D readq(base_err + PORT_FIRST_ERROR);
>  		writeq(v, base_err + PORT_FIRST_ERROR);
>  	} else {
> +		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
> +			 __func__, v, err);
>  		ret =3D -EINVAL;
>  	}
>=20
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
>  }
>=20
>  static ssize_t errors_show(struct device *dev, struct device_attribute *=
attr,
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..77dadaae5b8f 100644
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
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
>=20
>  /**
>   * __afu_port_disable - disable a port by hold reset
> @@ -86,7 +99,7 @@ int __afu_port_disable(struct platform_device *pdev)
>  	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>  			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> -		dev_err(&pdev->dev, "timeout, fail to reset device\n");
> +		dev_err(&pdev->dev, "timeout, failure to disable device\n");
>  		return -ETIMEDOUT;
>  	}
>=20
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


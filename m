Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0AB26F135
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Sep 2020 04:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgIRCJA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 22:09:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:9936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgIRCIz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Sep 2020 22:08:55 -0400
IronPort-SDR: 9nQr8oaK0sNsRs0Xi7e1NKcfABVwICHICsgurXZmLoS+0glyDPxypR8uA1Z7jGYHOYgPFhIqS4
 UOBLuL8GTyYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147520833"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="147520833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 19:08:49 -0700
IronPort-SDR: 4beuQeMYhcCtRGMfj006nKc/9llFlo3tHyuaXqlNEXl6GCtftIz0YthIqnPYuhrGRPX3ox6ik6
 heqkQTWd2aIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="289190900"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2020 19:08:48 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 19:08:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 19:08:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Sep 2020 19:08:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Sep 2020 19:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXMVUjTiFu5LvrE+7BHFBctCCY0xhs+N0zstKl1TKTAEzYbsMfvfOtPthGjo6damo19IGA1INaOiImYvQit4cN2fj9uk2nybH7NAxPDe4CX71HPC6oF5XknO+qM938P6ldHUJ7rLe+CPLgbFapOaiE9qHDuAf/0KMj8A42nfmzjTlgf/26ZiW0FZHGhfdOoxXQ2rQKaJOgo72PHh1ojDdkroGkS+NIQN9AcEmJN3y8HPRwZWXAoRm2x5Gd9s+QzHipLi7w2+Tz6gS6pAVO+J6SlxriHt2wsMuX1GUXEmB8w2PUhYc0qHU3nfTdOEFr1jCbAnj0lVwPWI/V525/msrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXd/N0ruOYYteuhCIuoAUtJUPZ7Af7o8oa7kR+Gpd8A=;
 b=jpd8Y1XAxPaB6DuQfnncTKoUESbYdoktTkFtu4rp8q6XHSEBdaDD0hRDkrC47gIcdCT5Ummfh+ZN6gKghRgs3YZMgJG7M94XWUCor0kXVq7fu0AVT133TpKbZfnhuO+ck0tqesn3KvvRzeD/lPzVe5E1vuNYm++a3TtkBXYU8sC6TK7Ye1gAnssC3i689tmt/pQfvSSrcinfqgvgY/wmLhZESr7FuxFRkxw9y95TNJemGH3Q6Bc+EsztkWtjzFu1ZaK9nMUehieNjfx7lG3mddkLJVoVYZc16ix6eSfK8FrrchxM+iDsaLkw0Zr9UpVYwKdnZp+L+LF/ecPbU33jeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXd/N0ruOYYteuhCIuoAUtJUPZ7Af7o8oa7kR+Gpd8A=;
 b=Lqiy/nnD+YHUsRZ4y4BMIyTBjnL4oQKDnbXhljc5YoW9CyrA0aJaHac8ugWLQIft5YOmLk2nRftnbiUhKeWtIz4I86eVFqgo4u06vbUed8eoAzKLjQBbEBLTCiuaGZWUQxc6r2L9LQxXZw+z1nJmubbR8tHr6qLiSVIoyEaqJXs=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 02:08:25 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 02:08:25 +0000
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
Subject: RE: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Topic: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Thread-Index: AQHWjSD4LeMXUYhU00yzPOyYE3T3saltlsAA
Date:   Fri, 18 Sep 2020 02:08:25 +0000
Message-ID: <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
In-Reply-To: <20200917183219.3603-1-russell.h.weight@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c7c294-1985-45cc-78c7-08d85b77ba66
x-ms-traffictypediagnostic: DM6PR11MB4675:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46751A9B30656C6ED60EDE81853F0@DM6PR11MB4675.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXoaw+9t+Y/kZRpJBRCooDu/n6dl6OIgNOJB4+dZt78iH9NU9otrLtEaDccYrvViUP/7k1RKuk9xeX2copW3EdUly1PiJ323+hKloxEeYVt3wLmIlzeYzK8NBmG07oAL29FtcmPNsm30w26S9DD6gyFxGP2N0iP6DyTbS0Hu/DagqdTYOU06re5WNxWd+7hswaKBA5s/2+bl50O6RyBD8aXJgqlI9KC3bQIQPfUbPonQU8HiDrlfx9hD4VW6KAHS/0sQ4dZha3h4f9sT/SRydGbElWn92tGOI96HgST9Zk/cUe0g0cJarKL+5kIdlaT3CskEbpWBuZr3gZzee7QjfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(64756008)(71200400001)(66946007)(316002)(107886003)(52536014)(66446008)(54906003)(66476007)(6506007)(76116006)(66556008)(186003)(86362001)(53546011)(5660300002)(4326008)(83380400001)(26005)(110136005)(33656002)(55016002)(2906002)(9686003)(7696005)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0rRz5xGpgkzhGyQV156Br4Xi+gFuDzSzcNqLQnmWDxi9q7cAAXvVhdGGYwDmtAuV8blxfqNlkgTOlEowRWVpqBoeKv5J5Q5GIEr8cx3Ml8pkt3ted8D6FyZ0W9B9LcySJL1OAWA6OiceHh2lRNP2b+Iu4FEABKsog4v+wtjVZQriFsy2VvX7S9t6O8ChYMDbt8mctChastwcY8nLGmLX/XqZEatEABH2qjGtEefXNqCw3wJxopFYMe4NMfpLNimicwF6XxBTFmLAAsxi6sakpmzSX+rXjSyBdbM4+2DfL4ed0kaCIRPWlFiOddK3s2A06oFjY88HRK2IQL3H4Gjuhd10U6NjZ4jMy0F6afhsvlj327igVxdxLngXEGP6yWq/MvJCUmcy50N9T1e4O4u1vr6cn3HEBKyUHC0dGJMhZfmRLlwIOlZvjSykHK0cBcZNVksqJddBHXmH3Bvjnx39wMEklUMaf0X8viIKIEcLeyM7lYTVFu+sITY3JR2tTEVBFp+vqc2tbObpfvqN2W2EXwMgagRbshJtZ+G2SN+h6ypIpkm4kysSOfOrdJKRTdnT5jX/csP0wgkDKIfdF97UMyLrdBfrWXWveByiT9kNhSec85uK2nYI9LDur0QaPu3su6ubJhCAhv33Mu8Vk6rSpg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c7c294-1985-45cc-78c7-08d85b77ba66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 02:08:25.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TroeZSJo1wrZsvF0MgdQ+AHcMT8n3GVdn+q9xCGUFcnarCaV/gFPl7Tsjyzw490jogmrMoHiCeAs9TLfN+G6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Russ Weight <russell.h.weight@intel.com>
> Sent: Friday, September 18, 2020 2:32 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
> <matthew.gerlach@intel.com>; Weight, Russell H
> <russell.h.weight@intel.com>
> Subject: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>=20
> Port enable is not complete until ACK =3D 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK =3D=3D 0.

The description of this port reset ack bit is

" After initiating a Port soft reset, SW should monitor this bit. HW=20
will set this bit when all outstanding requests initiated by this port
have been drained, and the minimum soft reset pulse width has=20
elapsed. "

But no description about what to do when clearing a Port soft reset
to enable the port.

So we need to understand clearly on why we need this change=20
(e.g. what may happen without this change), and will it apply for all=20
existing DFL devices and future ones, or just for one specific card.
Could you please help? : )

>=20
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-afu-error.c |  2 +-
>  drivers/fpga/dfl-afu-main.c  | 29 +++++++++++++++++++++--------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..0806532a3e9f 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -103,7 +103,7 @@ static int afu_port_err_clear(struct device *dev, u64
> err)
>  	__afu_port_err_mask(dev, false);
>=20
>  	/* Enable the Port by clear the reset */
> -	__afu_port_enable(pdev);
> +	ret =3D __afu_port_enable(pdev);
>=20
>  done:
>  	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..f73b06cdf13c 100644
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
> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device
> *pdev)
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
> @@ -111,7 +124,7 @@ static int __port_reset(struct platform_device *pdev)
>=20
>  	ret =3D __afu_port_disable(pdev);
>  	if (!ret)
> -		__afu_port_enable(pdev);
> +		ret =3D __afu_port_enable(pdev);
>=20
>  	return ret;

What about:

	ret =3D __afu_port_disable(pdev);
	if (ret)
		return ret;

	return __afu_port_enable(pdev);

Thanks
Hao

>  }
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
> 2.17.1


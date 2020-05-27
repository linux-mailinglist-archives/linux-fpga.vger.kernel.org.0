Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1B1E33F1
	for <lists+linux-fpga@lfdr.de>; Wed, 27 May 2020 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgE0AKZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 May 2020 20:10:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:23247 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgE0AKY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 May 2020 20:10:24 -0400
IronPort-SDR: 3TpYA2GSiVFqai23+8ap0wN2dU38OrZR060GAca5DV0nX+W7gwtXYv+TqUpWC+K15oU3IlsRVr
 v7+3SPax00mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 17:10:24 -0700
IronPort-SDR: v7nMp2XiJV7EFF76h4BdHkEIipJoBWRKMxvgrqDD2CGY9md+XcG+JcEqWtjds334sGGQfDsxrn
 T1vT4lXWVMFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="468542141"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 26 May 2020 17:10:24 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 26 May 2020 17:10:24 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 26 May 2020 17:10:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 26 May 2020 17:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIPBWsWHVlWjor8oco4szDokCkAFM+Duy4CcxJbVG2QTL2/BkoBHK7p4I1TNoFHU25ifsow0bYeiYR2VVGILmbapaglU27KHku7hiLLky7ztR9NoEe0qPc5wPRwMnHuuGqwrCIJocAAsaOMbPVLr6ckT1jHzdqFUnyaLNZYPg+wk1+E+2hcyzWxBxCM+y5JtTdO2u5OuKp1pcRA81KwV5nEGsGS9lDiBtNVaxqI4cXeeA14PLu4xQJiK6crE2EarFwPotmkJVOVW5t64FIiz5zuYCHgOIXwZ+oLhqb0wjGMjJFL109vaQnQfLhKAxi4FT6fVd6qqgFgYff+BVOTJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfqlpgYJmwHq0p/+dO5KqZUiAtuu21QfTfm9CSw9lHA=;
 b=lBO0GZnnTcZRGom3VEr/wOnN7sSYRY4iPZfx3+31AKpwhO8746YM3yVKV1ZQ1qMIP2sCFdX6j7VkC9wPdfrvhllHWcq9N3KUFJVVI1XSR79FBX0l+Q6tQv1csm709AS6oDL8aA5UuusOmtKU7+gDYP28lu3R1xT/v6jEZzTF3Io8Vmlz9woXOaDaWYoulVkeXNNywl4Fi6pecmKn7rNKJU5szSDq4q428J8UnudVg3b2iyr7RJMOMK6o7bj9E4Zh2utpaOc0PTWZUvPjKE/m1b6uIckPrqoK4cVZt7MFfTb56/yYKFWoeZWF9/qBo3QLYjG9EXH6POwPSeHzP+Ngbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfqlpgYJmwHq0p/+dO5KqZUiAtuu21QfTfm9CSw9lHA=;
 b=dqoPsmHzM/ngOH+a3egqxgl2mlMTN0LNrImQsYPFNc/mHfHaxkDlZo76ftsGrqyK2sJRPwBL0QS4oipzonIPYpWE6HPFyZxu56ZZEwc/xdN5UCxFQTUsIgJqQKyPhr8gKZcp7wuKpLI5KoIb5sBZGPWZIEWJBSGUPlJO2KYr+oY=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4236.namprd11.prod.outlook.com (2603:10b6:5:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 00:10:22 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 00:10:22 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Thread-Topic: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Thread-Index: AQHWMuJh/641O4C8q0ecxniNA8fdhai7D8cQ
Date:   Wed, 27 May 2020 00:10:21 +0000
Message-ID: <DM6PR11MB3819416F353D38A57131F0A385B10@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200525221754.433023-1-jhubbard@nvidia.com>
In-Reply-To: <20200525221754.433023-1-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f4d2eaa-16ee-4831-695c-08d801d2591c
x-ms-traffictypediagnostic: DM6PR11MB4236:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB423643D6CCA4038D1C2D8F8B85B10@DM6PR11MB4236.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DU227MkcdNEFNZuo28pg+WxptjggMPosvcaJ8mMSxFKdJ+pkTFUqGHM+EHWsM6/URkVvBNudeFTphmTUZ2ecpUadBTCWuqWUqBip42zQ+lBYTCbw1wQi5Tl3ghVJ7IQhS/fjL6Jl81IoUBScq/A62FxrG4DXwQItxnf3IbI19rmqpXQA06CcChbelJMGfQy2f3YFZdanIPvtigPh7OYPG4JBHcsIJ/Ehd+KntRr7OQ9DkfuE9XUd8cQDaHorB6U090qasn6vjG+zQJ/NtRX2P8XpoL0DlQNnfcERiH3QWEApSV0gW2fjnnxW5kv0xSpVgMlNh2gv2nr8lLiitgUcRPY4XaUyobNRyu3BiuFXxyPiNGfBSN5+FFdJER0yb27AEtJPBx3Q8ABtlcWTkuZ5Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(186003)(8676002)(5660300002)(66476007)(478600001)(966005)(76116006)(66946007)(52536014)(83380400001)(54906003)(8936002)(86362001)(2906002)(66446008)(66556008)(64756008)(316002)(55016002)(71200400001)(9686003)(6506007)(110136005)(33656002)(7696005)(53546011)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: on6ZhfWydE81bakIVjG99jVOsfCSmBgCMXQTPE6mWsvNmADOX5cF7h/5eQc3zIXlZ2ECsfm8PDoxjU6UO9MlxBWWzAoObn+ZrQoHU8TS5IXlKaFEw2DeJQ5b0t3LHYZcn5N8x+Ka6ck3B8qYWydDXEZn6QaHWGJCLhM/G+QfbeSBPPZHYpdrd98BoinC9L/v66x6NsBIi8rnb3KKRgzH+IOMqgCJCS6inYGVCYtwZRnMGv+ed2QMNjdq8KdNlh5FmygXVLeRU6lkPN5llBLGKn7U/fPQfo9MAH/1XtAqNR1TpTAkON3LhDojZINFCDXQREFPW2pa8uDjsqEEcFeWBqBmN4izhyrGWzWY5aUOftSnUs3RwIn2YV3Nwxno9BEXnmcEDJBm+z1iyjrlWo+4y1e7sxE4LroEUKLKDwANEkINB9NshgyMlwyOhNXXdDuWi57LSKLbMnvJs6Uvdmuqswu+YhAYUwU6fhVOjkiCmt8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4d2eaa-16ee-4831-695c-08d801d2591c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 00:10:22.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uae4uNlGl0GHlUWtTtYwlhSyaOGCwK9Iv4HPSU67tDWV/tow6nqm1AijkmD/SY2AO6S7gJmuhjhTH7hDrJXUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4236
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: John Hubbard <jhubbard@nvidia.com>
> Sent: Tuesday, May 26, 2020 6:18 AM
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; Moritz Fischer <mdf@kernel.org>; linux-
> fpga@vger.kernel.org
> Subject: [PATCH v3] fpga: dfl: afu: convert get_user_pages() -->
> pin_user_pages()
>=20
> This code was using get_user_pages_fast(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages_fast() + put_page() calls to
> pin_user_pages_fast() + unpin_user_pages() calls.
>=20
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
>=20
> [1] Documentation/core-api/pin_user_pages.rst
>=20
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
>=20
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>=20
> Hi,
>=20
> This is the same logical change as in v2, but it is applied to
> char-misc-next, in order to avoid a merge problem with Souptick's
> commit c9d7e3da1f3c ("fpga: dfl: afu: Corrected error handling levels
> <Souptick Joarder>")

Thanks a lot!=20

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

>=20
> thanks,
> John Hubbard
> NVIDIA
>=20
>=20
>  drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma=
-
> region.c
> index 5942343a5d6e..0b817b722920 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,15 +16,6 @@
>=20
>  #include "dfl-afu.h"
>=20
> -static void put_all_pages(struct page **pages, int npages)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < npages; i++)
> -		if (pages[i])
> -			put_page(pages[i]);
> -}
> -
>  void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>  {
>  	struct dfl_afu *afu =3D dfl_fpga_pdata_get_private(pdata);
> @@ -57,22 +48,22 @@ static int afu_dma_pin_pages(struct
> dfl_feature_platform_data *pdata,
>  		goto unlock_vm;
>  	}
>=20
> -	pinned =3D get_user_pages_fast(region->user_addr, npages,
> FOLL_WRITE,
> +	pinned =3D pin_user_pages_fast(region->user_addr, npages,
> FOLL_WRITE,
>  				     region->pages);
>  	if (pinned < 0) {
>  		ret =3D pinned;
>  		goto free_pages;
>  	} else if (pinned !=3D npages) {
>  		ret =3D -EFAULT;
> -		goto put_pages;
> +		goto unpin_pages;
>  	}
>=20
>  	dev_dbg(dev, "%d pages pinned\n", pinned);
>=20
>  	return 0;
>=20
> -put_pages:
> -	put_all_pages(region->pages, pinned);
> +unpin_pages:
> +	unpin_user_pages(region->pages, pinned);
>  free_pages:
>  	kfree(region->pages);
>  unlock_vm:
> @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct
> dfl_feature_platform_data *pdata,
>  	long npages =3D region->length >> PAGE_SHIFT;
>  	struct device *dev =3D &pdata->dev->dev;
>=20
> -	put_all_pages(region->pages, npages);
> +	unpin_user_pages(region->pages, npages);
>  	kfree(region->pages);
>  	account_locked_vm(current->mm, npages, false);
>=20
> --
> 2.26.2


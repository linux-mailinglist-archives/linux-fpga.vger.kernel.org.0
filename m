Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483011F1130
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Jun 2020 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFHBxu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 7 Jun 2020 21:53:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:47061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgFHBxu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 7 Jun 2020 21:53:50 -0400
IronPort-SDR: BU3VBX24oyMiErs/tTOubysRSi6sy5FBeEvW2U4AikIvz6FJHxEnprIAi4iwpi4BicwMm6gIfi
 jNMDPjrxD50w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 18:53:49 -0700
IronPort-SDR: 9UuqNA6iexNkBgKaXTVlKlbqdHcGO4iRb0L+qUAVTaDMMCNm4V5dUtiZpp7cnVcWkZpk0IFJS5
 kBB5yC15Budg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; 
   d="scan'208";a="259688931"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2020 18:53:49 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:53:48 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:53:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 18:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbVM26YXcZbDNSKy0nU4kaot5o0GAatop2ryMa5DGCbS0AaAhCsdHbZnWW14iX8DU8VCww4yoHUpOyauKUTXMsosZyRY8xvVuVHB6diGvFClU+fYGrIq2hSIz5MTej96G1lrAZiQdZSSqqGzoC8auK6umN6hAGYhjBt7BbPf0Xk2Ga2at82zHrNFPcRJhwH/v7bSzfuD0PcWh4b50YKsobg193/4gRJwMqCMFPky5xp96lErGPyzl05iepmyI6shylmdxOMEgFBY3H+1abtDKhTgbzh718qbcXwybOEsW0/9cT5IFeq1KKgvLJBVegpJ1AHtKF/7/2VF0XZKPVpQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwYqQQYVckJZm3gEjAPBwHZ6eP13HLxnK0jxl/QApgQ=;
 b=mSq4yF2fcmTAhCA4xTY+bb5xfIA4uPLxzcNNgYoNAXXNJpP606k3rsTUQaZmaMIYYA8NtLP2svhv8DRYUpybOmfcxpuOyh1CaWGa4PxY3e/iD418zaFVWcIx9cVd2li6B0GPoZSkBWTjPTHyRaxRj+09+x3zp5Rg9SlnzZqJ0HO4Hr88detpPxu6ElegqOK8bD6J8WEgy7pgaZ28e3YtdTE3lQlZzb5QGRkVwqEYUgvfZcbiLo8z/K6IB2C+yFLSxl8UcJjiPzPAhRiM9Sl5iJVe642c2XquSLAh314fgusYOmisiZALz5p9OM1ARFTpvtPmt7gGH9B1xdIJdOvKXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwYqQQYVckJZm3gEjAPBwHZ6eP13HLxnK0jxl/QApgQ=;
 b=SytAYB/oO1/t64dhRX1w9MZ30o7eAF0M8EmzRUJS64eF34yVW0IlBqyfUixuds6lroEssmZoI5jQQIYfjlX2DMSMkM6vWqliopdom2fFYqEg7C4GsfoFowTeFIElzjrABFqvrZDGpd2E2YvEKsB85vJugoaJhdUfONr7Hq8IHKg=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2588.namprd11.prod.outlook.com (2603:10b6:5:c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 01:53:47 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 01:53:46 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] fpga: dfl: Fix dead store
Thread-Topic: [PATCH 1/1] fpga: dfl: Fix dead store
Thread-Index: AQHWPEXmHXqTdFbUNkCGTs942gNbhKjN8/YA
Date:   Mon, 8 Jun 2020 01:53:46 +0000
Message-ID: <DM6PR11MB3819CCD054BC0A764AB4A57885850@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200606210241.7459-1-trix@redhat.com>
 <20200606210241.7459-2-trix@redhat.com>
In-Reply-To: <20200606210241.7459-2-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72db9c8f-3148-4404-e392-08d80b4ec84f
x-ms-traffictypediagnostic: DM6PR11MB2588:
x-microsoft-antispam-prvs: <DM6PR11MB25884F3F7CD184176A83A1F185850@DM6PR11MB2588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOa6BCcPRUufMBkQs7itt44lfKF638XDP77wrsUNMh91ewkMgRWuppEFuXfTdBM5VzMLdV83VW6sBPDDQWpYFctEjEHI8IqGWYNngwO+MXWsoU7d/HiayKFSDvzngm3X8bEAxOGFd7dQCKcoh+n+8j3sOIY3jKEQ41z/Z95sTln45oTvAei8iSvufec3VvEFvBGMiUiymb2UTFjHL/VAJPsBCOWbAfSeu27NaFcKEjy+AOJZlp0WjWGlSnhluSKoXMEMtrx9lxeloIpLcJecvbrMwrdNReXbx75xT+YYdOzsjF3GZ9M/6W0qpyOlHDbdyEPIUNYmic9VYk1DBPubnYI8tdOPGXaCY6cj/UKZzPJJgzBXvoWfyYkJdD7z8UxN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(8676002)(4326008)(83380400001)(2906002)(7696005)(8936002)(33656002)(66476007)(186003)(26005)(55016002)(71200400001)(316002)(66946007)(76116006)(53546011)(6506007)(86362001)(5660300002)(66556008)(66446008)(9686003)(110136005)(54906003)(52536014)(64756008)(478600001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rBb2m9rKplrE+0BGVb6eWgsGdkvUBDkQT1n1mKcM2f/1D8BZtuidEICZh95Tu7Xwfl4cHUnhJmnHfT9ZEyA5AIftITumqENwvC+DFrDU5iNls4taHImSqCt+UbgLjqbHWr2cANilbneqJPKfy/dTFYTiNW8vhm4i9WksdP0XqrR1fB7nsZ0v8jNSjd+wBHQvn6Gq0LLDUsDYW1xE1jiT7czVYr3WX0Q7iNLSQ7/sliIMl1v/QHrUV3GQe+hnU33Jtdl+2gqWqy+8SHrEc89bH4YP8Xh8SD5oufqvxhwPEJVvzhTyBot5azu8UIU6nzHtgISRbl55rKDJHpCpHoUXULNrVwQWG+a52MWhUp8LYG1SqlDp5+Jlt5NfbdsBarufu8b62oLELg1piKHyjXLKQloHC8TLaOaDuLT9hGktdGmvHPILmQZQO9wzRY48CZGj8+lTOfsIjyuDvqBcNko3ghsUh7Qa8VRS1KKb1+6zsCc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72db9c8f-3148-4404-e392-08d80b4ec84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 01:53:46.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0sjOaaqxp3WgfyX6Vm34J3o9Q6peSSeGAQbdxdt7bUQEnBWoFat6Psh2uaFo6NYACcilaur1fKnswB/RLN1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2588
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of trix@redhat.com
> Sent: Sunday, June 7, 2020 5:03 AM
> To: mdf@kernel.org
> Cc: linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [PATCH 1/1] fpga: dfl: Fix dead store
>=20

Thanks for this patch, looks good to me, but this patch is not related to
dfl, so please remove dfl from the title to avoid confusion. : )
or maybe it can be split into two patches:
fpga: mgr: xxx
fpga: bridge: xxx

Thanks
Hao

> From: Tom Rix <trix@redhat.com>
>=20
> Using clang's scan-build/view this issue was flagged in fpga-mgr.c
>=20
>   drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never =
read
> [deadcode.DeadStores]
>                   ret =3D id;
>=20
> A similar issue was flagged in fpga-bridge.
>=20
> So remove the unused stores.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 6 ++----
>  drivers/fpga/fpga-mgr.c    | 4 +---
>  2 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 4bab9028940a..2deccacc3aa7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device
> *dev, const char *name,
>  				       void *priv)
>  {
>  	struct fpga_bridge *bridge;
> -	int id, ret =3D 0;
> +	int id, ret;
>=20
>  	if (!name || !strlen(name)) {
>  		dev_err(dev, "Attempt to register with no name!\n");
> @@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct
> device *dev, const char *name,
>  		return NULL;
>=20
>  	id =3D ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret =3D id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>=20
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index e05104f5e40c..f38bab01432e 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct
> device *dev, const char *name,
>  		return NULL;
>=20
>  	id =3D ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret =3D id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>=20
>  	mutex_init(&mgr->ref_mutex);
>=20
> --
> 2.26.0


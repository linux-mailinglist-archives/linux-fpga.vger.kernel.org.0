Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B162C3D31
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Nov 2020 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKYKGU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 25 Nov 2020 05:06:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:31097 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgKYKGU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 25 Nov 2020 05:06:20 -0500
IronPort-SDR: ZNtvEjo9tOomJlVVHZKysFCOiIPgV/spZt653PN9BTWNG/BTQhNduJ/x1dkg0SmVQt8Svf0xMR
 oUeC3QLj7xRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="169543505"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="169543505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 02:06:19 -0800
IronPort-SDR: GheNTKL25l/fUDdau6XuMD22VQz/1wGPF2TtB6rDS7D+EZP51yZam17yFnpX27YCUZZaoXEKlk
 /BjCnfxy08aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="332923768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2020 02:06:19 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 02:06:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 02:06:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 25 Nov 2020 02:06:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 25 Nov 2020 02:06:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBE66OZSEBfIljWAuZxP02lsRpET89+h/1lcsIdyy54gNx228zvwHjxdONzp2I36W7u3AFxyrx3qqhZkwwXEy9FnwOAQ/8tKw1tHSWElDvLVm1ElTS1KNBQnLuys+NgPrZ3Dobh5vk99NLth5gJ/zOX0GGsZqNiKn3HkUdeg9epUauh73YX+2E5z5qNaSgEVDL/QnxDtsJG5SzrXusetKfWrcq0ytf28LpEaSylNdqNKY2nTm4hK+kYU7K5gtZZXYzQ6oKHUIrLb4YEjIAjkNrflWuE3YXRa8nj5GcaXfa7NPjEpmsH7h/fVOd/JEJlp4UlEjKER9vp/MvxbEXks1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAciUtTetKSnoQdVv8onhaCbTKNN9sKj48gZggjAmMA=;
 b=ed0AJ+QMm1J90AnFfjWuLX2jXJh8RsDQvPgHWXPFYgEBMg/ChW89KUoyV7EoRXi8n7ezzV6WupikoVnAzJJ25H45l1TuLC8Frp3gYaO4F73r5UY1aD4dsZ96hLOFJKJrybFiZVdHkyMgdQ2x+zsCKJOGJh/BP6qkSVlKwd0IUmYEPHGfaH3yxpNPCEdcdz3Wg/iRpdE0GvZQFCp7K8pD2+qvZE2/gPUD39r2/8T11BW52WTSXE8TjKoqljUSTevibsY1MzMPce5UAhXG4XBVpH/3l71IpDOkH0YqEcNO7z3/A6ipkhM3og5/7rm3d1BlGiO+5m4IpGjq8ItJMX+5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAciUtTetKSnoQdVv8onhaCbTKNN9sKj48gZggjAmMA=;
 b=QgrQvpxXtfjtVleTXc45SLFtx21N0VHT8ve9MkjyJK4VmS7RzlcF/TBBJgn+LqmYTELdEn91i8sckaO3COfR01z+4yuKvA23tjv3n21Q6id3lSjcxJjbgtUFkZk6/YnmVJnE1iSb7r17odQDuXzdHPNXumZcAiXNNihSzmP8t8M=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR1101MB2073.namprd11.prod.outlook.com (2603:10b6:4:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Wed, 25 Nov
 2020 10:06:16 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3589.029; Wed, 25 Nov 2020
 10:06:10 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>, Tom Rix <trix@redhat.com>,
        "Moritz Fischer" <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fpga: dfl: add missing platform_device_put in
 build_info_create_dev
Thread-Topic: [PATCH] fpga: dfl: add missing platform_device_put in
 build_info_create_dev
Thread-Index: AQHWwvbIXBL/p8/Zj0+C9gs0iUUR8KnYnV3Q
Date:   Wed, 25 Nov 2020 10:06:10 +0000
Message-ID: <DM6PR11MB381903C990E8D7C76EF04E5F85FA0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201125065030.154074-1-miaoqinglang@huawei.com>
In-Reply-To: <20201125065030.154074-1-miaoqinglang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c51cd6b3-2e19-49f3-7eef-08d89129bc27
x-ms-traffictypediagnostic: DM5PR1101MB2073:
x-microsoft-antispam-prvs: <DM5PR1101MB2073533A276B8A4FA2CA548D85FA0@DM5PR1101MB2073.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ok9U9h/F3Wq0dwzMuIdAJKBaiOhU0bzSBAn3EsBUx2WaqR6Bo6uxo+zQ2+WVk9nC49NSWZnZSc+z3eoXQ+kjhxcxNnM46a5iuwe4MkFKg5GjzPPMY4HBpw5JTKBpUUsTvZTsXZ/f/olo9zLTzDrFaY+hdCBEou8uuvE/F0W8pLpKKihKHDAfLAo/o8osByHq4ZYC0WupjTfajOduEg+gZ+kKCApA6i2merC9SJLf26ck7+dcUgjxpDMFhqUXuzIRivMyvaftxBqFaK8lEbgM5V68k288zTWd131kF1OGaYQTPvL01+u8j4X/8DZyXNtHIKv+38CScfexSWkKooDotQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66476007)(8676002)(66946007)(54906003)(76116006)(8936002)(64756008)(66446008)(478600001)(9686003)(26005)(7696005)(4326008)(55016002)(316002)(66556008)(186003)(52536014)(2906002)(83380400001)(5660300002)(6506007)(86362001)(33656002)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: drJObiVcIyrpMpUN9XG4xv+4iPfex3DltE/rQmPsXQ1GD41rTJ0gi/6tnZiQql7pcCy7NtBM9gjUta5cCIzZsptw8BLD3mWigms3eDNNyatyLqE9Wyst3oE+tXUKXuLavt+eULqbV5EmMukCzQSssVO+vbdIf+JEL1mUp05gK5+3B9Dl3kwmadiWJCIOuG7MKPPRZNIXA6anp7U/vrsWJqaH86E1lNyWrmh1/gy97Z4g9Syzlb9e6y8KKr9HtT3pN/rGueF0Zot+I4PfFdooWyKkNrV2y6xTEQ3/2pgOR7czt7sNhbseHHkXNnGWxSxLo6dt0Hi/6MWRVl6qZFK9cp7BOpfZEpvoTn37g5UOSqmszFsOvy0hyklPtCO2uJUtiuczJujX9yKpMGe4tXgz3cK1Adrr9noZ0UWc1n1xFYA+tMGtGL5pjswXQeHygf2FcjbrM6lZxOsfuCTUHcjQGHA3sk9ns3cQ7OnkIiA0FNhL+zLfO5ucgQXU8KimHYfxZokMlJYFqoS1txiFF0fGR0ZXYVTRQJvHN11czAvuwY+/9OWoQ68meKYfxonQPMXkccb/hEtg/nkIZhTE3TUhEB0wfU8S0guJ25h6T7V20h+vok5GIbv2/rzVu5HXwsLEuUxXAItylJUlGydKGTHUtyOt5FcOKPZm7mCAl3XgFzXBHEmpzgnBL5rCiNpQ6Cs3d4btg+l2WOmmWcK/7JUOsyjr9G3+ItChQCopIkdG6ho5ZP9gcMuthzaFH7Laojc9egFxzvNlpP5KmeDXql4sJcWS5SQiauZkdF6ADtVMONz8oIe/nwvQ5EY79pN2SbUFS9PNkz59U2YsBbqE2MZVjiNE8fcBjgcF3Tr1qA+s1T7o7j5yY529PNMOT2Lyov76PLOcdxmNL/UfDEPM2xIzBw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51cd6b3-2e19-49f3-7eef-08d89129bc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 10:06:10.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qt5brIdmlpoJ8hQGjX0y9vnnsCSEaPezfBoQsMVa+Zgwd6XeMdd37boG8/0V3sk0kE2/hxJKixbgZl+kXSrQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2073
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH] fpga: dfl: add missing platform_device_put in
> build_info_create_dev
>=20
> platform_device_put is missing when it fails to set fdev->id. Set
> a temp value to do sanity check.

will this case be covered already by build_info_free()?

Hao

>=20
> Fixes: 543be3d8c999 ("fpga: add device feature list support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/fpga/dfl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870b7..8958f0860 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -877,10 +877,13 @@ build_info_create_dev(struct
> build_feature_devs_info *binfo,
>=20
>  	INIT_LIST_HEAD(&binfo->sub_features);
>=20
> -	fdev->id =3D dfl_id_alloc(type, &fdev->dev);
> -	if (fdev->id < 0)
> -		return fdev->id;
> +	int tmp_id =3D dfl_id_alloc(type, &fdev->dev);
> +	if (tmp_id < 0) {
> +		platform_device_put(fdev);
> +		return tmp_id;
> +	}
>=20
> +	fdev->id =3D tmp_id;
>  	fdev->dev.parent =3D &binfo->cdev->region->dev;
>  	fdev->dev.devt =3D dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
>=20
> --
> 2.23.0


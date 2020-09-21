Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41D272A4F
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIUPgJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 11:36:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:14365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgIUPgJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Sep 2020 11:36:09 -0400
IronPort-SDR: l9NNHBS5tCx5RQKnVtB8UJQv90hIXDA+L0Eg5AWrBE6xOmTwxJyn0t8LVf2kD0dCT9j+nbP5CH
 JP75pwT6jdIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="140412176"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="140412176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 08:36:08 -0700
IronPort-SDR: 7ad+1nVDeDsYLl6lKHH1rGCwQwYKodf6VPRjBm/yFyFSLtsis/mfLXUp/eAVjyVUeMIpo3IS3N
 KGIFQ3VA2HrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="290030759"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2020 08:36:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 08:36:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Sep 2020 08:36:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 21 Sep 2020 08:36:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuPw/bCKG+dBb5VyB9USFI1Jx+DErhb6+BDKgOLLg0DFvW1S07zky6/48a/KR7wWQwr+51aiwtQSVICDyME8AJV6NFkXfTI0g+T+oSPKLxPZH06Rpeutjft+lP+28BxHCFaNILnfbbcUZ/7s/HcpfKHQ9YGtg5OM7f5YxPNcbNs2i0wcFhAgqJmqq39F6mvriZa79cAF1axRdZkixRM+ivZ6+jfB2PXJ3VVlrQ7jt3vL7yJjNfbNtgoOWeG/U4rKL13fc/j7xhKiiL8c4jhy144NpHE8SwbwBLdqzQL4lX4Bkeg+Fz3/DUNWUNMYxKGNVaHmQo1q4MVt73AUa20b4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjG0io+Qg4tuV7D96afQI+wfdt1aTUuu1Pl8McnNhg=;
 b=ZiabBcZnAf09/aoZ1ccIETpFYr02lrb0O1/sKMqfd6KDXnOaavhiZdE5pzZ1h2NaK0P9xzvEGEsP6tm9JZMJVks4uvuSWjInXlsFy3iH3HGQupcPJhg3a01Bk+96uiyuxf2LUHMD6svaufGuE3VLS0gdIWjnQd8nFagCLrNj/exz+g9neUMLz+WVCWPVXrwCQhF4RTSSuHpYacDTaJLHGGHM6xOc+JiuWr/G6XWUlt0Co39fOb2UGvGwRcO0CeC7WhPS271o9ROiH/kOkv3URXF3y5EMf3MOLs+Kpoj2E01b/msBDPVtoT45s2BHsX/5gJiaocONvDMcv3oZTz5Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjG0io+Qg4tuV7D96afQI+wfdt1aTUuu1Pl8McnNhg=;
 b=UQv+WP34YXHFVlyhRiyqNHLVyGbW51pPgmMTBmDZYfkBDGD2Byn53zz0YNpsX+/gf4YHfdXIGRXiyxUXS7U2ppVrZ+zgt1+npEcTDupM6yRXxO56rhYq72HmEXrnuJ9S1WCo0Doc0RQolkQdkiLbkt9cq3HccxOydqqA+g5VKcw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 15:36:03 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::7823:516e:1ec4:a60d%5]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 15:36:03 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Liu Shixin <liushixin2@huawei.com>, Tom Rix <trix@redhat.com>,
        "Moritz Fischer" <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] fpga: dfl: simplify the return expression of
 fme_perf_pmu_register
Thread-Topic: [PATCH -next] fpga: dfl: simplify the return expression of
 fme_perf_pmu_register
Thread-Index: AQHWj+2UJse7LCHF60irHtKEohVbWKlzOYfg
Date:   Mon, 21 Sep 2020 15:36:03 +0000
Message-ID: <DM6PR11MB3819DE1E7F2FF14DF12C5D48853A0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200921082433.2591305-1-liushixin2@huawei.com>
In-Reply-To: <20200921082433.2591305-1-liushixin2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2f4b0a-af52-4ee0-79b3-08d85e440c8a
x-ms-traffictypediagnostic: DM6PR11MB4644:
x-microsoft-antispam-prvs: <DM6PR11MB46441C3F8F12114D2D7D7891853A0@DM6PR11MB4644.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KDhtwRlnMgZm3VmVO8sj/C4S0q6YurAX5JrWzZd3teOidRytzb+GX4TENWdivuiim6BcatWHBvEHOhZuX0epL6NQAYUFPf4WjQoOkKRC5LyPm0Kr3HteE25MASGXX+1clMaU/J4r/M53ZEE7aahWZ6KtCbHuMAfEHn6sjN/GNY4vB1LCk76DGe2pM1SczddggOu3RAhg6Ljxs/HhG59Nle4ycb2Tvi4dmk5UIfz7t7wf+mGyV7OIAxaSKyh+2dbmMtW6Q+TkIFwQddJLVWXp+UIPW/y40cH0THkoMPGqVCvoPbNEgAbdDO9lICOXlWd2hR+NVJf7cXa02qPex3EAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(7696005)(4326008)(26005)(33656002)(54906003)(110136005)(316002)(186003)(478600001)(76116006)(2906002)(66476007)(55016002)(83380400001)(52536014)(8936002)(71200400001)(6506007)(86362001)(5660300002)(66446008)(66556008)(9686003)(66946007)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ksaAD6GSGn56wGhSDBuuxQS/QNwiBgvFNPAAT1KagIR5EI3JoQfuJPGMCVcNVuiCg5n3jocycc2QrqSjr3LlrA75+/rhQJ3X0kKgWRS7aFLJfNy/VCTRzV4nWmWjf6aiebWmap++WkYOhklpI2CA/h3pbGZhMuAxKARZPTIe5CLY7qS+AXjttdBr7jVGVtCZiX6x3w+ES7eeWe7bx8cm9QiU1Srq/MY/46yTCrr5k4b4m5eoJRKmVqtczUIowDw5iP9GnW698BwtoN5IX+DL4QYcTfx7OJfXhqa9dcDod4ZRLdDTIpvL4zLzwJibZdEvH7ufFRvtViaGXpooyNiOHPFNgMb2NW+HNoJYOFAN85yRA05DXaTO2dxhpMArx0VhFCCdJNdmfu+v958wn3K9QWlnq+Znq//tw8bWFv5YgbIeqltsnWIA3T7A2prNtTal6s2vuaSYfjMzUs1wI5OC13UQu3HVd2LG2ERC98ypUS0NskLsUuG1pbfqWdd9yNo3mm5egYodIbv7OlgDflsyZj4e8IautdmnH0lMqDV9KPnLpFr1GXX9aXfnO+tTLRoim2cCl6eEgFH0+DOnuEo4kpX6+7FiEfvXsnRlbCFWemIbXHMtE5BOqPz69tFjKokq8WWeeV544ULuezUv7QQKuw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f4b0a-af52-4ee0-79b3-08d85e440c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:36:03.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3XXqRptSA6GesVIES4/fGjSQurc1nAEqQq/+VP/oyA3R9hLQyE7dMbNY2lJjUh4yaQ4lVJfp0zx6ncvO4Y2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH -next] fpga: dfl: simplify the return expression of
> fme_perf_pmu_register
>=20
> Simplify the return expression.
>=20
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Looks good to me.

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

> ---
>  drivers/fpga/dfl-fme-perf.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 531266287eee..e881fbe6d838 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -906,7 +906,6 @@ static int fme_perf_pmu_register(struct
> platform_device *pdev,
>  {
>  	struct pmu *pmu =3D &priv->pmu;
>  	char *name;
> -	int ret;
>=20
>  	spin_lock_init(&priv->fab_lock);
>=20
> @@ -926,11 +925,7 @@ static int fme_perf_pmu_register(struct
> platform_device *pdev,
>=20
>  	name =3D devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev-
> >id);
>=20
> -	ret =3D perf_pmu_register(pmu, name, -1);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return perf_pmu_register(pmu, name, -1);
>  }
>=20
>  static void fme_perf_pmu_unregister(struct fme_perf_priv *priv)
> --
> 2.25.1


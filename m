Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD84C8480
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 08:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiCAHA2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 02:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCAHA1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 02:00:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EFD6540A;
        Mon, 28 Feb 2022 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646117986; x=1677653986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pWteXtOAws3L/6/3VZGpPtrr3Y1Gr61yph7Mk4CEZRg=;
  b=F5IdLO4RasvYxvZx/YA1Ab7JP25riSQw3Ezuzii5f1C3bDDGm6rp/fmH
   Wn59Ht9lVo9EDVBgLMwagOb4iJMWXUdOTuGYE3ZtKtNv2xietwSoPYskR
   a0TVUk0bZ0A9i19TQCgaY7jGZ666zztrVuDTuQ2UGHQbdW7GRKyPE8/Ua
   OobSBwgsJD3N371+YEAQqHpWjqoOygCAb7fsLS8iKpUM7+4egIGczSbid
   gOrTZ0VMmJEf5CqouGQi2JsZST8G9InZ8s4dNBTpPUc0/xrPMvADKwfP+
   P6qdh0sFYWBKACEs0csXmGdp7xNp8cToWxRUjdDWJD+g2O08gByXSDSow
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253264351"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="253264351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708949738"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:59:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:59:38 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:59:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 22:59:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 22:59:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltL8wZ9m/90fXtpBk5NzgIjKIfAhI37yhC8uYLceNyg2zPWv0h4ynzKHDDC5xoYgX+g3D4GXQi4VRMqF5QixHskNF2mmLIxlzO+N6h/eppEjq+EeMbMwlz52sqSDQcQu48pnsw7DQOWwL+gefte6+YZ/GTVtG0VFuqT7W05hVxIcrSvvuCSxF76RAP9HfTjkvb2PZmk+Rjdpu9FT/jtag9+pSH/Fvwi5a6oRBtIcglm4j5BgewuJaBzzeXglbbGDCmEI5HJRyQxZkK4B95mVDEPugZ42P1Qif53xTFhlSthzhHk0MlzcZdydse8wEkiDxXeL3IhrTl89IX/ZZy5YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69HYjlskdkJZp2tbSE76iMa+vbnlkaRuwp7p9wChvGk=;
 b=NZ5PBGUQTB3We18umHZmk7mkhtlgdeBTs3fE+PQL1hhhYS8UgRoB+LDGqXDUt0HVjmhFQkCDsRL5Kh0e9AGlgntlONZO+VoA4Q2sW27kY0YoWqNgPy/w5RoZJEyFq8RGjVPZKvgzUk2/PCFz3NAEUDtpMYk41S1TZa1TFWsdMJF0/DYge38hqJaUFL6lzOasqhO+f0jAkMFV4ea+JLFAlzbhC64yDASHbXwPjqoaX81DseFCK3yYYCgMfjZ+loId1JXHz2xjDA30BhdESRdU6G81fkTzxYpNYtxLlIIcOZKz4xEQPXGIrTwkjCKEV/0nNFHp+8iWM9K53anGDTlBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by SN6PR11MB2688.namprd11.prod.outlook.com (2603:10b6:805:57::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 06:59:34 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:59:34 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 2/5] fpga: dfl: add features in dfl_fpga_cdev
Thread-Topic: [PATCH v3 2/5] fpga: dfl: add features in dfl_fpga_cdev
Thread-Index: AQHYLTUPqMoVSQActkiYTWBDOVdRc6yqFcGw
Date:   Tue, 1 Mar 2022 06:59:34 +0000
Message-ID: <DM6PR11MB381957B15AF4452EC203EDA485029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-3-tianfei.zhang@intel.com>
In-Reply-To: <20220301062123.818687-3-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0352ab88-2519-474f-38bb-08d9fb510b30
x-ms-traffictypediagnostic: SN6PR11MB2688:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB26884B6EAC38A2B5C4C8EB2585029@SN6PR11MB2688.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F2WZ9p3GhcfqoNjCiXBkvIjp7xkAcmYqTBt4GPjkZcFQq7jenN120jzErXULMZ9xoKYNr5XMHQ0bNqYUvWf7YSKt9yhfLiyPFMKK913TexVbGZNpl5qCs1FMVZHNkzyX+FO/E9YPAkbhORPERikVK7EEWEEHPOJeQh4J5yxHxsIOio4HjAHg3sKqCjOx1ab29oU9hT1B4sPATB4Lf+p8RwWQ8DW9uMoeFa5PFWigkjvFYe4ZRj+zwn4rlVQnkeNp/ynh4rq+g2MNPQylj6VQW69Ya6u8xanDz0aodIc0IV9+3NPOhGvyMyw79gtPn38SQyVNIVOqYjyxAacsCZnCt207AJ9pNebKNkTxCl3vvSBdQqpmIe0kVroo63eT+7nL63RT1F2BOcszLMawH6B9572n0jgx8J+44Odjm2AWpTCQIKVUVgx9bFj8wpzsXLusxq9voTo2D+FjxqyrM7wa7BFGlkeBfShVLM9JdNMLUpvvMt3IwguNVhxTRb8UsAKjOjlhSC20AT6TnB2Ewo/O4UDO67xmFGgJP5GdzEBlmNZw5ovvUbqkpw2GMpUHBgzILFRSPor2UzDmR9+6z7JTkrVIxyOi+ry2/miFeyXpcmZ4zO4m3QHzCd2sG/WqDBAycwzIUgZ46VtlsqzM7gc45UOSDLKXT2UrnrBKqV5e1OzLc7WRoF7+HwG94xjHwl46Fjx8LiiXc94rKs9/+iYXIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(8676002)(66476007)(2906002)(4326008)(64756008)(66556008)(66446008)(5660300002)(76116006)(66946007)(55016003)(508600001)(52536014)(82960400001)(38070700005)(38100700002)(8936002)(86362001)(33656002)(71200400001)(110136005)(54906003)(83380400001)(53546011)(316002)(7696005)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7a8QlThyMPX1vxAQmG3dD1Lo3LZ+pSAc2ayXlShrYU3y3hT8ZiYhDeIrKlC8?=
 =?us-ascii?Q?B3JllglSF1sIaaMmWo7Pji4a26CEC46nfTtaypUE70GpSeFd6d7/1O/5aSuH?=
 =?us-ascii?Q?MTn3kh64S759tIilzsy83e3Gi216NIMqC7RPu5r6mF+I8oIb3tXM0FDcyLv/?=
 =?us-ascii?Q?+uOwCYhROp0zb2NFopjxGUiDsvvOcGi1TczGQcUKF28PYylOaJS21KtK04xA?=
 =?us-ascii?Q?+7jWUDIZtTKV3XJ4RAuGxLyZlq4e0mjBRmeiZPPj3+piex3E0u7d/i0uVaoM?=
 =?us-ascii?Q?oHhNsSiz/lrgk8tuj81sY9dVkemRyG89Wk6OW8Xjy/xBZTwayDsDVdsm4Si7?=
 =?us-ascii?Q?aVlPSJT2MLDLwkVegAebJVXg4+5gu5//wbjmDyNV53VVtbQJnBz5NvnmqwvK?=
 =?us-ascii?Q?TCl16DEK6HuLr8a9NbYFwMPsPR+RgMclCdkfEojhg4eR8YDLsllg+FvzUEN1?=
 =?us-ascii?Q?X75nsEcRkL5pgP/yRC0AlNNKGQUxlELym+LKCexTIh0Xhns0b0iVZlSAejVV?=
 =?us-ascii?Q?G5Z4a2KUx8+J2xPXu89y6cMPZ0cw/kAefxJr3xBI5TlBjBnT5iNlcTq+KIhj?=
 =?us-ascii?Q?1rUweCt9QzpNuEREiHjjogzLv2P7gUOU7n3HX3JHN43pz2cJb/xtC6Bm16uq?=
 =?us-ascii?Q?PvU5BeJy0vdMX373M1tp/yqsQ2Vo39xd4NwXCYNG9HUmxbMU7QOrdQijptxI?=
 =?us-ascii?Q?bDJWfF2PrUI0U8CszNo+MyaIlXrn90n6kn9fSohfBgw8/7VJWihIkGQifBzw?=
 =?us-ascii?Q?yIDzmoyE5rNnEbHZ3XSNDnqcj2cynqMhWUxkKkLRDK6xSsQxYJNR08NgfcUQ?=
 =?us-ascii?Q?iG2PCbBb+G49wjxYkpXw6BoKyg2XGflqHt7pFvD1ufe4qPxj/FujeVPGb71g?=
 =?us-ascii?Q?umssDBN4yaix8U3hIgp8wzUQocq7tTdcgh1NY9v1bXsGPFePACv83Pq/QNPx?=
 =?us-ascii?Q?lsz/+J7sY74NJQ6V8ok5NLNoha35/fIwZvckrgWKwgd/5NuWCMEOF8WX3fWn?=
 =?us-ascii?Q?rivcqbN0tHTdKuKxQKJ3ZmSr2fxdo9xJw+WyhGI/+142+/jSpqPI9U5low6i?=
 =?us-ascii?Q?4PI015C3NoDBAu9U4LvUR0GVka/oRwhVFWlVxHnYN/4NOW8jEz6oA07d/ezo?=
 =?us-ascii?Q?yxPds9BuVJIVXyn1EezHCxNd7ATwjaiTmPAyw94PklTZ8VLBCAKDAGtSGo9O?=
 =?us-ascii?Q?BhLmSdOPCp0gJ5xDNr3IN+mYRBCE6gck+LYQPgSNIQS7ZJIuYyzHZC9edEas?=
 =?us-ascii?Q?IgqEP1Y+IhS7Fz9WcbRl3/PkK4Ont92F5rfuzDdcll79+7ZcCTcjMsvobE69?=
 =?us-ascii?Q?IN+If0AD+KJneh/MFG18ijISzhH+fO/pvstqDUXXXOGbZVb7KAQL5Fg6ZmJS?=
 =?us-ascii?Q?pAXy7A5PLp5WH96rB6jrW52VY/VDtagvq6qKC0KrJUuAIllXW8jzbcjTKQOS?=
 =?us-ascii?Q?36Ya/2j5nWDghMhYmqImMh1dvobgxCeVGIMoE6KVOadsZGxYmX1Q1BDMWUaU?=
 =?us-ascii?Q?W9HyV1XO2JlDpH4qtINCmgDhcJIr47RW0Pf62fGFsmHLNPqMJAWH1JSkW+3I?=
 =?us-ascii?Q?tHyybxRBjfoLUvRAm5v7n8NstpWYmjoYXONT45xmzW6v+XCt+i8JfucICBa4?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0352ab88-2519-474f-38bb-08d9fb510b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 06:59:34.7174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaYxwUx6B2Mrpedzq0MbrMO+2fYDyR0BAaYEIcz1Rk8oNuXyz4j8cVJjcfluDdEn18hyEYqSPgckUd+/egln+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, March 1, 2022 2:21 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg
> Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Zhang, Tianfei
> <tianfei.zhang@intel.com>
> Subject: [PATCH v3 2/5] fpga: dfl: add features in dfl_fpga_cdev
>=20
> Introducing features in dfl_fpga_cdev during DFL enumeration.

It's a little confusing, maybe flags is a better name.

> On OFS, we will add more extensions or features in DFL in
> future, so adding a new member "features"in dfl_fpga_cdev.
> For example, in the legacy model, the AFU was connected to
> Port device, but in "multiple VFs per PR slot" model, the
> AFU or PR slot without connected to Port device directly,
> so in this model, we only can access the resource of AFU
> or PR slot via VFs. In this patch, we introducing a new
> flags DFL_FEAT_PORT_CONNECTED_AFU to distinguish them.

Please consider where the flags should be, cdev is the container
of all DFLs, is it possible that one cdev contains two ports, one
has AFU, the other one doesn't?

Hao

>=20
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl.c | 6 +++++-
>  drivers/fpga/dfl.h | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..5872031c2e9f 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1124,6 +1124,7 @@ static void build_info_complete(struct
> build_feature_devs_info *binfo)
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
>  {
> +	struct dfl_fpga_cdev *cdev =3D binfo->cdev;
>  	int ret =3D 0;
>  	u32 offset;
>  	u16 id;
> @@ -1160,8 +1161,11 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  	v =3D readq(binfo->ioaddr + NEXT_AFU);
>=20
>  	offset =3D FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
> -	if (offset)
> +	if (offset) {
> +		if (dfh_id_to_type(id) =3D=3D PORT_ID)
> +			cdev->features |=3D DFL_FEAT_PORT_CONNECTED_AFU;
>  		return parse_feature_afu(binfo, offset);
> +	}
>=20
>  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
>=20
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 1fd493e82dd8..6171bcdcb3c5 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -461,6 +461,9 @@ int dfl_fpga_enum_info_add_irq(struct
> dfl_fpga_enum_info *info,
>  			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
>=20
> +/* in legacy model, the AFU was connected to Port device */
> +#define DFL_FEAT_PORT_CONNECTED_AFU  BIT_ULL(0)
> +
>  /**
>   * struct dfl_fpga_cdev - container device of DFL based FPGA
>   *
> @@ -470,6 +473,7 @@ void dfl_fpga_enum_info_free(struct
> dfl_fpga_enum_info *info);
>   * @lock: mutex lock to protect the port device list.
>   * @port_dev_list: list of all port feature devices under this container=
 device.
>   * @released_port_num: released port number under this container device.
> + * @features: features discovered during DFL enumeration.
>   */
>  struct dfl_fpga_cdev {
>  	struct device *parent;
> @@ -478,6 +482,7 @@ struct dfl_fpga_cdev {
>  	struct mutex lock;
>  	struct list_head port_dev_list;
>  	int released_port_num;
> +	u64 features;
>  };
>=20
>  struct dfl_fpga_cdev *
> --
> 2.26.2


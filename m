Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75F4DC112
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiCQI04 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiCQI0z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 04:26:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4E16BCC6;
        Thu, 17 Mar 2022 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647505538; x=1679041538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lRKtJ2ZsGyy+5HabjF6x3fqMAQy+ck6B2gxbJGYudu0=;
  b=lzG/JulovKKxWslGSSTXpbTqbHlhUBpPWYqEfe8NwM1A4FYF3jBS3ocA
   SAUSL4TsvCxZFTkMjDIY/sRCdft4P2Ofjo/V1R5Hvs/ncPYFYKfmokzqz
   PiGUV6f/Nhf90+nxsgsJpmTZUWBS6RUvsA8PXSetS4bsSN8zRG6OSZetP
   ULCrfNc4pyKznp+HM/LA9nQES2Sg9pEv+eemDuGj+g/QuM3a7UKUV+D1C
   /ExuUGRJlCSj3AO7jGz9RyUdQZcjaPf5nnohanUgjOW2Y/v2QrAGUplLO
   l2QtO+1etQvqXIlJ9lIcOX/9pUuBOJHUqskQdMGKtCZkITtzQ9WV6zWsw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="257002567"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257002567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646971167"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 01:25:38 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:25:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:25:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nURWgH0HaeOWuzQwYWV2llJLESKpnvP4FoWIwYXHIITcz4uxgg6ajfC9hzVXGy9iDs0SqCqhDWgC2Etiqe1H8iNHTCkRQfnT4Ii3GSSIbovSvhA3E+41AckGY0qgaGmmYDO9vpXU0of9uHP9ziwr05ifgFWqf52rfWm4X2hoiHujbTFdzM7O4kYQXKSrMdhusfKQukmh1T/aygFOo05jsXXlPJ6caQ8R2RRKODA1Rzg6Vef719eNzIFnYt/1uHZrEZXLgcdcEcFjA/5GiVwxuNK3P1ILSVQzRDh/9kB+pA6OcdDHq+Lr+q1UO/GR8/I9EGKDRLCWt1kDYXV4bUrDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9AM9eKxTZq1BEqZlVncFVg04WKeG2JksF69C64dDpA=;
 b=lC8ioVzbY/IlUSWnyU0dEQYTTzoGlby9jGjKzFcUEXEczCQ18+il9WpXyyZvadU5rW+87grHPYNUG4udHwVsOABgYCkGkvRBhH9n90wOYXymD48M1V323CwR3rc7GjN2O6bsDZZA9CqkYZSVhlL/iKVSExcCu1EoYBp21Nv9b5ckmEupQ3H9J4GbILfEe5PxNEB1RqikqfFU+oK+k4OfSkdRtAj5vgm8WFGgKptQwnYTdivW7hf1BUaq05gYkZ3QHTmK7GEY9S53apfC/eEBEy72UtL8ZEjF+9fUBzYTBDDksSWncwWUTqOa1NK9YvmAgcJclsRPT9A/l1grwcCNLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4153.namprd11.prod.outlook.com (2603:10b6:5:19f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 08:25:33 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d%7]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:25:33 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
Thread-Topic: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
Thread-Index: AQHYOQUdByxZzeJi+E+POSFjFU02WqzDPQvw
Date:   Thu, 17 Mar 2022 08:25:33 +0000
Message-ID: <DM6PR11MB3819F26BDA4AA2826AFD5CA285129@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-3-tianfei.zhang@intel.com>
In-Reply-To: <20220316070814.1916017-3-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 21ab222e-672d-4d57-fe86-08da07efb4c1
x-ms-traffictypediagnostic: DM6PR11MB4153:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4153FD6567BF39A1B385EA3E85129@DM6PR11MB4153.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RqG524alAtGJZXlPbgAMwNVpHXGHMps/7SMvLAZgN2dRLddzNtaaUMkd09e35v50/4VIqbkkf99wl1HIh4kBkSNIWXRey536S7V+HfG+sq11SnxFJhEPARahc0osMxK7Kj+Gh34AbLu9wTQxbdQsX+6ov0zwm/LT/p1jlqvnqBgo2zWMjAWhAUCOmtj+trRR6kgNLpxgnni4gNUaupvnQE6vW90JDpqER9V2kyvijPpo8tkWQRDSJpiC4Kj7gaPX9f34bURwB9X0mchqCKn7/A+qlR9sucderVmIMKoNKbOZ89WCCR0Kn+88+K/xi9pBhukhLMmN1S6vhE+NSoc524+l9qpUzOqWc9etWr3zc+42NlKcml5HhetRWSqA70A3rXcwHK25dCCRIb3K2mdrjYPLW6KYM7VAQO/f0NaPhJFgOZ6VK+XevOtcQYh9GS7j2xhf+iIHGmbMFuKURSm6BD25HJws1rpk+gHL9SVJG1hBtEk9YWI0iX2W1LRgJdoLPyUc6UOMHmELSkJOxpvdO/hidv7Inx4LHYR2MUM8Xo2Pnaejq5Oha6h3yI5feU4L9FVxPvv2kBTIjcKB5g5btZG9nPVGmtwICwP3TNlplc6hx5zZDfq08UfWVW7ofY4f3oM3aaChppCa62yxT5WJWu/64h4uFGjkVJpWo+7hS8sP9VKMzf1RWvOAMwW0fDoz8BlT2Yi2te6pgctDtcqZ1DWuje1ZO4NDEtGIh9gtk7A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(2906002)(83380400001)(122000001)(38070700005)(921005)(5660300002)(86362001)(82960400001)(26005)(186003)(52536014)(110136005)(54906003)(7696005)(6506007)(53546011)(508600001)(55016003)(9686003)(71200400001)(8676002)(66946007)(66476007)(4326008)(66556008)(66446008)(76116006)(64756008)(33656002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CafAabVSggk7WJRTgscuKrSGsUJ8WOQmCqin6LRo70Z4Fle+5SJjb9piYsiH?=
 =?us-ascii?Q?cpyTkohsR3JlXYQ+k83XqrsrSF3C70EdzZLLcbrYWHPqjxg4LEw5gEaogH3U?=
 =?us-ascii?Q?HlgFVBbXkR+3hCx2Z9LEVHd2IdQNJfpXMgkPts9qeEKNhxdMGRwR+E9JNnIh?=
 =?us-ascii?Q?qnCvkrO7+eTHzudaYnqGGkVo7N6em9/DmN2XCiiUfhKqMNgxwlFyLw+OIIgl?=
 =?us-ascii?Q?i6QXkPVwm0OEVqGsQiby5P4gb15/dax3U+w/TmPpgai/UxzOsYL61Aysr20o?=
 =?us-ascii?Q?JuLSoEto3GDxTT/UKY3UyOAxTYGPINpJ0/RffrEddVBRbiztl+J5HltGiBZt?=
 =?us-ascii?Q?05nTQdrfQUWfdnBsVIibKDElnE/oq7KNyLnxLzO9vyj6v0XwJP2YFdlmEmZy?=
 =?us-ascii?Q?igW5LUldvuANTj1ego2KPFKovgk0qc+/hi/MQp3o4+jwlkfjo0JU7k1+Us7b?=
 =?us-ascii?Q?AloWTEB4k+CsejM2u5oe7IIDY7gBphG1jl8FCMSdc70kTMoogGMSgxRSNwoX?=
 =?us-ascii?Q?YITXjrE+kmiXPyyH4pHSdL8bcSA6Xhl5gXkJ69YWrmNbtpKDsTb1fMeMzGxf?=
 =?us-ascii?Q?eph2EAY+yqQ0pY1aSKgv5aHkobDZFCCyqjqHZnEOBTPYb2E9g5HH++g/w+OV?=
 =?us-ascii?Q?jQW7FhWRjh+BP/SqyqvFrM74ZQ2JrX0rvNU6wQXvrWukXb6eg/MHFopvzdcF?=
 =?us-ascii?Q?Fmo6VITu6g3jgkoMeehEJ6Bp2EWZnncrxFzUJSIhBmTj6vGa/npB7ZW7D2C4?=
 =?us-ascii?Q?dIRMC3JjrBcCXbSAdonPDg1W9/pMuoqWyS7SOM04TglsVCi6tjUlvKH6nQ1b?=
 =?us-ascii?Q?0+3KKUTTG+BYhCP9VeDJ16g1UQ2yYDwTIfPbUK0a/ef/t5otftv8UqkzQUOW?=
 =?us-ascii?Q?YIny6pfT3cGQy9Syo0RNTEPHxJXF1U/hegLMceZEc5NXui5eSQGLWzXL6Rt+?=
 =?us-ascii?Q?MtofpysVsnB4UhJfCShyXwngy1f4GxcV+oi/DA4XxcLlmlVp8Nzny2UqMu96?=
 =?us-ascii?Q?O6qPKu/Qp64CWzp+IwCDo7B2RSHTEYFUly4ebiz85y9aM3Vx93JJWyYTiN8o?=
 =?us-ascii?Q?ld7iqDrzTDhewdEpVmYf0L8SaudsXfEXQinZ5iu+pMfLVZExV32Z5r8Tm2v7?=
 =?us-ascii?Q?0FMAww7uZ3+Odg2PLQga3Xgho1Kr1AksYpfLJNpQwqkEDxjhmg7yb611qxgh?=
 =?us-ascii?Q?l8ppJtrEbO1HzCwLXUuxx2/KBsFLolIau0XO3Q9c3bxL4LooUhlIPZmlsHe3?=
 =?us-ascii?Q?pgBweSn3jOhIKq7fn3XJEZclLc5KoDYswybE9rjq7uKfF9AHnwfzuZL/S5Gu?=
 =?us-ascii?Q?Pqhy1ZfKBrVRYCYc8dcRtHjTrAqlyJ41bKnNE0oXFWDt6li0lG7gqdrYB7TK?=
 =?us-ascii?Q?cZJVTt0lN9DxGQhlqAv7hbnNCg88xbM3HLgvstpP5+CGR6f1vbhxsnIHFiVy?=
 =?us-ascii?Q?1TrJE/5SQis=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ab222e-672d-4d57-fe86-08da07efb4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:25:33.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRT2Vqm1GqSlR7bZ0s/QvReFl/5ZX+zQXOkiZeaQMH5CHzM7h9FoxWnOhE2x9uMKCs/YZhYyDzd1og0bgnNCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4153
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Wednesday, March 16, 2022 3:08 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; rdunlap@infradead.org
> Cc: corbet@lwn.net; Zhang, Tianfei <tianfei.zhang@intel.com>; Matthew
> Gerlach <matthew.gerlach@linux.intel.com>
> Subject: [PATCH v6 2/6] fpga: dfl: tracking port conntected with AFU
>=20

"conntected" -> "connected"

> From: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> Introducing flags in dfl_fpga_cdev to track extensions
> or new features discovered during DFL enumeration. It uses
> some lowest bits of flags to track the port status which
> the AFU was connected to port device or not. In legacy
> model, the AFU was connected to Port device, but in "multiple
> VFs per PR slot" model, the AFU or PR slot without connected
> to Port device directly.

It's "Port with AFU vs "Port without AFU", so why we have this flag
in container device not for each port device?=20
and probably you need to describe why we need this flag. What I am
thinking is that port driver can use this flag to decide if afu related
interface will be visible or not...does it make more sense to have
this flag for port device itself?


>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl.c | 11 ++++++++++-
>  drivers/fpga/dfl.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..712c53363fda 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1124,8 +1124,10 @@ static void build_info_complete(struct
> build_feature_devs_info *binfo)
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
>  {
> +	struct dfl_fpga_cdev *cdev =3D binfo->cdev;
>  	int ret =3D 0;
>  	u32 offset;
> +	u32 port;
>  	u16 id;
>  	u64 v;
>=20
> @@ -1160,8 +1162,15 @@ static int parse_feature_fiu(struct
> build_feature_devs_info *binfo,
>  	v =3D readq(binfo->ioaddr + NEXT_AFU);
>=20
>  	offset =3D FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
> -	if (offset)
> +	if (offset) {
> +		if (dfh_id_to_type(id) =3D=3D PORT_ID) {
> +			port =3D FIELD_GET(PORT_CAP_PORT_NUM,
> +					 readq(binfo->ioaddr +
> PORT_HDR_CAP));
> +			cdev->flags |=3D dfl_feat_port_connect_afu(port);
> +		}
> +
>  		return parse_feature_afu(binfo, offset);
> +	}
>=20
>  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
>=20
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 1fd493e82dd8..bc56b7e8c01b 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -461,6 +461,16 @@ int dfl_fpga_enum_info_add_irq(struct
> dfl_fpga_enum_info *info,
>  			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
>=20
> +/*
> + * Bitfields in flags of dfl_fpga_cdev.
> + *
> + * 0 - (DFL_PORT_CONNECT_BITS -1): AFU was connected with Port device.
> + * DFL_PORT_CONNECT_BITS - 63: reserved.
> + */
> +#define dfl_feat_port_connect_afu(port) (BIT_ULL(port))
> +#define DFL_PORT_CONNECT_BITS  MAX_DFL_FPGA_PORT_NUM
> +#define DFL_FEAT_PORT_CONNECT_MASK ((1UL <<
> (DFL_PORT_CONNECT_BITS)) - 1)
> +
>  /**
>   * struct dfl_fpga_cdev - container device of DFL based FPGA
>   *
> @@ -470,6 +480,7 @@ void dfl_fpga_enum_info_free(struct
> dfl_fpga_enum_info *info);
>   * @lock: mutex lock to protect the port device list.
>   * @port_dev_list: list of all port feature devices under this container=
 device.
>   * @released_port_num: released port number under this container device.
> + * @flags: extensions discovered during DFL enumeration.
>   */
>  struct dfl_fpga_cdev {
>  	struct device *parent;
> @@ -478,6 +489,7 @@ struct dfl_fpga_cdev {
>  	struct mutex lock;
>  	struct list_head port_dev_list;
>  	int released_port_num;
> +	u64 flags;
>  };
>=20
>  struct dfl_fpga_cdev *
> --
> 2.26.2


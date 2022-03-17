Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B474DC1E3
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Mar 2022 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiCQIul (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Mar 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiCQIuj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Mar 2022 04:50:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E71C16E2;
        Thu, 17 Mar 2022 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647506961; x=1679042961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THSmDaUYhUXwpzD/LRroNFtu5MvAMJPSWNSOH7fBQr0=;
  b=h7Whcc/cMztS7wLd3UfMV8fGITpj5v0Wk9iZDjV90uIh2A90R4MXoxk2
   zICWC6e3h/twe2m2hgx8ifp0ZFAf+IlT5Szo9ybRDL9BNtPLMHai6s38i
   wvWuxdwOmcfj0txVVUPPKOgmqZytUmRc6A78lTUjklx4tphg4mjFtF89W
   mBAnsao0T4hjgKhbrTRFAURBL4Rzy+Mxmli+v7DMxya2MXzxlLKgPraEL
   8ntQIeyb4FCKyeI0xWD4rlStt+qrA4uHvtTIPfvtKgCenTmxYtN6LL9sb
   Q01ghYulRvdEGQ5fLeeSXVpV0h5dvFinCO0KYlHa8hoUR3sNoueH9WU96
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256769424"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256769424"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516684732"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 01:49:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 01:49:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 01:49:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 01:49:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlDEdta4qanKN7C37rLHW93Zy9TZ8CmnunTyfMmcR7QSsc2HLuG+0x2MRJ0Cq6u9684qUhlQEjYHx7h9BA2hE8pILyfBQZTo62Q3mpkXE/k/zkPEAllmfM7LIZCUdPCxlJYjtTzAAjl24ur9usSfCklN5ANLzBQ2+VPSvT7IP3bS+4P8GwqzvGR9B8sTA3xf4XcXTsO507RzQqP9V2ZYVaeEoARpKbMoaceb/vEgSNzBdxuyoSdiiniKrJEJ7CrGC60qNx6TjHZuQJSYBd9+9xnraVVozJAGo8g/+ZY1idd/rsmEmUi2DGj0RfddHt3o+ce6PWW8669aSbcRHNGjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz9Ff0wWklWAW8McMZ8nqpxWR3u3wDQgh0RFTkMjQFE=;
 b=bUvAiHGv3uduqXHsWGl7cY6lJ7Cq/nXDrKOyuaiI3KcUedmGQrrZrXbK2HutWXurPdXcCWrrDsb9C7xV7mSE24c1WzfCvJ5Y6r/8nGGX4kOCC0BiPurzICd2Eu4F4pHpweuGO4yZ/AOMYLeYu78aDByQ1+Zyemp2z19yxpkEBaA4BDoMqlvO/cihKu3WTW8kMc33CkwMojclZFK6K3RAHb1sNa9Q6UMJzHzNeADUDmMdGkWvMDSXGHxl5ysRAjkpepdDxOrydkc9hHYRw8bgQJtKB8uk+fV7kyHTSEhWa3mRTkNRBUl3NaI9ggQjbSc47WH6fNQtmOX2Thqq+yyl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN6PR11MB4115.namprd11.prod.outlook.com (2603:10b6:405:80::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 08:49:16 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::d9ee:5bb8:1828:222d%7]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:49:16 +0000
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
Subject: RE: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs for
 legacy model
Thread-Topic: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs
 for legacy model
Thread-Index: AQHYOQUgSs9N1UoLREyNbEPguLG93azDQyug
Date:   Thu, 17 Mar 2022 08:49:16 +0000
Message-ID: <DM6PR11MB381950AC46C7913128AE212D85129@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-4-tianfei.zhang@intel.com>
In-Reply-To: <20220316070814.1916017-4-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: f68bd180-f588-4d53-016f-08da07f304aa
x-ms-traffictypediagnostic: BN6PR11MB4115:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB41150215B2749E8A6655CF7F85129@BN6PR11MB4115.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfyFEyYpiZvg1uSLELHMwBhkL4/VpA2k5nAxdW+RYdTbTlSGV9Hm0jYKDd8x3q5MdcCcGFXRBIOq8I5XO70esOSwCGS5vqtLy1lpTni5tsDsKtW5zxqB7a0IZW76trrMqyzEI4FGgYXSGwLfX172xwNdRDc3m/ZPX+c6/WezgvofHjLoLo706r7wlf/0g3dQhUxi0plIOpBNazD8EzkSVrzaZuCFvUfpzEr3cnF2pdc91h27nZQa/N5mzhsNEF+h63o64tgt2gIZczvd5LrJW4J5HPmUPVOv4pc6AP16K/m/V9JbV/FKJ2/i7fB0iUR5YUtQaRJRrL2mpR/dXukyfLSjml8JpWEahApD39OQd4tm04zu4B+nAyWv9JdEmkE+9NeYGTPcW9iPZShnjkZ5/aglRFS30RQBzCeOceB1nwje79W/RGaECppGEeFgnIkKqejlDd96ZjOyMeNBI4534nS7ELmKtBJNs1n4eDu+XjrKw8ukA1j32xSfqUR8UGqTsMJrjm+/R6Jy2eJLKJ24RPHiqc50Lxh6zbAT/hHDKvk1CWwCM4eu7zgApdOS3ksSZhhVgRwC2/Sjd9Dsj07+xa9JFB5vxxB834+NSwe20uGvwnVxVfiYXxRk1Ee0ke3Xfm3k0fIPDOegP/fcv5ZEKRxSgiP+4PLUCsfpb6qKQCMSt+WD9pvuLAI7LTnJYfL+L/ERDndXu2HHqIPPWgKq2nIxfaW6IxVGJbpoOHOIxts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38070700005)(55016003)(8936002)(2906002)(83380400001)(5660300002)(33656002)(8676002)(122000001)(66556008)(66476007)(66446008)(64756008)(110136005)(186003)(26005)(4326008)(66946007)(54906003)(316002)(76116006)(52536014)(9686003)(71200400001)(38100700002)(6506007)(921005)(82960400001)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GDV7iqLB6yk2xA2fisPAIcViu5lAMujl0zl5i6N48XsJDEjTkLkbTkJ//+Qa?=
 =?us-ascii?Q?S+yYrSOUE6D42Ey13cwjpeJ07ApdPoho7tVnHmbUH4cVld5k1Tm/HUtc/BD+?=
 =?us-ascii?Q?PqurO8SI3S9F21l/9NGyAin8M9+XWiwz/aDd7dE0xW2lKQngx4CfQ926DsD9?=
 =?us-ascii?Q?SP1GiCKqWduK7OxojYaJYibRWF27Imw9Bpn8vIM8SDlPe9L4Hwlnn2M9G5ii?=
 =?us-ascii?Q?RP1paO3QcjIvUxQKl4fD3LNzy+z+PeDjz4LJ0yPpMtSNaJvcefy+LLE36pGb?=
 =?us-ascii?Q?KWRprOwynhO5AvSjf2UtdZR5HaefjkWPkFE66kXmIvsM68inc+FFnIv7VTc0?=
 =?us-ascii?Q?G2mtZkRxxppbQkax+LY7JjRoYlP/CAZ2SekFC0r9yAj44ANVZX5JIlZse/fz?=
 =?us-ascii?Q?K6raqza9j74rmkkYF0Vxt7/j3d1yNa1CEnUILhYbQovlVSO1GHOoLcYqfKRo?=
 =?us-ascii?Q?y/S5gKpJGv1oqr/YgGZH9mdudL43gmrxRR5+h1Ijjm7SxPUJHJ6DEbdlEdhb?=
 =?us-ascii?Q?s9SJoJsAXe0WHieEkVWGxRdBcWMEvlmHrm8V/LYqevqudc7o05ihf78mGgfu?=
 =?us-ascii?Q?mwSELna7/k05oquj5HDrAaE1ndl3D+wn8MRo5fGs2gCUj7MB4BkGExfZMGR6?=
 =?us-ascii?Q?dEQnEhKgR4ysXpo7m7fTEzzOkNokZp2lXtZMvw9h7dBVCx9O4FBmlCDjolex?=
 =?us-ascii?Q?HWRXM5MvwRXSVlrFPnufDF6bks+l2HUQC/wu2WMCEMdJx4c2Ik0hKJ++7y4T?=
 =?us-ascii?Q?RU2Nqfna+4cEYnu196Jd5PMZn2Ezwh/7Ei4UOY/zZV/uNUJEm8lRSU9/3oX+?=
 =?us-ascii?Q?76x0o6adUN8aUv7Bag8SuA8oAHh4IDgFNeEdrZao384ADl72TjfJJSVwvRfL?=
 =?us-ascii?Q?MnyuZSl6cjyATmyVqxLS8SEmojKBWDvVymyRvBGEYuYnEcQxdozn98E4aA6y?=
 =?us-ascii?Q?LmV2vUo9WuUj/Z1gdyly+G8c4R9BayrGloR4vCwBQJ8rq8CQtnrsK6Mwg/oD?=
 =?us-ascii?Q?aXbda6Uj4w+8eMepVnO1Th19DxsAgTCVk1kMUpze+0Ch44N6tuMAmtadwEkc?=
 =?us-ascii?Q?grJ80rDg5QcoN6JA5u/UscOFcwmj3bZN8vOZp/jlYPE9Qa7kr1UhaiwA4Ude?=
 =?us-ascii?Q?2WqmfA9IkmPr8fD112oW3xrHFgG04P8tTIJU/pBjCUL2NkB6Gfty2CETDRw1?=
 =?us-ascii?Q?J7fHNx0LagQB2mT6KM4eSL6L1MCFIMCudzepbpi5VqFoerC5Bsgpwf6foqtf?=
 =?us-ascii?Q?r/9h6tYKTRCuCyZ7948ZMpnbKFCvRtBxl6w5L4G6TyGNCyl+pz08ZPCo8SnY?=
 =?us-ascii?Q?KIBNjJSa6vfbXLA3NTqTvxM4MuCie8Z6lbybxaMIW4DfKIJY4OlnpX7Uudea?=
 =?us-ascii?Q?H+D00D0ww+mmksCcPaMvaGybmKYwzUkZpYiEpRChNEzw52oa27McYzQysIQT?=
 =?us-ascii?Q?J77jv0+BgUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68bd180-f588-4d53-016f-08da07f304aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 08:49:16.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PODQamkjdjvhmlhgnqC1qKltvlRvUZFyxOsyJGQQB/vtXNyxa0iWY/IthgA6XVpado+Kq4XzhFF21G2tyrgQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4115
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v6 3/6] fpga: dfl: check released_port_num and num_vfs fo=
r
> legacy model
>=20
> From: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> In OFS legacy model, there is 1:1 mapping for Port device and VF,
> so it need to check the number of released port match the number of
> VFs or not. But in "Multiple VFs per PR slot" model, there is 1:N
> mapping for the Port device and VFs.

The title and commit message seems not matching the code..
From code it sounds like we are trying to skip the PORT=20
(PF access-> VF access) function, as new SRIOV usage model is introduced.
Probably we can skip it early in this function or even skip this function
directly. It doesn't matter it's 1:N or 1:1, we always want to keep PF
access to port, right?

>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl.c | 10 ++++++----
>  drivers/fpga/dfl.h |  2 ++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 712c53363fda..b95b29c5c81d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1707,11 +1707,13 @@ int dfl_fpga_cdev_config_ports_vf(struct
> dfl_fpga_cdev *cdev, int num_vfs)
>=20
>  	mutex_lock(&cdev->lock);
>  	/*
> -	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
> -	 * device, so if released port number doesn't match VF device number,
> -	 * then reject the request with -EINVAL error code.
> +	 * In the OFS legacy model, it can't turn multiple ports into 1 VF
> +	 * device, because only 1 port conneced to 1 VF device, so if released
> +	 * port number doesn't match VF device number, then reject the request
> +	 * with -EINVAL error code.
>  	 */
> -	if (cdev->released_port_num !=3D num_vfs) {
> +	if ((dfl_has_port_connected_afu(cdev) &&

Could we really use this as indication for which SRIOV model of hardware?

> +	     cdev->released_port_num !=3D num_vfs)) {
>  		ret =3D -EINVAL;
>  		goto done;
>  	}
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index bc56b7e8c01b..83c2c50975e5 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -471,6 +471,8 @@ void dfl_fpga_enum_info_free(struct
> dfl_fpga_enum_info *info);
>  #define DFL_PORT_CONNECT_BITS  MAX_DFL_FPGA_PORT_NUM
>  #define DFL_FEAT_PORT_CONNECT_MASK ((1UL <<
> (DFL_PORT_CONNECT_BITS)) - 1)
>=20
> +#define dfl_has_port_connected_afu(cdev) ((cdev)->flags &
> DFL_FEAT_PORT_CONNECT_MASK)
> +
>  /**
>   * struct dfl_fpga_cdev - container device of DFL based FPGA
>   *
> --
> 2.26.2


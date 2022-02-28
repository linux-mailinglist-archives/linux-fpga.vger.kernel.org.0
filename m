Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAAB4C69FC
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Feb 2022 12:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiB1LPR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 06:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiB1LOl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 06:14:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585A7092E;
        Mon, 28 Feb 2022 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646046680; x=1677582680;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cg8xKK7zm1Ts8KpDM6zDiOcGeAYQRj1YbTg/ImUKtNM=;
  b=BJQsuvRPU34EefSpiC2kTGuvAEXL3SqIFR06zaq7WvWngXTuYpTYEYWe
   ++XACKjjbHjHdilua43DcowC4mvTaxqUeNbtjYbs0hRbWdKGRvvK9Mz1r
   GOvN8mMHHB18vwrc/gfBGf12/JBffYznvQPYL/j4b4i6b8LebJgQPtnZm
   RSnOACAm+2EcXHXELnjJPzawABst5e5SqoZMYLYYjGp0VWr+ZMUB8k0CQ
   FACoyIi09aoYJyGxBStUZtcosV2i+rYMGwEDuDmIazkAPMdnlfYN9IGcg
   7pN/ZqDHZ6f0+h5tEkIFEuLv5GxAtvjIGYAnmmHpHMc9iPTHds4zfEqML
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="251692406"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="251692406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 03:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="507389034"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2022 03:10:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 03:10:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 03:10:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 03:10:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B37YG1yW2pM9JTSLvytxOLAkAv5jPxMxyPp6SYwYaKL4WZGQy4m0MspL3ffNOzsK7opbFaYlhYW6ooX44U9bhyu1t4CvsUjenjb74FqR+kFmN5I8sA3PbiuPtgKMAknF8M+LRN5I6ePO+y4Y9feW32McLZOucZXB4liYhWLz8VIqWNzaNc+TqkE9nFf8LZkcJJDm6PoWVr3QCIHEbQ3HDcW/sdsERT/8iiR2ya4fijKpbLIANpdwbJbbERM5sPIs/HOPHBCY/e/cCc4vFa3r8I35ErUge7bxQpNEenMfIYrw3Yip/klw3R3d6UEVbnXyNxr1fIVvGtl3UmyqDvCsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqch6jRUxYiV0U9yfxLVpvzSnujRTV0NGvx7tTBM5Xg=;
 b=mzMWuPeXud50V0R9+Yg9NT4pRACT1Fq2oKkj95BOhicpO7dkuvkqTJa9qi6xGF7arFXsJckuaWps204hnGxGtomAkOr1zULIlri+YioTB3D7MRTQg7SehnV46KAWZ4czgsEd3GU60qClZVRbcfp4KL5zIB/Xq3j3gNo+5/zbQp9Kw5VQ/aDnByi0ONqC3XRoQoYjuBnTU2MVyC1GjIyG5pr83MjvC4Bq1MIMUWh9SaCJDf+EnMvzpOnSAdTc4Lzdr+de+15FfN5c8bO12Glv3Q/PQMS0uYxawCmPBNProo+kwfn5vA5rk79X0URWey4ZDOncCaPKEgBcDhaOp3e7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 11:09:58 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 11:09:58 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Topic: [PATCH v1] fpga: dfl: check feature type before parse irq info
Thread-Index: AQHYKWCM9LLv46vm40url05b1bO9gKyo0a6A
Date:   Mon, 28 Feb 2022 11:09:58 +0000
Message-ID: <DM6PR11MB381942D6F18C6518FE3556B585019@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220224092242.127081-1-tianfei.zhang@intel.com>
In-Reply-To: <20220224092242.127081-1-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 753442f3-74c4-488d-9b4e-08d9faaadbc1
x-ms-traffictypediagnostic: CO1PR11MB4884:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB4884F924F69210520F76F12E85019@CO1PR11MB4884.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbElCaCQ+OPPRNb6IHyHfdyyYuNqP7H+UNIqyC4aKKcWsWyawZpUKPtejRaYHsg06S1HfVFRpwleWdS84+/nAQaLINEa2rD6JJ13ZSTKHuP/ngyPa7sRrecs/b6JEbTyeG0zw6BcRvmc4ZURbi8b9TR/HLR9uFXfJbqyX2bjvAKuI5cOVoNa7Bj6ykQIV6xd7Cge2t/oDKUp9Uw1xpA/sOGc9rjVkRT3/jk+KYTs/PFGqc9T/76sMLUXNNguBdpjhqoo/QFmVLQiaEYFnU+aIYqE44+tmm/rpOwPW33tS3YfCkkf4YcoiRyvLI2fIHFcze77rQE0+HZ6/6ExBhXiRJgAvmUl5ebCGTRCocO98iTRshIi1NtubaNa194v4BPX0/wjuMdvjwdinzc5yIIowvM0YkUe6S/x+5Chedy23NTYbPx3SD3LT+fJ5WR62bse7jltFx1ScjYa3DZepQv3lDt9rHnc8sMDzo1bkV3eOyXQ5YLlFT7Zb3OxJsncFuKe2zyAbkcNx+ZONm18euneXTL4e02/bw5prS0en3VGXVjSvzNiQvb2cozNlTGBNQSetAwZKH3vfRbBavM4nJvZhLP2k6lA8z8Tp6otNO+0wcMNowqejyV8X/rggpXhO6n7OCijMN3hX7IfDfEJif18PpnD9V21llc2bC464HnZp7UgE2sn0tyYoGYTXMg7yFju2IYrXFxJMMIz/Ka5+fZu75ELJGeC2M+UGCT6hxVhGUCZd72acdvp/VcjuwPVQxs2ymNviYupF4MvUrsYY54ZqkKlMLh3ATZYM3jKmHfC76DuK4ZtAu4e5ChwIREnWn3Zj0BSfGj9LCPSSVp/xopGRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(966005)(110136005)(8676002)(76116006)(45080400002)(9686003)(66476007)(66946007)(6506007)(66446008)(66556008)(7696005)(64756008)(8936002)(52536014)(5660300002)(83380400001)(2906002)(82960400001)(38070700005)(122000001)(38100700002)(186003)(26005)(86362001)(4326008)(316002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oSBU40jJXt0xM9AFY8a+RxmPzJzeIB5sr++I7b6aRP8gVLgP4YkJLe9LXsem?=
 =?us-ascii?Q?WZpsoBeuub9WC//gEs+L04rB7ESYUOTa8ZODrArZsQXSGLSKqtYGaZFL8p/x?=
 =?us-ascii?Q?RIKLy9cRLAOZWEdi8jQB32vRCPCxVp0LDAfxISDZkxa8TG6v7UF/QCEZph3a?=
 =?us-ascii?Q?70tmlQ0DmPNPuzHl2dk9srZ0pODHiq97Y8xll0gfKWKeMu1QSDZ58xYk+xKm?=
 =?us-ascii?Q?ANiFrnegnEQWeqkgRVNlFz3pq6TgPYdSSxECFrm8D3WUisLwcVHNNKD20SYy?=
 =?us-ascii?Q?ixfFWbaZQRRq7xoPIOIaZMSDa1pbf3FzWg2FCDneBZPASJuyLbl529xH5WMi?=
 =?us-ascii?Q?SKNqdP2pdWQwdiLQNj9Obks0BHMY7qED2diD7Kt/oy6CpUmDuUxirGvPWZtv?=
 =?us-ascii?Q?EaXHfNq4sb+lGfywMzIcDLYTiRnE/qgYvH3Ce/xUGKO6Q8lm2bFDuGaRAKTC?=
 =?us-ascii?Q?7CRYoO4Ypdnx65Ng0qQ/OtTmby84r6Tc8+agVtNmw1PkVwh3EVIWBwm8NTS3?=
 =?us-ascii?Q?Izu/9JDuqB0O/RPxlcmSy4PuKiyES+HtnrWhIlKUbLk94F6o0XV07eKStaDJ?=
 =?us-ascii?Q?7e6zaarxPHj6Ydq4JHhYiOYedmLXkdpxh4u2952Wuhh5mHHBj3Hok6PFsrYy?=
 =?us-ascii?Q?S48NabZM1y0jnI1N3Kv4pIO7kmMHKQSHnr08GJ6C2VIyjIJiWsti5BnPSctb?=
 =?us-ascii?Q?9iDgCx1m59Sdo2HtW/I6jXMIzDIiTUoX5IiCQquZpg1yC9TpS8UOax+1Z8/p?=
 =?us-ascii?Q?P2vU5x35s8Lq+2e4mgBmTX42Tm6krRpXUPkRQZPHdwIvCd5vUElHX2GY8Cdw?=
 =?us-ascii?Q?XUl9kTwnTIhwa/EE+HcD9rfZ2WpOal+BDTTvrs5aDmfBBKovn2efE310O/nn?=
 =?us-ascii?Q?OtOdUzQjUKWUXFwwNDQaRIvVg+DJpAYNtd0wBAgmcabiU4Zn7T1WlVBvnObw?=
 =?us-ascii?Q?TrL6i5p87PI9lrZaiRZwBg8kO2zyLQ4JRGU7r/l8qh1Dosy2rbhk1fHKfeGG?=
 =?us-ascii?Q?O0khptyyn2OGnZjii+AAv/gHJjhUnvdEcPNyvoKz3f9gnK732VOdesfdUf7S?=
 =?us-ascii?Q?Tg1m21KdcLUOusR8/IarPhmmaOv53F6vDRGzOUUlhOe3yiXewKmvUbtcBRh9?=
 =?us-ascii?Q?MZZ+KJfZvxywwAjZaw0dIoL1h9ZZR9NAsOH8glBmEYApHjJDxrHM7/kO4ZtM?=
 =?us-ascii?Q?3INVbGN8EO/yADbIirSg0IOtfvAlNPfBT/An448aX87IjMqsIDIH7+TLYwoA?=
 =?us-ascii?Q?f7vECVOpyEDbcRi8aeGrm7xELaKQT3DaIK7rmFvkj8IRHqCWt9hnvp2sLSwO?=
 =?us-ascii?Q?grluKZ/4NVVSmlF7QuzUrZNjTwhI3JVhdEbRwbX9wT3lFKWYkpb29azJvtUX?=
 =?us-ascii?Q?D3LH3gk1erdLz2yDHLpmuuBOFRhn5fa+ywlF85jtxb4RChkudlM1e1a+4tkc?=
 =?us-ascii?Q?nmBrCO8C1/FC7j6JUoBFSwEAYbnNoQueZvSj/o4DrYbjx9eukOeFThKPBGKm?=
 =?us-ascii?Q?WEOjqdMijsdzihzK8stCrEpwxi+tA7NdNCGd+D1CwoIpoatVg6RsjKwU7DwX?=
 =?us-ascii?Q?AR+RrQMymr7LgARSwCvbqJJpfbLTQ9j30f275geaOyiNHpL0ABdzmTNkG2Hv?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753442f3-74c4-488d-9b4e-08d9faaadbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 11:09:58.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZlpxdn03vvJViZyYk33zw4dvhSb8OahTLI5Kx6PW7fPHWDYBPRA5e6/wiI+LhZaUV2r78TH5OiTWLoM4dUF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1] fpga: dfl: check feature type before parse irq info
>=20
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> The feature ID of "Port User Interrupt" and the
> "PMCI Subsystem" are identical, 0x12, but one is for FME,
> other is for Port. It should check the feature type While
> parsing the irq info in parse_feature_irqs().
>=20
> Fixes: 8d021039cbb5 ("fpga: dfl: parse interrupt info for feature devices=
 on
> enumeration")

Actually this is not a real bug, as in original design, there is no overlap=
 for FME and
Port features. This is why you see features for Port doesn't start from 0. =
But anyway
I am good with such extension.

> Link: https://lore.kernel.org/linux-
> fpga/BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.nam
> prd11.prod.outlook.com/
>=20
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  Documentation/fpga/dfl.rst |  5 +++++
>  drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
>  2 files changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..9ce418da1876 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driver
> with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme=
-pr.c)
>  could be a reference.
>=20
> +Individual DFL drivers are bound DFL devices based on Feature Type and
> Feature ID.
> +The definition of Feature Type and Feature ID can be found:
> +
> +https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids=
.rst

Thanks for tracking ID allocations. could we also add some description that=
 if
user want to implement a new private feature, then they need to submit new
ID application to https://github.com/OPAE/linux-dfl-feature-id, and add som=
e
README file to guide people for the application process?

Thanks
Hao

> +
>  Location of DFLs on a PCI Device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  The original method for finding a DFL on a PCI device assumed the start =
of the
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..6bff39ff21a0 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  {
>  	void __iomem *base =3D binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr =3D 0;
> +	enum dfl_id_type type;
>  	int virq;
>  	u64 v;
>=20
> +	type =3D feature_dev_id_type(binfo->feature_dev);
> +
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
>  	 * current version DFL only provides mmio resources information for
> @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  	 * code will be added. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.
>  	 */
> -	switch (fid) {
> -	case PORT_FEATURE_ID_UINT:
> -		v =3D readq(base + PORT_UINT_CAP);
> -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -		break;
> -	case PORT_FEATURE_ID_ERROR:
> -		v =3D readq(base + PORT_ERROR_CAP);
> -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> -		break;
> -	case FME_FEATURE_ID_GLOBAL_ERR:
> -		v =3D readq(base + FME_ERROR_CAP);
> -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		break;
> +	if (type =3D=3D PORT_ID) {
> +		switch (fid) {
> +		case PORT_FEATURE_ID_UINT:
> +			v =3D readq(base + PORT_UINT_CAP);
> +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +			break;
> +		case PORT_FEATURE_ID_ERROR:
> +			v =3D readq(base + PORT_ERROR_CAP);
> +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +			break;
> +		}
> +	} else if (type =3D=3D FME_ID) {
> +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> +			v =3D readq(base + FME_ERROR_CAP);
> +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		}
>  	}
>=20
>  	if (!inr) {
> --
> 2.26.2


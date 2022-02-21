Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6056D4BD726
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 08:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbiBUHll (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 02:41:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346409AbiBUHlk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 02:41:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B313E0E;
        Sun, 20 Feb 2022 23:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645429278; x=1676965278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NUjSjzoLxdkcHf8aW/9rlwxr3u64FSfkgxLPrQy/B7w=;
  b=OytVkEdlN4SIC9pq0qLl4FKEmboZ10Ov5mSnZPhfb+xXdCwrY/Igsmhe
   qJGyeJ0VawE/w3E58uxQr7fY1NcQuq/6E9abjgmTcwMntHDLhbBWrCXq3
   OnwJVSt3bk9cgEo2KDOMIwfvOYwEi55oa0McBter8af/n1xwwcD8JbO2z
   lTAtiJSbO4ZnhlI8E3D77sJO4waNJ33PfPLmHI+Cg90VAGCjRbomVHtuw
   Z6wwfBs8oWsQMgCC3VoXNG3CftB9RsvrYeM48jLZkfuE98hvG6nedzUui
   nfMgU8849De6D7DWBOPb/Yq6r5ehNT65zsiFNtB/DoU0mg4YeE7BT7QFj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250274050"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="250274050"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="542534732"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2022 23:41:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:41:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 20 Feb 2022 23:41:17 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 20 Feb 2022 23:41:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0k8lAlmHew8CmgFDTjEv6dARDD7wbiQGb4yAqAN0SLYcjI8+zlB0y2Pw8XoyFr+/4ZFMSW99ySErpSCmcyCUfjKtZ3v3Ebo6eNyOg2msnZI/Gop7s7YRZwHGe+TKiQTsni8BBoep9e+s2BmoMduqcep0ds5YLhizJSTf1IYbGo8Y5G9EqBU8HTwvBkziGW8paKxHWw5qC8OUz4RWdRuJh4H8ZNccCFuXUDreqHB0eIxRx8WjXW0L8enys+6wutAfkPtIoEyniAB1uUiXqselFldKR0nfWCn0CM2e7xP/7fYyj2yoLivXkW5yBgv+zak6cTeuM9Mx0XAU9sM76HMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euXzTvvGpFU3qdNNhBrA0uBkCVQzuCmLVVmQCY3g3TE=;
 b=g9yKgCJdDGMfK8kx3pA6bUhLTE2jdhG80ycVz8Cql5rQUBEzK/Td1+9ZeyrZ5OXYjJz4LqasU6+oEcN3S5lcrTtqkt95LH4el3qIc1f8shJAJWYUSDrTWU2j6dxNdSKAdqroGdxX0IW+l6ePtOvtX1MCRm+qbWi0OUvhGQWf8kWCXp9HzHitObH4Z7V+HQkyEv2+ZezRZJvF1q0sPJF7Bdi0Sk46LlEyOR6A6ZIxJyOaWmgCRdZkl3wwuU3p8cuyf2OkPa+vuSbOqSMm+EYU59oPzIJ66CS1zQZvTamADCi1EY28iQlKnxRzqj1OuUHGw/2N7OH1H1SFsPCQLml2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN2PR11MB3807.namprd11.prod.outlook.com (2603:10b6:208:f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 07:41:14 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:41:14 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Topic: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Index: AQHYIZYutGpfsM893k+7OxgKTgvvjqyViUuAgAggQKA=
Date:   Mon, 21 Feb 2022 07:41:14 +0000
Message-ID: <BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <DM6PR11MB38193BEA6566608EACAAB87785359@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38193BEA6566608EACAAB87785359@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc1360f9-7291-4ebd-7304-08d9f50d8998
x-ms-traffictypediagnostic: MN2PR11MB3807:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB3807CA6F81E636AFF37FBA24E33A9@MN2PR11MB3807.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZ61MUF5McAgmPE2HWo0qm3wMO47NSFU9+ESqx9RFNHGxcruTNF2ScfPxiSC7yqYTS6LqZlhc++DrkiNCQQVXtqTPOpiSw3eTrmjUruIzcFlJSnNkWCtPv3VzD3ZDl5gRngjBEUMlOAQhE43kLKIgPt2QTU/KKdjM/JnDzoyKrTukUfbuK6qf8JakmFDjvx2v84E3yQqkqAM18Uk7yHdo1f8nLIWVTdy9Upb9Dh6Su/bo0zqe+BnKGnoTKfu9CtStfQQqiAkBaDk8nbEHwCizhpN4a+6rDzO7QuHTIoGN8sJrlYuzoQMCRsho+zLWaRl7v77xWodbm+pVelvWWIN1MdvAHMK/qH9csjdErMWdKHHNTD2gDJZn11+mWHjeQhLzTEOD5LJzRdlIEajU4A9yuTVtybFRN9yMJB2RLxaNm6NivMXXM/2A6u/KvywHMaa17FfOAjxeyOmxyeHi+Mz7QHA7Wtdn4iCzu6XaDu6+KYkD/oJrNyrxozJHTbFA1M7tOx6Ev0pYE4dgXo/lcyQdwMYDRGP+BHUwdha+xJmXvwbj6DHBm9JPJ0whQryX2VIWsglAg6GzGX96W6AIyCrWLZEEFdGTJMg8sObnKgutEWrkodhrc4zu1NIHLAn8dF8blaCOTCSw+F0jiXOrnhGYniQY7vqdftQZnTYbQuXmUvvIzELQb6vCdENosqgbaCsBxjaTV28dcz+3znPTJSurA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(4326008)(76116006)(8676002)(186003)(66446008)(66476007)(66556008)(64756008)(26005)(66946007)(86362001)(508600001)(316002)(122000001)(9686003)(33656002)(38100700002)(71200400001)(82960400001)(5660300002)(6506007)(110136005)(53546011)(83380400001)(2906002)(7696005)(55016003)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HhnuM7HtjJTHyhrRZbE+3PaJ8hHY20f73E/lZYdrv2fWnNkiUtoytBI5i15S?=
 =?us-ascii?Q?0fE+V4XUGIzkCu4g63d51C/uXW2aoEwIh48vBCbtsD8PssZvfWKJrAJl4QrB?=
 =?us-ascii?Q?Pjm6w9+L0EJERFdeJYioie72EIY0rHrVBCvdR+brHypeMD9rEAARPOF1WT/A?=
 =?us-ascii?Q?KaKYg1tdvPQLW8GGkfxDfOobwtvW4/G3qd86H3+6wIb3VwUN/Ea8WtFkAS1M?=
 =?us-ascii?Q?lDuKiHeBH2NSvJSn6NR6VQppMtp7qG29LyxIJMgKkFK8KCwNVfLR2eEvQEm0?=
 =?us-ascii?Q?E1COyczuicIa3bC2PNHzIfX7v/MnyYnGFiVxH1PYP2hAYaaU7qKnLZrV18Oq?=
 =?us-ascii?Q?zYliyuEwCORNOM3Nwb9VuM4+8arfpTQrTmk722ERyMBPXO2NzRBruxDVCYco?=
 =?us-ascii?Q?yeRfsQ0SrWhbR+IFIUzqSIu6MEzDB0m/9Uv7cOhD9M7tv/ctTAv9G0M6MbQr?=
 =?us-ascii?Q?UfqYvYH/AkmHjZPF8m8a2Rj6GnFH6UrFJo1Kg5gy/T++D9IZFEnAmrUV5X5K?=
 =?us-ascii?Q?x0o0GByzxCHvMFBSkBZNyUsOvaIqljrdpdvHzwG15CtWpdHgAJRA7wfGJVno?=
 =?us-ascii?Q?XA360u4FdEsS5H8H1NtnQuHH42Y8U9oBXpCBh7BYoruxWM9Jy4kuaYezSz5D?=
 =?us-ascii?Q?wzDzxW0uNjbaybTs6MaeHuhtcW2zCfdTS2yqqotXbXd1bkGcx63s/+KcefHa?=
 =?us-ascii?Q?4v74gbrgIFlBDq8Pyl3v8qe0x7c/9bw0pXtYGLHQ5LPnQToSTCqHQYnUUUiI?=
 =?us-ascii?Q?4Sfya4zr1MG0/UrZuCrkbF+7lLUiuk0Lsg+MEpDl0rtEGC9wJiwD5L26IxeS?=
 =?us-ascii?Q?xsVtY+P/DnMfAUZLGFIcZ/04kRZsbpX4JKldiQ2aMoK2dm0yVrA9tBtZ8g7P?=
 =?us-ascii?Q?13pPL5bkxJH/Zw2GTeurFe9y2M6YwQfcN2VqOzLyYBS7PTz/+fW/ijy7JnoX?=
 =?us-ascii?Q?TnbzqJgfgWxYnc1PiXWzuLb/cY68o1MfBC7rKVoy1gGCmVVIoXPCocVYbyNz?=
 =?us-ascii?Q?ULNX7XHcBPGyBuJgYI8mAqN2wRHs0O/3TTbShDj5RPAUXZALc9rF5M/ddP4S?=
 =?us-ascii?Q?7Xl9g5EO/pnlY7if9BQRWoNeb1oKNet6dl1FkdhfJXs6mfWBpkuFipzDxahz?=
 =?us-ascii?Q?kJGVYwjaS8Ea1GRyKyeIIRAujjBPuUU54Y0ncLGsaOspJyZkyBPoiT6zKjV1?=
 =?us-ascii?Q?Lb/jFnFKDW0ov1MmwuhQUBo013ho+ioNUmKUb8eKl0R3QB/b1MTd1BrUO3SN?=
 =?us-ascii?Q?bsCEXvSjY+c96+I1lh+6ew1TCr27d5AlpatmgJ6p6GMAn8LBY0b8lygIA8aq?=
 =?us-ascii?Q?MfkAk27V5V19GdX+hMBobVdDNdtFi49VbhilFcGKEMKlo/xaOwC3bT2Zvlo3?=
 =?us-ascii?Q?BOx7qhZD08ff9Ff2dwk3qOWm0rRILa5fzIA4yHilpfsMTEvF32UyyvsHIl1y?=
 =?us-ascii?Q?0VIwrkztjf617GSN5wjzWZgTXJPmBXz+UfdpZ15c3jIdRRIWIMhZhaF5cD57?=
 =?us-ascii?Q?5DAakAvb5xyl49gxh6PiPWjPJY4WBzrD+gJeE4p0muiobuhnCItmjVJr/kf0?=
 =?us-ascii?Q?Fh9PJY1j1YyCeGsTRT/xqCvaIGyI2hgltuDmeYsrAxE20WHoJAzwobFotR0M?=
 =?us-ascii?Q?EGvMOwpXFApUZDN5/4qslJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1360f9-7291-4ebd-7304-08d9f50d8998
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:41:14.0235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu6q9izYVgpW12v5CojK+fkk4K97b3qD8qfLowpCYyIiTScCH6KNzXvxm2UsuvaxeKYzEyX57tnMYBUIRjWw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Wednesday, February 16, 2022 11:35 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net
> Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse ir=
q info
>=20
> > Subject: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
> > info
> >
> > From: Tianfei Zhang <tianfei.zhang@intel.com>
> >
> > The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
> > identical, 0x12, but one is for FME, other is for Port. It should
> > check the feature type While parsing the irq info in
> > parse_feature_irqs().
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
> > 599bb21d86af..26f8cf890700 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct
> > build_feature_devs_info *binfo,  {
> >  	void __iomem *base =3D binfo->ioaddr + ofst;
> >  	unsigned int i, ibase, inr =3D 0;
> > +	enum dfl_id_type type;
> >  	int virq;
> >  	u64 v;
> >
> > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > +	if (type >=3D DFL_ID_MAX)
> > +		return -EINVAL;
> > +
>=20
> You don't have to check this, it doesn't allow creating feature dev with =
type >=3D
> DFL_ID_MAX.

I agree, I will fix on next version.

>=20
> >  	/*
> >  	 * Ideally DFL framework should only read info from DFL header, but
> >  	 * current version DFL only provides mmio resources information for
> > @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct
> > build_feature_devs_info *binfo,
> >  	 */
> >  	switch (fid) {
> >  	case PORT_FEATURE_ID_UINT:
> > +		if (type !=3D PORT_ID)
> > +			break;
> >  		v =3D readq(base + PORT_UINT_CAP);
> >  		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> >  		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> >  		break;
> >  	case PORT_FEATURE_ID_ERROR:
> > +		if (type !=3D PORT_ID)
> > +			break;
> >  		v =3D readq(base + PORT_ERROR_CAP);
> >  		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> >  		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> >  		break;
> >  	case FME_FEATURE_ID_GLOBAL_ERR:
> > +		if (type !=3D FME_ID)
> > +			break;
> >  		v =3D readq(base + FME_ERROR_CAP);
> >  		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> >  		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > --
> > 2.17.1


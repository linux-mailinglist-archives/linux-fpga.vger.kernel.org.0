Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901CE4B7EA7
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Feb 2022 04:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiBPDfx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 22:35:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344347AbiBPDfm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 22:35:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A4FFF9D;
        Tue, 15 Feb 2022 19:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644982531; x=1676518531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iqVepFxUGaX4T3ACDfSUUHclt5h3ZlAhYB5uBWovdF8=;
  b=g0gqwdVqdq5eniGzvZeKhB0wgJIFkqIcXlP4Vcr/fty7miuciqprqiVA
   oD9H2rawolCuzbdbs9shpZtH1cihc/6INN6rns6Uvwyu1806PaHwbQX2M
   HN3Sj7McbAelFncTWd8sB+53yX6BUTmDr+CAH3R1sXyF/OH+ghx1huD8Z
   k50oUTjpMyipzebU9xsKbfFMi0bxedDsiUQdEA/xhUuwKvvX/FOLdazaD
   pX4HmOznSjAVLMO8PRi8SzPFBMhFGXLri56C1rJk2Wif+BfAnCMAAVgwY
   dpQ03O8CKsoJwcuHXiRWv9m8PXHD4p7QNsuRlAZ74gWTgoaZf8Uxt57GA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="234054736"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="234054736"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 19:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="486633849"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 15 Feb 2022 19:35:31 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:35:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:35:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 19:35:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 19:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYnMpNlpqG2iuT0ezHqOJ+kottQQwU8SAyYt0Gxys7VlCXMpPFNC/J7s4pjbgKRZ+8cvx17RP3ATdHFyzJ82enmnmRMrR5WJOgAFZGj6nP9PULv5PYZroV199jD/30xTA5bnyM2teH6dvvGhSpQ/exCTpf4ViXAMhnySCujwqe4ziqdHLyTVJaEVzByKr7X/tn6P14zj/FwCV2k20PrC2t0/suTZAScQGaL/MY2++Z2m15zj6WsNfkDIhQ4vkcuA38SrhN78wgzOYbN+w3Lf0eUvrxQ6+KNU+QmPOabW1MRnC1RSxRr0oIBk8yOJja9okR2RaVoWKdVPNKq+/YS8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nby9mlZYUtMiVibusH/xUzkuxd02jF4c2I27kFo/1kM=;
 b=Fzeb9ySH7GdUoFjIx/RAmWcfrFu6Lfuo17Bkn10fglxTQqolTTu3AGb3plDR6BPqc7p2LCOPZouOUMBzZcwK9vcXc3vQflQInq4GR0LCwY53i21Z5IiEALF9f3OzL0rrCeOuUANrTVttA8zaqF+Tla09Z/pKoogkMWkVw5Bk2aRGRPoj3KQ71rKBJOucBrj/yAgfVtvYkGzOiNAVaL8uswP5suH6MTQHYaSAvbrPdietFXT1U0wkoIHOHlm8QYW3hg/V9wqH/xdqeaknDyEwnCXCQq0Q2740jg7cxW5/J4DiWIW+j5/imkxlunHtfUFSOTULrrTJx5tuyUN88BHE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1625.namprd11.prod.outlook.com (2603:10b6:4:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 03:35:26 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 03:35:26 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Topic: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Index: AQHYIZYugBgIM3QaCEG59dx30/kn36yVbrFg
Date:   Wed, 16 Feb 2022 03:35:25 +0000
Message-ID: <DM6PR11MB38193BEA6566608EACAAB87785359@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
In-Reply-To: <20220214112619.219761-3-tianfei.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a73116b5-dd1d-475f-a3c1-08d9f0fd5efa
x-ms-traffictypediagnostic: DM5PR11MB1625:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB16256160301035AA060AB55E85359@DM5PR11MB1625.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyatxIzaviXWrs7VnmthTiZ0bl1c7ROsxj1pDw7Epgo3eVN1u6Fk+Ff/esfPcHWmwhC569XzZY2pocLGogFrc8GppvJJpO2xbk3ORG9Yqf5g3A7QVx5JDZ3X5Mv3ZvEmVE9lNfeiEN1l1uS2Rz4kks5NTrWnfroqtVhEXK2VOlJlgiewD5CwvLbYUoJdc34L8zkcevcei8QwUfpwTIbHsOcnfOF9pjuwDlTP1HPLfAu3CHu51MjTGy7H2xTMOonMzr1+xIF9JptvdoZ9apHD7Kzf9Z/wyAY15kKXaS1g929aqBmjw4VWUAg5iw8qyJhDV5EITha6VdAyPhy1PZjWUPXsoLDMQW3QkKlIKOrfSOwLxUGkFfwZBzQ59JGOMHAyPDz4C0QopSGW+Dm5gx++LynYqoAWOvBmu45hB+/azu+4QgWte6N1vFHykMFrWi8y5eTcAq1x7wKLStqZ4Y2puFhHn7yttnyep5MoFs8YlWMAUYbNjNdolFwNwluD2o7kzOsCkZxENY3M9S4XKV8j6i4YsC6U4tjWhqN/6n7xM9oCTA/81SGWFHBneRkGe7H5mhlVsVwVd9KFQRfiYAw+dc8UBAE07dQG6b+CMH445sGe+1+0B24jwdLVCsVtzwuF9z28ykdha2n6ws/ft+8kVHtBb3oj/8wmwScYBQdvtiFp/CcvO8hvCmI16kHP29P+d5QoLpYF5Am62KGo/2J5zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38070700005)(82960400001)(4326008)(8676002)(110136005)(64756008)(66446008)(76116006)(8936002)(66476007)(66556008)(122000001)(38100700002)(5660300002)(316002)(66946007)(52536014)(71200400001)(7696005)(6506007)(9686003)(33656002)(26005)(508600001)(186003)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tXcUKTivFSPj4k8XaCw07OcleSEF6W4g2XjBaCNeBLGpUKOIPr//MaGZBYTf?=
 =?us-ascii?Q?8YcjUUdyuC87GWOTaf8r4Amf/RkBDcbRDVdh8QtouCSYypU+RnBbvJjCmBkA?=
 =?us-ascii?Q?ZEPSWiczXlk4llJSFreV6KioVyViVobpxO3dihtGPp9eywZi7sCNT8iPtdmb?=
 =?us-ascii?Q?vsWBywWeFqWO4B1Mtu5qAhYHRrj2T1FY3S2rlFC6p5mMHj8Fb0AZ/ow935JP?=
 =?us-ascii?Q?ia7T78gTYLtBfUdj5makt5uByvskexReKzNEn7OPOkH1Fy+9GeDkdfwav62W?=
 =?us-ascii?Q?JLU8D09n4IsLO8rZFA/rXAgmxMdTUMZCe/KHDKxdRU1fiP2f3qLT8BDsVeu5?=
 =?us-ascii?Q?3TB/eoRlaIw4TOvfPrivZD0QtqgUTRIhPhPJfNyFHhgcuOIXVihAqgabg8Mh?=
 =?us-ascii?Q?/Vp+zK4EK6B1j/5WATDiVhcC+XsmecCbfgSrFr+YXSGf4OAZHcrhSRXQPF1o?=
 =?us-ascii?Q?relU8F4zoIiPcP0eltBb1EWgD6Io+8RMUG+RwPQ+gyqNueThTzVi4omY69pa?=
 =?us-ascii?Q?XoxM9AmZmb2Z2wXkZQZIoIMfHiarLbljO4xSlFvfob8H4JOOE8ZMQPNHFg20?=
 =?us-ascii?Q?J7O75aCX0rzAoPKnBe5ka+GOLowMUw7b4Hh9SVyTkl9t1/DJYj1y/Lv4jdb6?=
 =?us-ascii?Q?/HVg71cka5nkgjnnJfUfekTG8EqfHgAnzjXiTYjm3SiEGaTbD2KJOFiCpNEg?=
 =?us-ascii?Q?8hLembJprNRNkU+UkPeeNq5p/7q2njw5vSLIZsHEBxeOzNf862TmgYQoQ1TF?=
 =?us-ascii?Q?jjjJMMtW8hQYo6GPS20yDtn1AgczPkfcz1TvNLVljj3tDR8ynEBfrbSFQt91?=
 =?us-ascii?Q?YghD3bm0H6HuKtn621VfDy0l1sHwdgWXqZigTiqKmSYnVRRMrcoTpxskhcPh?=
 =?us-ascii?Q?GB1+lSW7FmKoY6BBBr8cwaBuzS4Q97m5bq0QAeEDHZfy/XHjQDaC/yKn88D9?=
 =?us-ascii?Q?w6nSVFKRt3iQPmR4cKY2Wkyz7QIwTmwURrDsXMf+SbEBChzAUCU5KZgUestE?=
 =?us-ascii?Q?G73rs1wYcwVxKTbvYQkAFR855yQ4WTFbBHWHHeJh6H9JKrhTtiTyo7Fb0pIb?=
 =?us-ascii?Q?yA/Go+8FY3XnndOZ6IioSlA6NCaEeo/1aaVHF0fAOBbTA7LcSy62JP+lnZpV?=
 =?us-ascii?Q?JhC1o1BAjWAqYXpB6p+1+ShizY02hHnxAVM9sftwAzPIcK4xW5S/JpYzXj+y?=
 =?us-ascii?Q?+j915mt5cm2BqNMgrBI4YI23vPZrJums5ixSMmJutg18gK+iTMluxrCUQryg?=
 =?us-ascii?Q?PbfbkjqUImHdbvGLJs7GSHhR4v/yDb88MXvBfHJ47xRdeFXOYcLTLnuflJu4?=
 =?us-ascii?Q?ksyxcd9UyporuJqMP0N6V5roXJHCZIrAGtjSbLMm3KFAElngDC5/1MzkHKuc?=
 =?us-ascii?Q?AET7vzn6ONsRdiMKpjimt1sp8CTzT9KzadGiexhPyTgt4smxhihHWYgTL6XD?=
 =?us-ascii?Q?OqaYQvuxj+ingyS468YJxO+etM15t7y2wmr3Uk6hs8VDIdIJE/eDy+w7vV2K?=
 =?us-ascii?Q?8mH02FpeXnIgN5aSKoz5689vnXdejEDbG/zf9Kw3/xywUQI5QQrb2bFJ/zK5?=
 =?us-ascii?Q?WsQHvBATBovHCpesEnYoxhgHgXCDTVX83Lv7Gc6w1G/omdWoFOZjyfEsjX+L?=
 =?us-ascii?Q?KnfcvzGvUcXl6bznW+BEZ00=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73116b5-dd1d-475f-a3c1-08d9f0fd5efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:35:25.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7za+ijY3GIMhXrAEk/NZw3Uh6y4txrx/H6Wb3+lece4Hh9Cv5/l8ySF2dyuBuXIDhWFUKdXluHrQbUHzYkrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1625
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq in=
fo
>=20
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>=20
> The feature ID of "Port User Interrupt" and the
> "PMCI Subsystem" are identical, 0x12, but one is for FME,
> other is for Port. It should check the feature type While
> parsing the irq info in parse_feature_irqs().
>=20
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..26f8cf890700 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  {
>  	void __iomem *base =3D binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr =3D 0;
> +	enum dfl_id_type type;
>  	int virq;
>  	u64 v;
>=20
> +	type =3D feature_dev_id_type(binfo->feature_dev);
> +	if (type >=3D DFL_ID_MAX)
> +		return -EINVAL;
> +

You don't have to check this, it doesn't allow creating feature dev with ty=
pe >=3D DFL_ID_MAX.

>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
>  	 * current version DFL only provides mmio resources information for
> @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
>  	 */
>  	switch (fid) {
>  	case PORT_FEATURE_ID_UINT:
> +		if (type !=3D PORT_ID)
> +			break;
>  		v =3D readq(base + PORT_UINT_CAP);
>  		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>  		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>  		break;
>  	case PORT_FEATURE_ID_ERROR:
> +		if (type !=3D PORT_ID)
> +			break;
>  		v =3D readq(base + PORT_ERROR_CAP);
>  		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>  		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>  		break;
>  	case FME_FEATURE_ID_GLOBAL_ERR:
> +		if (type !=3D FME_ID)
> +			break;
>  		v =3D readq(base + FME_ERROR_CAP);
>  		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>  		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> --
> 2.17.1


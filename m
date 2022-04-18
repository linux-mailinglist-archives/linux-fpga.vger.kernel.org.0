Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3784504A6D
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiDRBa2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiDRBa0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:30:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7018713E99;
        Sun, 17 Apr 2022 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650245268; x=1681781268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MbgFuqJ4jwhO8uTLNQazXPOEuzyjE9ZxA5eiSPTTqNg=;
  b=F6M3x4ETTJjokQzvydCSoKpFe7VR2SKySBHvYwDofybFgC5n6j4OECkE
   55fcZ5wzv8wGOQDA8OLs6rQ+mg11E/nmX+fr8ZvMOgL0hxLByY5DMgghW
   k6D7dbNFn9bc/BL4MB5X2D5U04WRHbtDXK3Acxa/GRiBUCvcMY9DLm7Xu
   yLaDuLA2hmF4ZARCX1e7V2YsmL7+BuOecXeVs9ZnH5KIVYFrOPstx4cDi
   vRjt16nuDDVORpVBHCQClRrtJrHr+kDwOxntQRTe4oSr7ZfkydpPiSA1G
   VECfPXYMLwtoH0l31OqRvk4U/rSNPufxdHxOwpr+ODBnJ65tJkMDijhai
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="263605691"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="263605691"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:27:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="575359062"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2022 18:27:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:27:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:27:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV/OGq6rxlllCNSabFUTD4+K0Wzw7/PMujpEPwD0acwph3EsC+9EQ/hrdW5eStemDmnpimfV7u1E2OQVHLtUxjQ6VL1p00K1EuAyN6xmio58+zGsq95t4rrykiPp/PqcOQbBZ+skzdKBkxUdLj/owWJAhcBB0/FfnJdMpnH0G2KPnl1c4O29MXxe8f0w9N3HxB7IzaKzrQ3+1ZJXpVH52Ccly0EtOVJIfqwZYW7cyuOWA6+eVgraT3Lv7HIvqm/I9Zs+nooWMtW6R8fooZCbdiJdY0Im+8C8jQsiuyW5p4tOUlW4Wa/vIbgHCTxMfUnA7T86+VrWOOfD7kldGbA3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgo8IxhhtqdKcsi/l20yXA4nLcduccSKpcmPVo3DLMI=;
 b=Qfby1R3JpDHqbZt2FGaArmfX2L64Z0cRLtXBlrKz24tOfyY7x+DNhCtfDSDVZ+kYZ/yKolXHzSe8yJ+suTZhQZjRxjiqcqE7LoYfgfEje/SmIBTGCo2pVtJKur7oDqwuoEv0nRpsNnGQ2CzZ3o2PFLgS+2HCddlX6SH+3TEvPY1iduXERHpAbVMhCDESkoiQI1Fp5ZAr7luDZX0gr4yLmH2ZJFKuza4B4LVOMGU3lULeX/APtcvJ+DLFuBVVp1RWZlEdisA5IgjyIhy77sA8XUgY3Uihn34MaMrv+1ahZKtZA5Y9hjppmvDNSdaEfJWMm/JDcHrKs9fKJGwEFua1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by MWHPR11MB1872.namprd11.prod.outlook.com (2603:10b6:300:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 01:27:45 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:27:45 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 1/2] fpga: dfl: check feature type before parse irq
 info
Thread-Topic: [PATCH v6 1/2] fpga: dfl: check feature type before parse irq
 info
Thread-Index: AQHYTobrW6BRr9cCvE23hJf9d7LuFqz05emw
Date:   Mon, 18 Apr 2022 01:27:45 +0000
Message-ID: <DM6PR11MB3819B1722989A797E12AC59F85F39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220412061705.53721-1-tianfei.zhang@intel.com>
 <20220412061705.53721-2-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2204120903100.278492@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2204120903100.278492@rhweight-WRK1>
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
x-ms-office365-filtering-correlation-id: 928c1a36-dbd7-4b4f-76cf-08da20daa405
x-ms-traffictypediagnostic: MWHPR11MB1872:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB18727CA395B3F66F4DDEA12B85F39@MWHPR11MB1872.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Ihkjq4S8e5az+NHD+Oijq6zRhPNMjWgYQKdyGigsYnURvYY8DP63PizXx4+OQMVFUHMpdHzUqK5VElES9Xz52px9pxOYMGMGmH9fUloGebH8ZIxChXYxNrcnXPpb9IdiAd1ij4Rss3GW3l8pVhTd/vPY08h0uFOrNLDUAk7CX1sDnAmqzS+/0GUQSGEoOdCkeh/u2P6MFS29HDQPKsMBgzq8zAx8HbvfzNkk74JkoK9NARwQ6CW2VC2WnlR6n8UcxLEgaNX2mIX7Eqm/B90gqZc/wUKyEfNjXh+59Y6W8lzINx4ic8QoeB5LEezN1nCJfm9J1Hrx/yrAAEd5n9vJnJWnEUoiIGUkoehoUIb4gnf8fnekQmsWbNVENL62/7IFb94WdELss6TMtu02mw4as+FCPv1jgwifEpi6T6OpmwokAlSUowIlh0p5yWjZcRcO2pu3UvAcGBUojXyG4eGn9mXcKOaluvXsvgs6cgdyLosnfLlgEVi5XC3LN6sL3YIPujmY2gS1oKn+A4sLArjKxNs39nrR4p/JeSe3QU6p92NFmNOzAdd8xODG94xnCvrd9lN+6/bBtUl6XXPsfpKqWR0/vK427pPT+sM3wjbGE5zjngICY4q5TmMNPSHA04kzP1JKTVOM+wr7eps/mUnDA0Vr05KWarNDeDflJsdmWS0JX6bB1BqkfBS9lVTVGiijFzCxgrkoz2zc1M8vE1N7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(4326008)(66556008)(66476007)(122000001)(76116006)(66946007)(55016003)(6636002)(54906003)(110136005)(82960400001)(8676002)(5660300002)(316002)(66446008)(64756008)(38100700002)(38070700005)(186003)(86362001)(71200400001)(8936002)(2906002)(52536014)(508600001)(26005)(7696005)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWfXbdcK1Ofa9R/uPqraXJS/heeZWOe0wGbNOhM9hhapj3NF+86CjW0A43fD?=
 =?us-ascii?Q?RavyfxevxGbnHB6qYaZgieevHNlHKrCV+x/pS8F1uk3vxphRnATW8SfwsBWF?=
 =?us-ascii?Q?O7Ws/7Z2VKaWXFtPswopuVxbZaj8aylEx+BcVRA8QqYvvydrUA+Vs9x14xmI?=
 =?us-ascii?Q?hrWbDm6Get3YpMVHiWPJTSg8RXgSOwRO+eIpPu961yVUtWr3IaVFNNXjLlAT?=
 =?us-ascii?Q?efZYkDha/kzRYMW7tNMQVHvpryppZxAxhiwezIxcE7uX9RuwgriUvdjnm6w3?=
 =?us-ascii?Q?8kOHjbHMMM1AaTJtvloxmASFivGrWWznCLOkBLOxYfnO27WrZyuhhhJ+Nfk9?=
 =?us-ascii?Q?ocIOoxBLjeowwGJwR1RXJoMTYr4BooavKnNhVhz2aTepu+/gAYhaZbaZ4o01?=
 =?us-ascii?Q?B/iWI/qbHY9GNX9bQxuQ3J/37B3+RdvCGl9wR7hph89FOqamVnhdsGU0mHw8?=
 =?us-ascii?Q?TPjte3lgvTt6V9WppqV3vI9UKDj8Oxx9uy6kVVAWojMpwWnzcAvBb5iLSH3i?=
 =?us-ascii?Q?14df53b1ZfDwacuifu+fl3uNiyvxgmbHVOayn23dZeYcOwpvoOsbwFntQt4K?=
 =?us-ascii?Q?ZiOyhGG5wXzC5PkuI7T16KFSbGth++Y8pKQLBy1Cap3lOyKEwksVNzqzTSd/?=
 =?us-ascii?Q?Wxa8MEBXIoKAXazHhLkHdhdilShEuBGtZgRltjadpQlhpRt9rQdhQ9D2p5Kk?=
 =?us-ascii?Q?4T3P+N5ddv43Hu8oGTj+cfEBfK9U9DfYI6PYogb4S12bqPacmsBJuiEsI491?=
 =?us-ascii?Q?lRiSFOOdBUmmjqqMDYX5ezgXKDvs01YbiEAvGNUDqQTeOCiakpFK0y4BxmF/?=
 =?us-ascii?Q?QXTrmCfMMfSX/4wA9eiE2hUXKhgf2eQzUgTvyOeWK0MH6X+OBDrCuYgOUVlC?=
 =?us-ascii?Q?Y15AryiqOGDYLRg7cHNGAbSKIFQ3KJehg/lPgcMA/Ph6WpQZWbPDx/zB4P4s?=
 =?us-ascii?Q?G3XL40zpdarKDR4BqKbf+kysVUTGajpwDV7R6D47FESNP2lAX938WbXKazSS?=
 =?us-ascii?Q?GxEd5HGzfmEuKG/C9wZl3gE50OThp2Mt0Cj4LhFvvDO1cOmr5FjzgMSw6672?=
 =?us-ascii?Q?62+Wko9CXeWznJsLelKhb3YyhoeeQonTbXoyjKgjOVa+uNEU2UN8+8Ct1uTB?=
 =?us-ascii?Q?+kvAJCi2kPPORWTB60Fw2wTu8K+vSDm63y+IsCmzh4xe60VttnBqfPQhj0+7?=
 =?us-ascii?Q?QpnJDIE4ovdHEx53HWZRzpZDwYjTu/Y0WUqT6T/aBzZoYVVAanbQpNcxfURx?=
 =?us-ascii?Q?dtvCF+jgxSrK6Y1BBtyzo+k9qOO1x4VsV4MgMataXHQfAdiz6XJIJmfhRWc2?=
 =?us-ascii?Q?rueq+6Gr3y46m37f3OnhkZNkDl+qF5sH0xS0oyusWL9lZrhNwJI2/37IEjQq?=
 =?us-ascii?Q?S6EmmSs5+WIbzZAk6khZm3VBLO2QAOU0T4ZqemIBZKGVoNtN5HR3cZStc09J?=
 =?us-ascii?Q?sp1y9nGb+e1fBiVNQ3I9cAsGof9+hH6cqnjGnuOHQ7UESQJMmOEwfcKOvIjj?=
 =?us-ascii?Q?CVUDoG9zlriXaUeI2Ok/WIYV/04osvGpZi2c00bCqSRCN4jMCwuJrN/ygdrx?=
 =?us-ascii?Q?NPMyGnC3vQKxhUrUccG4XSXvv7oWcXgQmOziFTDdLGWWn5w3FIErLBCRxHPm?=
 =?us-ascii?Q?VHA9QTJ1G2qZkL2qmxSmW/HGuQThR4N+pb4lFoaUJS2kWwjDX/eAVAdYJBC/?=
 =?us-ascii?Q?eH5mSOQcy/042rw6BvNnxiRUNZN5Le2UiX324q1S6LFsBoUv8H8nQOwMOh3k?=
 =?us-ascii?Q?qEpfQlb9uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928c1a36-dbd7-4b4f-76cf-08da20daa405
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:27:45.2033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLESVNnMbEUvrYMXfCDYAISXJcrXlFmBXAZZ0U4WV6V4GaP2N5vYYRMqa0RnTjKtrlT5ecQ8PCiwLk+BYS3Juw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, 12 Apr 2022, Tianfei Zhang wrote:
>=20
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > Previously the feature IDs defined are unique, no matter
> > which feature type. But currently we want to extend its
> > usage to have a per-type feature ID space, so this patch
> > adds feature type checking as well just before look into
> > feature ID for different features which have irq info.
> >
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> Hi Tienfei,
>=20
> I reviewed you v5 version.  You may add the following tag:
>=20
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

>=20
> > ---
> > v4:
> >  - Fix the git commit from Hao's comments.
> >  - Split documentation into another patch.
> > v3:
> >  - Remove "Fixes" in commit log with Hao's comment, this is a
> >    extension not a bug fix.
> > v2:
> >  - add DFL Feature ID Registry in documentation.
> > ---
> > drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
> > 1 file changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 599bb21d86af..6bff39ff21a0 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -940,9 +940,12 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
> > {
> > 	void __iomem *base =3D binfo->ioaddr + ofst;
> > 	unsigned int i, ibase, inr =3D 0;
> > +	enum dfl_id_type type;
> > 	int virq;
> > 	u64 v;
> >
> > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > +
> > 	/*
> > 	 * Ideally DFL framework should only read info from DFL header, but
> > 	 * current version DFL only provides mmio resources information for
> > @@ -957,22 +960,25 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
> > 	 * code will be added. But in order to be compatible to old version
> > 	 * DFL, the driver may still fall back to these quirks.
> > 	 */
> > -	switch (fid) {
> > -	case PORT_FEATURE_ID_UINT:
> > -		v =3D readq(base + PORT_UINT_CAP);
> > -		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > -		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > -		break;
> > -	case PORT_FEATURE_ID_ERROR:
> > -		v =3D readq(base + PORT_ERROR_CAP);
> > -		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > -		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > -	case FME_FEATURE_ID_GLOBAL_ERR:
> > -		v =3D readq(base + FME_ERROR_CAP);
> > -		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > -		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > -		break;
> > +	if (type =3D=3D PORT_ID) {
> > +		switch (fid) {
> > +		case PORT_FEATURE_ID_UINT:
> > +			v =3D readq(base + PORT_UINT_CAP);
> > +			ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > +			inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > +			break;
> > +		case PORT_FEATURE_ID_ERROR:
> > +			v =3D readq(base + PORT_ERROR_CAP);
> > +			ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > +			inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > +			break;
> > +		}
> > +	} else if (type =3D=3D FME_ID) {
> > +		if (fid =3D=3D FME_FEATURE_ID_GLOBAL_ERR) {
> > +			v =3D readq(base + FME_ERROR_CAP);
> > +			ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > +			inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> > +		}
> > 	}
> >
> > 	if (!inr) {
> > --
> > 2.26.2
> >
> >

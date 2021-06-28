Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767533B57E9
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 05:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhF1DlM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Jun 2021 23:41:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:46900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhF1DlL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 27 Jun 2021 23:41:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207824419"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="207824419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 20:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="446392703"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 27 Jun 2021 20:38:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 20:38:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 20:38:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 27 Jun 2021 20:38:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 27 Jun 2021 20:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3OfPYA5/6ji+KBzI//fA7d1C545f15P9gVeM4Gw+WBmcdGis0Ew2WDUx9wJO5kE6VCHsnWo7IDAlORZq3ZW77lxYk1rKUOilcN3RJJ9mRmfRLhfUD89wZjw51YHtOvyi4LiTXSnuVeaJMRb86BN3PX38V0YgJwnMnpjFUuV2yC7bvlKj+9+YLKgOrJsQzLaedIr6AOZ44QXZIEiIczCA44Rr7yAufOUp5HNMuh47TDN9Gx1ARC5jPW9tyqui6mTFiAMMV1e2UmtYijs+YRG+fA5m8hNRzDaIq0kqzFvTabUnwYL3AT6eLGYamtZJZkJQ8E7g+Bf3A8QPZJH+bMUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Sd5eMP4SP4H9VY5VQ+cMdvXnDl5+lResIf/XVdruI=;
 b=ApE4Y7Ny2ooiIuJUkz+0HMLOKGCbWyfNOvETFEYv4xKlMQfX7yrvgMJQg49/zR7xY0xIAP3imzD/R4o/k+jPcPJNKkHD7zTuxj1IwuN2sQ5FRzm9i6KX28fqy/Jfbnw6aXT4FFGnujtVaocjbRutD6Hc9XycED9ePmO4DhunK24+9q/GQbO+cBecZFNvo1OpwRVS7DWTsVZA9Wu+Al1xnZTQfPB3Yg69JhbfggWI+YdDju7+LOKZfyft3f8ZQ9ARh08V8Rn7y0nf2g605CwWgIMEQmU2DV8dENcUeqqK/e5Lf0+3QU+eg7IlBs44r3n6TV7sYJ8pn5QhyUORmNeIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Sd5eMP4SP4H9VY5VQ+cMdvXnDl5+lResIf/XVdruI=;
 b=I2KqPwaaxOA+dh8GSg3J3++b3P/arn/t5udk93bgma+D6WB7KACcvwzXXiaC0h5miCjcyH5lrVM7EcVwy+em8piR8tEMuJymsmo+rfvi6x7vLsBfbvJyfYy8D8Tgf3JJDtQA3X/wzFkhYxryG9n+MIf75Bt/Pzflbu6Fob0KNVo=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 03:38:36 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 03:38:36 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] fpga: dfl: expose feature revision from struct
 dfl_device
Thread-Topic: [PATCH v2 2/5] fpga: dfl: expose feature revision from struct
 dfl_device
Thread-Index: AQHXaZW3ZjGOMu3zfEylhprv7pbIoqslHOkAgAOolXA=
Date:   Mon, 28 Jun 2021 03:38:35 +0000
Message-ID: <DM6PR11MB3819DBB21CA55582FCF645FD85039@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-3-martin@geanix.com> <YNYt+Dl43zhkjIhI@epycbox.lan>
In-Reply-To: <YNYt+Dl43zhkjIhI@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf54880-c5a5-4c56-52ea-08d939e63604
x-ms-traffictypediagnostic: DM8PR11MB5701:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5701B5B70866C0D477DC777D85039@DM8PR11MB5701.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 528WZnZWSIl7MSIZH8jmqrH8PtQVUT/9qbLli3le1gs5qbpfD99omyTA2oj9fIYQlnAdTxpmlEtQMl14VFcsR9Wkp3o+aEGv4q0vHUQAkbfT65Igz4UdG1vgqoIw9fMoN/vwEQOlLJdkHrFb2ATNSptmuCNpQdNBGUL6wqEkCL56bloGmERH1qt2OqR9e1Dc86Ycd1n8n5HoonAbdDeUbolP71MOKeU3O8nC16NsKhWNRx5+JB3vwMWazNinQzHAkkQFjAy7dVF0F0Bob4LsnrD2bSVAT4A0GWCGJ8XFfFt/MBR2ppaWb00oU2AZg5dYg+BokR5fvU47wFnmBb/EHCltNVO6YSv6MuhvHfJdLI2IjidC9Peq3APlpG0JnR8EBBbx4dvhBhLsoCLwFULSLWqSISu6aeo2TXStEe5zFeZf4Ltl7g1y0uEbxkswDsHttMkmHIvoeHa/xTx3VFpFwkxK8EpJ4r5sdebPjjHlGnXLOQnNg7ny7vWAvJCYuSFMKEiaf40nHJ94Ph8Eq8S06E97n8kBODxaakOFqYk59iuptH+iGIldeYjSEF6lJiLKSacCay8u/JEu2HQm9EbyiIXfPvUY4wXF+ssW65M2sR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(136003)(346002)(26005)(71200400001)(54906003)(316002)(6636002)(52536014)(186003)(122000001)(66476007)(76116006)(6506007)(5660300002)(478600001)(66556008)(2906002)(38100700002)(4326008)(7696005)(66446008)(64756008)(110136005)(7416002)(8676002)(83380400001)(66574015)(66946007)(86362001)(9686003)(33656002)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uRCA+N9JM21+M5QO19j2CFamYrNxEzQ2yNm0TTGjSKpXFPJW3JUcHs+8lU?=
 =?iso-8859-1?Q?sXJae62Y0Rv5+u3lqM2cNYvWpY69IrEV9wL0Ei+RE46OIAhZsz5ExAAqwA?=
 =?iso-8859-1?Q?Yq8UdM2yE/xwXn+1Niz+K6gjzF1qO/U3pm5D32a9mUw6o/YSc2JdMQkZdX?=
 =?iso-8859-1?Q?xgwciLj1VM47aFLpM0muCOhEiJhE9NUh6/wPddYI1sscEnfyBB8B+JnFrD?=
 =?iso-8859-1?Q?dbJBCyRjuRi/xTluHChixVLCtj5G2tFuXC5JPwOm7/KZIujJf9IbmTbJbk?=
 =?iso-8859-1?Q?NHls7cpePMvNnYorreylV7ztcI0I+nukmytm6yO+yFx/8iBFL6c4bdapVa?=
 =?iso-8859-1?Q?OB/g9TCNQ5Xr7YmD6PLpK79/UjPQ4frhrfqA4T1FDUJsRA5Y31fvmfQJNV?=
 =?iso-8859-1?Q?BIGrWR3puI6ewkvRN2NKjFUxAfYLBcXbWOTp5sA291wHoNP17lG3XWz3Zb?=
 =?iso-8859-1?Q?ittuK5q1g4bVq3GpQxpnxmRCBk0oKKyNoF67Bd+xgpUzf2AZwgd24rTRJg?=
 =?iso-8859-1?Q?duSAL0VTY53igHkycj3DTv+SbPshu1pBd8Z7Zk5iw3CK85q3zKy/FVBhMP?=
 =?iso-8859-1?Q?Yuzlf08gcD/un5zeYsO9MgSoEhTBXX8uWjRixm2geCIPjB7NWhXgDm/9ta?=
 =?iso-8859-1?Q?zEGQ3cMp4EfRVTFrLJSgr+/BcDtx3E1m/iHnnY+mLN/papvH8Oi6Hl+koQ?=
 =?iso-8859-1?Q?T9f8xgEj9Qv8PjfEmgzQ28cN51Bb0ulTRw7YbleVI1ye7PTZTZvlDRuHYW?=
 =?iso-8859-1?Q?NibGPeUEv22/LgeHhcH5ORwYPzcwX7FotXkJEr2RGTYV9eAVF0sUwoS+oB?=
 =?iso-8859-1?Q?y4di10Hu51LMsOwNN+gkuoPaetBfz+iOMT3m/JC6bybPXxCb9aUNs8wYtd?=
 =?iso-8859-1?Q?roCKaY39ygorpJJMUkCDo3wdAl7/gEIzjXpZzXCkg6zaWATd0tfFCzLONf?=
 =?iso-8859-1?Q?EGJ6RhjAh51PJoPMM6Cx1/EOmCb/H5CohkcU2ojFhYOq/4cxms/scoyoh6?=
 =?iso-8859-1?Q?TtGYztEZG2ANYLY3zbBuHg0d3CFzHQCJDp+to5R5UB9LYKbqP2DsGO+LW3?=
 =?iso-8859-1?Q?rO2q36MK6iJy0HtUW9hevndz+6H6EJOcSMcla8v3f9Sp3gR9bCdEXXROjx?=
 =?iso-8859-1?Q?lTmqnCaxUFndbZBQkDFgEqEbC7iubwkOrUmRoTmODvVVKYC6TFhhuCypcH?=
 =?iso-8859-1?Q?YMH3TFG9IqW+ra3cO9SIeo42dwicCHZ9jyHoxw4p7RTF4+JCqhWQIX0xO8?=
 =?iso-8859-1?Q?gbnR0XBs/RDmtBldTDyJzw5t5nkc8tX+6vbEq/4LL31f5UWR3Lx4ep6GE+?=
 =?iso-8859-1?Q?WyF8xR/gGDorEInvYtAfeejjOaOa4yBYmrCJskoHNF+bU1o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf54880-c5a5-4c56-52ea-08d939e63604
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 03:38:35.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPeNSORlDch1Lyo0vIyN6+081OFZyx1+1Ait5LyPZyGlu1NJ9X+RxAGT91duwtcxlx9zn6ldWvex9xdZfBYnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Fri, Jun 25, 2021 at 09:42:10AM +0200, Martin Hundeb=F8ll wrote:
> > From: Martin Hundeb=F8ll <mhu@silicom.dk>
> >
> > Drivers can make use of the feature field from the DFL header, but
> > shouldn't know about the header structure. To avoid exposing such info,
> > and to reduce the number of reads from the io-mem, the revision is adde=
d
> > to struct dfl_device.

DFL driver may need to access DFL header (if device specific fields added i=
n
the future) but at least no need for common fields. It sounds a little conf=
using
to people, that the purpose of this patch is not to avoid exposing such inf=
o.

How about this one:

DFL device drivers have common need of checking revision information from
DFL header, as well as other DFL common information like feature id and typ=
e.
So this patch exposes revision information directly via DFL device data str=
ucture.
As DFL core code has already read DFL header, so this patch saves additiona=
l DFL
header mmio reads from DFL device drivers too.

Other places look good to me.

Thanks
Hao

> >
> > Signed-off-by: Martin Hundeb=F8ll <mhu@silicom.dk>
> > ---
> >
> > Changes since v1:
> >  * This patch replaces the previous patch 2 and exposes the feature
> >    revision through struct dfl_device instead of a helper reading from
> >    io-mem
> >
> >  drivers/fpga/dfl.c  | 27 +++++++++++++++++----------
> >  drivers/fpga/dfl.h  |  1 +
> >  include/linux/dfl.h |  1 +
> >  3 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 511b20ff35a3..9381c579d1cd 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata=
,
> >
> >  	ddev->type =3D feature_dev_id_type(pdev);
> >  	ddev->feature_id =3D feature->id;
> > +	ddev->revision =3D feature->revision;
> >  	ddev->cdev =3D pdata->dfl_cdev;
> >
> >  	/* add mmio resource */
> > @@ -717,6 +718,7 @@ struct build_feature_devs_info {
> >   */
> >  struct dfl_feature_info {
> >  	u16 fid;
> > +	u8 rev;
> >  	struct resource mmio_res;
> >  	void __iomem *ioaddr;
> >  	struct list_head node;
> > @@ -796,6 +798,7 @@ static int build_info_commit_dev(struct
> build_feature_devs_info *binfo)
> >  		/* save resource information for each feature */
> >  		feature->dev =3D fdev;
> >  		feature->id =3D finfo->fid;
> > +		feature->revision =3D finfo->rev;
> >
> >  		/*
> >  		 * the FIU header feature has some fundamental functions
> (sriov
> > @@ -910,19 +913,17 @@ static void build_info_free(struct
> build_feature_devs_info *binfo)
> >  	devm_kfree(binfo->dev, binfo);
> >  }
> >
> > -static inline u32 feature_size(void __iomem *start)
> > +static inline u32 feature_size(u64 value)
> >  {
> > -	u64 v =3D readq(start + DFH);
> > -	u32 ofst =3D FIELD_GET(DFH_NEXT_HDR_OFST, v);
> > +	u32 ofst =3D FIELD_GET(DFH_NEXT_HDR_OFST, value);
> >  	/* workaround for private features with invalid size, use 4K instead =
*/
> >  	return ofst ? ofst : 4096;
> >  }
> >
> > -static u16 feature_id(void __iomem *start)
> > +static u16 feature_id(u64 value)
> >  {
> > -	u64 v =3D readq(start + DFH);
> > -	u16 id =3D FIELD_GET(DFH_ID, v);
> > -	u8 type =3D FIELD_GET(DFH_TYPE, v);
> > +	u16 id =3D FIELD_GET(DFH_ID, value);
> > +	u8 type =3D FIELD_GET(DFH_TYPE, value);
> >
> >  	if (type =3D=3D DFH_TYPE_FIU)
> >  		return FEATURE_ID_FIU_HEADER;
> > @@ -1021,10 +1022,15 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
> >  	unsigned int irq_base, nr_irqs;
> >  	struct dfl_feature_info *finfo;
> >  	int ret;
> > +	u8 rev;
> > +	u64 v;
> > +
> > +	v =3D readq(binfo->ioaddr + ofst);
> > +	rev =3D FIELD_GET(DFH_REVISION, v);
> >
> >  	/* read feature size and id if inputs are invalid */
> > -	size =3D size ? size : feature_size(binfo->ioaddr + ofst);
> > -	fid =3D fid ? fid : feature_id(binfo->ioaddr + ofst);
> > +	size =3D size ? size : feature_size(v);
> > +	fid =3D fid ? fid : feature_id(v);
> >
> >  	if (binfo->len - ofst < size)
> >  		return -EINVAL;
> > @@ -1038,6 +1044,7 @@ create_feature_instance(struct
> build_feature_devs_info *binfo,
> >  		return -ENOMEM;
> >
> >  	finfo->fid =3D fid;
> > +	finfo->rev =3D rev;
> >  	finfo->mmio_res.start =3D binfo->start + ofst;
> >  	finfo->mmio_res.end =3D finfo->mmio_res.start + size - 1;
> >  	finfo->mmio_res.flags =3D IORESOURCE_MEM;
> > @@ -1166,7 +1173,7 @@ static int parse_feature_private(struct
> build_feature_devs_info *binfo,
> >  {
> >  	if (!is_feature_dev_detected(binfo)) {
> >  		dev_err(binfo->dev, "the private feature 0x%x does not belong
> to any AFU.\n",
> > -			feature_id(binfo->ioaddr + ofst));
> > +			feature_id(readq(binfo->ioaddr + ofst)));
> >  		return -EINVAL;
> >  	}
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 2b82c96ba56c..422157cfd742 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -243,6 +243,7 @@ struct dfl_feature_irq_ctx {
> >  struct dfl_feature {
> >  	struct platform_device *dev;
> >  	u16 id;
> > +	u8 revision;
> >  	int resource_index;
> >  	void __iomem *ioaddr;
> >  	struct dfl_feature_irq_ctx *irq_ctx;
> > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > index 6cc10982351a..431636a0dc78 100644
> > --- a/include/linux/dfl.h
> > +++ b/include/linux/dfl.h
> > @@ -38,6 +38,7 @@ struct dfl_device {
> >  	int id;
> >  	u16 type;
> >  	u16 feature_id;
> > +	u8 revision;
> >  	struct resource mmio_res;
> >  	int *irqs;
> >  	unsigned int num_irqs;
> > --
> > 2.31.0
> >
> Looks good to me, any concerns from Intel folks?
>=20
> - Moritz

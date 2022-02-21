Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE85E4BD7AE
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbiBUHzW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 02:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBUHzV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 02:55:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201211A31;
        Sun, 20 Feb 2022 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645430098; x=1676966098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SQj6QJZHMMo535fWXjA/V/30cMs/czN0U3RauPWW52E=;
  b=Xbic9IHHU6QXNzZrlceOqpxCI4k5SHklGmUWqIuoFqKZSBDLsej8r3rE
   TVSyrgAajpoNt87IY6W2boHvH8mEBnyTErI5G7V5OHaksUgQe59xZVmK9
   a1DrZoEtZMNhPm7UegXBAA2pByOgomuIXTLCoVeVgqHWGcnJ8/y/4iFbJ
   GOrXLLzG/e7yZYNK+QRb1684G+x9HPX/QDpDsY4tHSSBNpWPZph/5Vl4I
   tuyeMQo65QovMjVIyuqxBgqSNsGSRTC1DecXxUfjDrHrre5CPVaAnUhU3
   mRAhxsKfS1aGUNWTmhens9Bvg0BpDsoGCeGJjxSUYJBsOKD+DVuZHAvgL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="232078507"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="232078507"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="627294541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2022 23:54:58 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:54:58 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:54:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 20 Feb 2022 23:54:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 20 Feb 2022 23:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fktMedq/zo4uGVpAyhAkvaoztFt5jwPW9vFMGAVd4vJ4MFZJ2/CifpZ1dAEz+be+FCN8yyxUIHdIgJJk82TKRRFgvtuo4bc1oz6hVXkb97UbzbMJcjmya5+Sad1RV8Oq3AGxk7/PjZTUMhQ/mMe7QZkeQlTtfI9cjwTSu9XORAQW8eFJkdfZTj4OvrYZK9Cf0oMl6iJ3XEQt1PD89YSSOrNsXjepfnrRBKJ0tW73OV2ZpicbqML2JbK6PSz9IawnciiWlLW6h/BWSR5OcD6uuINgVu3tPvP0fnde5fvz6QeAbkisi01qx42v/dwFHfg4S5ta6BT9QTBAzpB6vwYqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaWY6hJXtmsL4UnqFajL3+8/ouNEtscJimfPB3jr+qc=;
 b=F5z2JBG77q9oE/51CUdgM6O5XC+SDx3MyMxk9nkVePvq10/0Qh81DU//+WlAPYPNIrmPNd9xVNJTLaBJ64ZG8ESRt2x4YD11cb2SXHXOiSg/88KCsS42RJx4eiKIp1J/UuioqycZLNUUjsX3Z4DCLID7DBr18tuDmQPolyq//ZhEI2kx26AfVUKdttTO2GlKVaqDC6VSZ4vg6Pj9Egn3L1EMOg0FGJHLU2WXEnLU5NZg0mb0RFb3/xuXyRQ1k9RxvbnMJ/1p57T4cl9cIg3SCvELXR9NQjt8sRGTBYJSl2VIBFLSnU9JFYi81L+0bb1C7XvqNgQrT8pUyZfmVDMShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SA2PR11MB4987.namprd11.prod.outlook.com (2603:10b6:806:113::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Mon, 21 Feb
 2022 07:54:54 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:54:54 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
  info
Thread-Topic: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
  info
Thread-Index: AQHYI6ii288SiYkZKUC48TEHx/h38qydqJGA
Date:   Mon, 21 Feb 2022 07:54:54 +0000
Message-ID: <BN9PR11MB548399A1D6A4942D9C36B723E33A9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
 <20220217023816.GD1145049@yilunxu-OptiPlex-7050>
In-Reply-To: <20220217023816.GD1145049@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 2d072596-5079-4466-5267-08d9f50f72cb
x-ms-traffictypediagnostic: SA2PR11MB4987:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB498766BB847AE6EC29DB7E7DE33A9@SA2PR11MB4987.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oj+Gq0tYLnU37V+TVzyNsjO5tnstfGFRdQ2GlIho5R5qnBTzs9EBmGJ7RyMVL3Ob87LJBuvO7lf3dkZgmmJKw+m9oC4TMkgzqW7Ho4fnkz0at7MojtMv6wgLs+LsGzIWInODI7qjn2ski2wU9shgdAC2dsb76notzuBcJ0P+7fHHRwZKNn7GLMS4QKbNDNbWzfzFoPEV8CEJIGP/Ku02Vaw/lrqym36DSX6iVsOVBA3WQq3qaa+X8neLastm9H7WnbBNX74CRf1/ne8T5apdSaI61ZBnZrJpN48h36LaKWPZ8DcUq0fe280vM6j1qtKq/FQ++pAtygi+4fBc8M10JlnwC6bOiyPZaIqfYrTC/h3zcPdkso4H4cj5N8lskRfBllXZowVs+1nHYWzgBi/ARHo1TbW3M3kIiwIvsHP+x5uIJEXKuYTYpD1TWNeIL+kWJUkeST8WX3s5idXFdx3Uik56ftFn0wjJhYR6muSGm2a5aTP+mSj6wp80EFzXaCrIN2PJin4xkCmPYKYiCPn6MIsw3V2bAt54c4lFu3/QcEsabXUnf6HtiyJv+BHsqTGWh6lQVoG3l80VKKMqNmfzfnBzD+ZrKzbJrWI0cLj7SZZ4LX2u0WDivkdzu42bhSzfDEE18evwFEBMCIqKzobxz1B6L/9PgmBgBgy8GgAVKYonf3KyE8EPP07M699RTz+kZkOlDaw7ZJJQalulwc51bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(54906003)(110136005)(66476007)(66446008)(64756008)(66946007)(86362001)(8676002)(4326008)(76116006)(316002)(33656002)(122000001)(26005)(186003)(66556008)(71200400001)(83380400001)(508600001)(5660300002)(53546011)(7696005)(6506007)(9686003)(52536014)(2906002)(8936002)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jgR0xXFCSw3bvC2vsUG2bomBrbvJsunv73ChD4Y6LTjdyUXrzxjzQVTTBd?=
 =?iso-8859-1?Q?ssofdxesrbn7A4tUZaDm3XrulgThquikuPxhkPCWHOTtx5PR8BtTYexfPt?=
 =?iso-8859-1?Q?Xd6IA2U2SFdl7jUIFsUwG4jWlMnB3d7Ug6SMov/xtU76qFe652p7Tz5+MW?=
 =?iso-8859-1?Q?Tn74r/nq1Tuq9a9r/+u8xUJ177tvBxzOOZnDfqGMUeSHwjyC5wCl6m5Ph/?=
 =?iso-8859-1?Q?KJLAkVdDe2LsY5hNNf7+2BZNoBdlmRHI01oUO0HisR5tC8kDWzYncPUHSK?=
 =?iso-8859-1?Q?1jnMLtVNX+Doh1frho9eV1cNlj6yUXP3XEWLxUgpzDo1dLAzR0v2hmcCx8?=
 =?iso-8859-1?Q?G2arXd3RgyEpKvk1oyO4ObFF7UVKkuY8yYKBdZSPaGQoteru4g6DVFGjWr?=
 =?iso-8859-1?Q?+ql0ja5aqfMvLPh8dT4zsESRDIxJAia19S/95J3RUsNfuoMNY8Vyy1W+Ys?=
 =?iso-8859-1?Q?wLIwuZ5BZdpvDvpeZNVs6dApSFUfTU9oG2kYjl12+j3iyl2boH0BaPcE87?=
 =?iso-8859-1?Q?C9TpiytHBX5nY0uTdkMq3Q513LaazMKUPgUow4wIqIFxjEKxA791FZRwuY?=
 =?iso-8859-1?Q?Xfvm/JdCB+TWeKJTWpjlYjNSED58ZsJoGx6wA/y3+ZNiHV/eyAxY8BOs+T?=
 =?iso-8859-1?Q?zUzJFovMoWVOiOeZh6Zu2ehN3pES2uoaQQmO7Qk9LfgaTZopL9XMsZWII0?=
 =?iso-8859-1?Q?oU5hx4mHlRs3A6Uh9qF2N6sXQbmiRzY9YZ5U2i1d4wFR1aoQYUlrqG1Xhp?=
 =?iso-8859-1?Q?IP/FiXnBd8XXf0u9VlfCjFgP4KDxUgjpbXUCb43WC+IQPP8LobO2HKKLlX?=
 =?iso-8859-1?Q?P7WFQe7om+Y9qEQ5LCZtDyTGtyUxhN8eqcWtNpyJPJZ+j+ui+0ATS9v2vN?=
 =?iso-8859-1?Q?BHkuIXzWESOHyIGao/VyXF/a1nyim36mm0eZIs6fUoiprB5w2Pj+qPTfOx?=
 =?iso-8859-1?Q?x8Zyik2zRP3OPU/Eztn2BeTkY8UP1FF39N7jAls6drPFjzGAfXO4rhxoOo?=
 =?iso-8859-1?Q?l1VkAk84cPdq3KtyHGOBJXewr8Mze0jsyq03zRwGrwnf7ivNG89gyg+Qrx?=
 =?iso-8859-1?Q?FrHrb6iopEBGCdtC3vVcvZ1P4TLmXKkRDeE+BPeGjDV6TLNJ1ad8x3jAn2?=
 =?iso-8859-1?Q?/8FtK/r8xxvclSk6PBIPe+6N2nWJEqqr9QxgHX5A/JdFinRqeYUWBXDrZ/?=
 =?iso-8859-1?Q?sjqWxLQSC6t5I4X3jgCn349Bp+78LX6sLMvflY6HVFOU0oYCD2kZAYFFPw?=
 =?iso-8859-1?Q?5XuJqmaq3WMqBubEBGSNgi5a/7GdaSWlPIqLg0jxgVdKG0g40smG5Vj4rz?=
 =?iso-8859-1?Q?OImM2gBRwAkE/i8WwmuftU2wyjsjb3l0J1RoYuo32EkMEZ+GsXvBMJyPKN?=
 =?iso-8859-1?Q?EAA3bnv5iCxsCTtLIjX38IPdItvbBzoajTV4Z2dHMZSUOKbiM7MDtsKSLP?=
 =?iso-8859-1?Q?okTdLZfMdCOOplBC6ppZPG5Nh6Kf7c2rCmCH3nJBBOF3XqaEacF+D620HQ?=
 =?iso-8859-1?Q?sE3DKcKDNbO/Jk1VzzjR0d4L9P1dxUNmkmpQRxLTBgXNBsgUivfT5GGXcB?=
 =?iso-8859-1?Q?sx3h22EdCN/pZou7Ow60CX05wMKRbyFIS5HlFym5RpyDSW84WFMje9Bdc0?=
 =?iso-8859-1?Q?Z5n9uJTryjuXHyJ/gLlLydWVXIq+ciqVCqF33AH20c4v7Cxd/hFD8W/5wO?=
 =?iso-8859-1?Q?H0AEv4Zi1VqI94Kp52c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d072596-5079-4466-5267-08d9f50f72cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:54:54.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mS4e44oIJ/9kiZj2x1hdrP4pkcuilXJkpTIBFMcIkVbYivO4LJavCFU7KgwKu3AxdYgCIgXhwy47e1UEocGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4987
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
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Thursday, February 17, 2022 10:38 AM
> To: Tom Rix <trix@redhat.com>
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
> mdf@kernel.org; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; corbet@lwn.net
> Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse ir=
q info
>=20
> On Tue, Feb 15, 2022 at 06:49:05AM -0800, Tom Rix wrote:
> >
> > On 2/14/22 3:26 AM, Tianfei zhang wrote:
> > > From: Tianfei Zhang <tianfei.zhang@intel.com>
> > >
> > > The feature ID of "Port User Interrupt" and the "PMCI Subsystem" are
> > > identical, 0x12, but one is for FME, other is for Port. It should
> > > check the feature type While parsing the irq info in
> > > parse_feature_irqs().
> >
> > This seems like a bug fix and not part of iofs feature.
> >
> > Split this out of the patchset.
> >
> > This is a workaround a hardware problem, there should be some comments
> > to the effect that you can't trust _this_ or _that_ feature id and
> > some special handling earlier.
> >
> > The ambiguity of feature id is a problem, and this sort of bug will
> > happen
>=20
> Actually this is not the feature id definition problem. The identity of t=
he feature
> is determined by the dfl_id_type(FME, PORT) AND feature_id. So the driver
> should match the dfl_id_type & feature_id to know what feature it is.

In this function flow, create_feature_instance() -> parse_feature_irqs(), t=
he DFL driver has not
check the dfl_id_type yet.

>=20
> Thanks,
> Yilun
>=20
> > again.
> >
> > What can be done to prevent this in the future ?
> >
> > >
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > ---
> > >   drivers/fpga/dfl.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c index
> > > 599bb21d86af..26f8cf890700 100644
> > > --- a/drivers/fpga/dfl.c
> > > +++ b/drivers/fpga/dfl.c
> > > @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
> > >   {
> > >   	void __iomem *base =3D binfo->ioaddr + ofst;
> > >   	unsigned int i, ibase, inr =3D 0;
> > > +	enum dfl_id_type type;
> > >   	int virq;
> > >   	u64 v;
> > > +	type =3D feature_dev_id_type(binfo->feature_dev);
> > > +	if (type >=3D DFL_ID_MAX)
> > > +		return -EINVAL;
> > > +
> > >   	/*
> > >   	 * Ideally DFL framework should only read info from DFL header, bu=
t
> > >   	 * current version DFL only provides mmio resources information
> > > for @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct
> build_feature_devs_info *binfo,
> > >   	 */
> > >   	switch (fid) {
> > >   	case PORT_FEATURE_ID_UINT:
> > > +		if (type !=3D PORT_ID)
> > > +			break;
> >
> > Instead of embedding a break in the switch, break the switch into fme
> > switch and port switch
> >
> > if (type =3D=3D PORT_ID)
> >
> > =A0 port-switch
> >
> > else if (type =3D=3D FME_ID
> >
> > =A0 fme-switch
> >
> > Tom
> >
> > >   		v =3D readq(base + PORT_UINT_CAP);
> > >   		ibase =3D FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> > >   		inr =3D FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> > >   		break;
> > >   	case PORT_FEATURE_ID_ERROR:
> > > +		if (type !=3D PORT_ID)
> > > +			break;
> > >   		v =3D readq(base + PORT_ERROR_CAP);
> > >   		ibase =3D FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> > >   		inr =3D FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> > >   		break;
> > >   	case FME_FEATURE_ID_GLOBAL_ERR:
> > > +		if (type !=3D FME_ID)
> > > +			break;
> > >   		v =3D readq(base + FME_ERROR_CAP);
> > >   		ibase =3D FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> > >   		inr =3D FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F575504AB8
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiDRBzK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiDRBzJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:55:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B935183A3
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 18:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650246752; x=1681782752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AlZoLlCvOjsxKM1NoWllaDV3ggzxBrIaCwLS9vtqTig=;
  b=BP8ScFhX2ma5Rw3GnFsqxr4Gh0N5vw6sKSWuaMbSVvCuHB8XRWc2zYpt
   n73zyTHt3YsU7AUtqioZVh32PN6+GTmyTHZuoVjnILlxmKdfDV0Sn5beQ
   xDOgURGdiONASsHY2p9iLcjj7gceYA6gNKFq6zqqirBwCKDQA4OXz3UCf
   KtfS20v6UFhVBjWwOl2aYVP7z9NLpTBllU1SAeE0ADkvTFDIDW3NgEPWM
   ph82LonS6cO1quklZSU1rIaqMyUaESFey1k8wwxVsT8RmlGyuZcmkebjL
   zyLLigonu+/KpVK6Zblj/ZwgG5tqgBbv40rhmmIs0JTnTXSM59elAjKPH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="243364986"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="243364986"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="529277105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2022 18:52:31 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:52:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:52:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSKvWo5MYiNuLx+dCDIrM57gMcdrucB/SVQZuifVhZ1pp0GA+CJZE5Ij75sVaOfTRh4A2k01XSVKhbaGl3th1/w/fjbS85uctcgbb74N3pznqZYKWKUz/5jGHXASMXwgQEcbiw23D92Tc+mvAV3nN67ay+p8v1AS4Q9y3VaQmYuh75Zk7X/EH3P+nEKJapm4Bp2KbUyAAWbXkWW3ACXP+OlnV0RCfJ8kAQN4HSROKYo5Imyrg7+nZhfAVfPblBwFwcjVGWqqp9ppih/zAqoXHBy/kPEHUVTvXVfmmH8ftNHTR2WakaLP0/A9+BS9b+rzfI3EJhQrxZAXcK0+Spo+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=treFYVlagbb6knSQvvAs5WKEBl0fG1B5PeTFMTIcDCs=;
 b=d0J+Hbe9xi0UNN/+6nsemGBB2yUUHU4RTkqE0q+/6momJvJ1ctAvyktbWvXLgC35aaRIonnA4LKyQlJSb+gOGQuB2slPoMsxpjsfaKp5uMJQeV19/JfhBowcPLEAoXVpsX6vsCf6oDMmKBbS4Yj5zSpoCTpaMr7gj3W4wnUJSvM54yrnbpJEg/LAuad1vbvqUTYyaGQIeTdRo9IARa0rIyGWbxXBkhvPrK7bvzAnvUdpRzv0lFbFfk7Crk0ZW98zAKNLsIxjJf3tL6FClnPFq9TYv2NEDo+pQ8dw/6CyI/pX7mwTX1hSGcoRyiBCx1n1X3xtK7KY3/a2xlkVwaQk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BN9PR11MB5369.namprd11.prod.outlook.com (2603:10b6:408:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 01:52:28 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::9973:b30d:11a6:da91%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:52:28 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYTjf3U79tFgn6Ik+Ohp7VUNfX56zyt6YAgAItQBCAAAdKAA==
Date:   Mon, 18 Apr 2022 01:52:28 +0000
Message-ID: <DM6PR11MB381931AC7159F2D1262F05C385F39@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220412063523.54587-1-tianfei.zhang@intel.com>
 <20220416155258.GB301222@yilunxu-OptiPlex-7050>
 <BN9PR11MB54833E8D5E0853DEC4AEDB34E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB54833E8D5E0853DEC4AEDB34E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: a7dc4c18-c71a-4a85-cc8a-08da20de1818
x-ms-traffictypediagnostic: BN9PR11MB5369:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5369890FB25B4A648DB9269785F39@BN9PR11MB5369.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9m0U6HX3ETlGuNPy12h5cr64ICoCVjqn50vT2qA0pbEF/cbt5I/tZat2kbJvSpKDM7BZJjaUHbpJsYdEhoNbQig1/a6dMLNazRj88vtH9pLPc1dyRMD2W2nMvZecCvxyq3TD+5s8EaUHF/Wac9FyjEqrMJ3v5ZiWH91MaDP7FB5Dh3CAwo5WP7bCwPaydaB0MVw4UtVXHYmWTrGHxoC3Si6YRueITM70+CPqa+4LU0Br/8WpjS9klYASe77Vh+pmisp/Slz4yBfs5yd650tRt5uIhRutL1gqkXiEV/SNV2Vw1VmryUPfh/wyu0tiVWJ3LM5bPOPN0AmcSuND0/a2kKNIEmyNmnduvUIznVTkKdOfrtPGQQpNw/8wVZaIh0FcZZ+81HiMpqzhdf8n900xxB8tzFgXl+3I7XL121Rt/FHxv0ChTB+WTPEp3G0ivWwpbG1YUPsE7Jp+9MDKFIIVUk41HavSKRRKL+CfRG0J6vKEqGFv1oWrkitVLOTbq6oWpF9vmYbh4raH/KniwjE+1SsEwOOlw50YUBa85QM3dlxjiPS7IVSNQVtXsIuWHz3oLyUkbKq03VuUddpoJikSTgGG2vUSV7vWpfGGZXze2A1l+5lSmPArsRWl25v3c3EvaPFN8fuAjMbN2Nfu7pepJJYSCNHhfKBy8vqCTrlVPs6wOaQMhL6qyc1SS8FbGFQSI4zrWWeReBTxvOaM8IIgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66476007)(66556008)(76116006)(38070700005)(5660300002)(2906002)(66946007)(71200400001)(4326008)(53546011)(66446008)(186003)(26005)(110136005)(86362001)(6636002)(8676002)(6506007)(7696005)(83380400001)(9686003)(316002)(55016003)(54906003)(122000001)(82960400001)(52536014)(8936002)(508600001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HazCf0IIZ30GoIUIeD2jBDiCC2WA8ZDkVQLEXCrXi5lIfZnWNruTZbtvvcja?=
 =?us-ascii?Q?+CJu8+uqMbljFpGRqdsXE0PrwxlW98abIJ9lsEDP8hNz8o0JBGCTvkoYPqfr?=
 =?us-ascii?Q?fayhaIkpWhN/LC1e3KqdXwmoNGXtAZIiV72kbrd/wV7/eIWNBz3Jvz3kBUxG?=
 =?us-ascii?Q?21EZgvapqY2gBHY3Lk3VS6CLNxHM/gzMv4YOBo61ddOKPxVCDsYKb91GFF76?=
 =?us-ascii?Q?HJYCi15Qq1olR0NJTf87mn5TAPhPxSg86ARYF7Ole1p9Eams/QKHhQdMNYJV?=
 =?us-ascii?Q?SkLsGSvvn/favqk0cqE7f3mHEhIda9mq9hKXFNQxBgPPqaCfKBjlvfNcdBYm?=
 =?us-ascii?Q?Vm7o9IpeNfOZYNrd4tMDMjtr6N3j/QILf+SL+f/yk6X/8EeshhsaJzK5PkHK?=
 =?us-ascii?Q?mxp5koiKDsFsiiwYW+EueqjgrFyen1XzCVPsK1OuI0I9Zv+LuKOoeCc/Dtd9?=
 =?us-ascii?Q?4Un4lRctDeHITpuvRxPcuAbE/rvGxd1m5WkEh+KaboPY0x443lEWp8VKFPI7?=
 =?us-ascii?Q?4wn2QTXhPSL8Qu6200do+e7L313PzMUNbv1JEvJ2Rql+ioRo0g6y1HLGSGNg?=
 =?us-ascii?Q?MCH0T/3V8s0Xj7HX8P+SVO1HyR6QPigPA1/JlQDwanpyFUFd3N27eEJRG3Um?=
 =?us-ascii?Q?6F4U0ghVgNjjd6y5DE6EA63vOVgpDFgBQ9BGR8004WzAWCKO8ACQYDBeiYIU?=
 =?us-ascii?Q?jEj/orvXOttbUTencWGnmrV8MESLjS/g9neUzEVtrGC7eywgM++voK7dNCQL?=
 =?us-ascii?Q?AmZS9R+kd6LQjZ/REQNT56OrV0sQxiljoP7JSnq+KFKVvtjo4gW7/IsQKAmp?=
 =?us-ascii?Q?aNAINZcbqCYwLtD34PW9aHjzcLZQA5nvoPfrM1OgAoKgil/jOiwg+an7t9V5?=
 =?us-ascii?Q?tAlUmmuy4bWQaG5N3TnkediLxnu6EF2/WKxqiaImY3Z83+f2pN3EHdggFOqe?=
 =?us-ascii?Q?Yh4X6jafeIrg8GWJS43RzpDUQlMPYbgqkI3iemjN3oicVlgDhEGuYzifeA3K?=
 =?us-ascii?Q?8WG/dRFAvschyu6y2PRGznWjKvJdSzgZmfjLxuFIt8gXvxYiLt5gg2+vgjtu?=
 =?us-ascii?Q?VoNYLimPu4egq2bxChsFtEzVi/3Y5WudlfFBLaG3xR3GUAms+czNvkPb9DhA?=
 =?us-ascii?Q?0NJb0R7TiqMVILG7KvRXErFTde25ukwT54im7Ukp9OC5r8U9LUUexyWkIUYM?=
 =?us-ascii?Q?NZ2FtZjlBehtwPx1fpwIxWL8R9wfe1SIaPajkVC587cA48EnfbS3kWneQwyt?=
 =?us-ascii?Q?1+VW9K1m4Sl0UYNv0MyTSYHSzV+rw55fJv2jIMtv1cXflSDMxy0jKqsU5cRh?=
 =?us-ascii?Q?feCPpvNneyEDhyZ/kkg/DIC7w4PTciPFCLpofCx7xhWZqjEBzNxU/NtJjow6?=
 =?us-ascii?Q?DnPmwi3TECBkAqFDAivRlKv7NiN6PPKgIg1L0Ovy/r9LRWZBVB4gBGO7UGJn?=
 =?us-ascii?Q?91nXdjxdViRFrfzF3VEvd6AX/jqwkTmFaZHMZht7CCJCLohYfmjLMYSFupp5?=
 =?us-ascii?Q?1XtYDGWn35LggfnuQTzAikIzwnFJzse+cgUpv+86xikorFB/+kCsMv3dLkbP?=
 =?us-ascii?Q?W2GwUaN0lAmbDqgKFYtMl+Wk4FOgOgzmRznUO9nf26gA+SYggOFOn+aRdSgu?=
 =?us-ascii?Q?JAZ/Kg4yGwhNKKssMcZdKzJnuW10lcyE1PngJrb3p/yFx6u3I7/31Rui59gQ?=
 =?us-ascii?Q?KZD4xV/LAJcJRfExpqTuPUyCu4BoY9NgKAZZkmn4KcwNZLCzo1lu9QmgVrWG?=
 =?us-ascii?Q?FlZaGkh7LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dc4c18-c71a-4a85-cc8a-08da20de1818
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:52:28.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocY1q9SRfh7bVPXt2vFr5HORYSuaMdNS/l5TzFF8ER5oitszP+a1kKKYF4pWkJtbWGYyjMRuR6RxbnMAfRNYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5369
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

=20
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Saturday, April 16, 2022 11:53 PM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> > fpga@vger.kernel.org
> > Subject: Re: [PATCH v1] fpga: dfl: fme: adding reserved bits for revisi=
on of
> > FME/Port error
> >
> > On Tue, Apr 12, 2022 at 02:35:23AM -0400, Tianfei Zhang wrote:
> > > From: Tianfei zhang <tianfei.zhang@intel.com>
> > >
> > > There are 2 different register layouts for FME/Port error registers.
> > > This patch introduces 4 reserved bits (Bit[59:56]) to indicate the
> > > revision of register layout for userland application.

Please provide more detailed background information to explain why we need
this.

> >
> > Please specify that the 4 bits are reserved by HW so that SW appends re=
vision
> > info on these bits for the attr readout value.
>=20
> Yes, correct, I will make the git log message clear. How about this git c=
ommit
> message:
>=20
> There are 2 different register layouts for FME/Port error registers.
> This patch introduces 4 reserved bits (Bit[59:56]) which are reserved by =
HW, dfl
> driver appends the
> FME/Port error revision info on those bits for attribute on the readout v=
alue.

We need more clear information, why we have 2 different register layouts, a=
nd
why 2 different register layouts requires 4 bits in HW, or even 4 bits will=
 that
be enough?

>=20
> >
> > >
> > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > ---
> > >  drivers/fpga/dfl-fme-error.c | 36
> > > ++++++++++++++++++++++++++++++------
> > >  1 file changed, 30 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-fme-error.c
> > > b/drivers/fpga/dfl-fme-error.c index 51c2892ec06d..3b54470f56ca 10064=
4
> > > --- a/drivers/fpga/dfl-fme-error.c
> > > +++ b/drivers/fpga/dfl-fme-error.c
> > > @@ -39,6 +39,22 @@
> > >
> > >  #define ERROR_MASK		GENMASK_ULL(63, 0)
> > >
> > > +/* Bit[59:56] was reserved by software for error revision */ #define
> > > +ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> >
> > This will change the user behavior for the error interfaces. Now they n=
eed to
> > recognize the revision bits and discard them before clearing the errors=
, is it?
>=20
> Yes, the end-user write to those error register without this revision inf=
o.
>=20
> >
> > How users know the revision fields in output values? Maybe it still inv=
olves
> > change in Documentation/ABI/testing/sysfs-platform-dfl-fme,
> > which should be reconsidered carefully.
>=20
> I will add those info in sysfs node documentation.
>=20
> >
> > > +
> > > +static u64 set_error_revision(struct device *dev, u64 value) {
> > > +	void __iomem *base;
> > > +	u64 dfh;
> > > +	u64 revision;
> >
> > Better we follow the reverse xmas tree declaration, so reverse the 2 li=
nes
> > please.
> Yes, I will fix it on next version.
> >
> > Thanks,
> > Yilun
> >
> > > +
> > > +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	dfh =3D readq(base);
> > > +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> > > +
> > > +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision); }
> > > +
> > >  static ssize_t pcie0_errors_show(struct device *dev,
> > >  				 struct device_attribute *attr, char *buf)  { @@
> > -52,7 +68,8 @@
> > > static ssize_t pcie0_errors_show(struct device *dev,
> > >  	value =3D readq(base + PCIE0_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t pcie0_errors_store(struct device *dev, @@ -97,7 +114,=
8
> > > @@ static ssize_t pcie1_errors_show(struct device *dev,
> > >  	value =3D readq(base + PCIE1_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t pcie1_errors_store(struct device *dev, @@ -133,11
> > > +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
> > >  				    struct device_attribute *attr, char *buf)  {
> > >  	void __iomem *base;
> > > +	u64 value;
> > >
> > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	value =3D readq(base + RAS_NONFAT_ERROR);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >  static DEVICE_ATTR_RO(nonfatal_errors);
> > >
> > > @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct devi=
ce
> > *dev,
> > >  				    struct device_attribute *attr, char *buf)  {
> > >  	void __iomem *base;
> > > +	u64 value;
> > >
> > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > FME_FEATURE_ID_GLOBAL_ERR);
> > > +	value =3D readq(base + RAS_CATFAT_ERROR);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >  static DEVICE_ATTR_RO(catfatal_errors);
> > >
> > > @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device =
*dev,
> > >  	mutex_lock(&pdata->lock);
> > >  	v =3D readq(base + RAS_ERROR_INJECT);
> > >  	mutex_unlock(&pdata->lock);
> > > +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
> > >
> > >  	return sprintf(buf, "0x%llx\n",
> > > -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> > > +		       (unsigned long long)set_error_revision(dev, v));
> > >  }
> > >
> > >  static ssize_t inject_errors_store(struct device *dev, @@ -211,7
> > > +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
> > >  	value =3D readq(base + FME_ERROR);
> > >  	mutex_unlock(&pdata->lock);
> > >
> > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > +	return sprintf(buf, "0x%llx\n",
> > > +		       (unsigned long long)set_error_revision(dev, value));
> > >  }
> > >
> > >  static ssize_t fme_errors_store(struct device *dev,
> > > --
> > > 2.26.2

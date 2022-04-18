Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F2504B16
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 04:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiDRCx3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 22:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiDRCx2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 22:53:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4963B0
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650250251; x=1681786251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e7N6K+7o36KMAdEp4fEtPr9xUrioXmKUpZeaV/35oPA=;
  b=S4l+GFUi6BihmIwAUpSMSAkNy9/qec1sdAbpGTyiNPCrtUvX4XT5ifQn
   K9f/W1kqUQd+/zrzCgaM58mCuuMY/S1iydGgGXuP8jPcjfw9n0n3LO7pq
   ujrwsHMjL5LMHtIaVpggMr0UmtmiMjoye2Isw7yN2YidHlb4njz+9szGS
   S+ckWzHKIRTSlLUuxZxryKGi5H3A7iCIrp0Wv9rmhnd+vM7G5zIo0Apc1
   c22m8MbzYV8oa7OPdIE4LKDWu08NAuQ5LFc64WwX4CheS625qJG5gC9No
   zVtJFWy8scETG3mE9AI3UpHM/Y8W+fOi/WjdfKCdBULlpkB7D/uGWJ3v3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245326504"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245326504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 19:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="625144724"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2022 19:50:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 19:50:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 19:50:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 19:50:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 19:50:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er03PsyHPXY6FBMroncHAuobJ03Uo5NhsRNr8a2z9bA+FusKGxXAuy4vFR8xxEvHGyLuu02PMuiKQQfPCRL2kVXCEVUEx7Xo3mwF9kxAMCgjFon8ijvJ3OVsXokgBwGxKwrYxf5Kg5NrFVD1ZUhmodMfrV3bYGCw6YUIOcljkdnxjinZBghWSIY/aRbrpNw6XAn4BjnQaHYsLJHfMh49t+TbLPEyxq3TcqirirjRW6hXpSOvYXIkbNo1nHoNen7Kb4zIC6eOcC71l/MTEA9bMXRk5g9ZspaZvhUekxymUrTq2gGgy4rgShhMcIsyQ/2j40ly5UXgTpzno2YY98RffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry6hVEZy6fj2G0nKqFWcy8lWHbv+/gT1+AvXKKpgcIE=;
 b=lN7LITNAGHgG5Qm7GjFujBjemmDkQYKeO3d831q10vZUq432xT4AoWh7Lt1ZVBeh6+S2XiqgcW16JOJ2Eu4/xi/ZcLzDi4Tq1wsZqqZiyktBOaSpG7o4kyrN1I0hKzY4FB5WQMJbuch2rzFmkvG6oHtxuaqqYLoHcI6fcUTUAfvnf/51KZCK3CdeTKDHSwnuIdtb0GS82XubFs/hynU5m8vRm3tJuAnpM6s37NRP1WF50ZLdZiWmXUmLCHExPrBi4KRuK/MvpRf3hICBgvLx6s6UsKm+BljMn/rjc+60o3gjhcckEaSNSj3/ckS+sgT8g3qZCwG+CNY+xbeZBWRNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB3053.namprd11.prod.outlook.com (2603:10b6:805:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:50:47 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:50:47 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYTjf3U79tFgn6Ik+Ohp7VUNfX56zyt6YAgAItQBCAAAdKAIAAEdPw
Date:   Mon, 18 Apr 2022 02:50:47 +0000
Message-ID: <BN9PR11MB548392CD6116C529A3338374E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220412063523.54587-1-tianfei.zhang@intel.com>
 <20220416155258.GB301222@yilunxu-OptiPlex-7050>
 <BN9PR11MB54833E8D5E0853DEC4AEDB34E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB381931AC7159F2D1262F05C385F39@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381931AC7159F2D1262F05C385F39@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6fd3ec0-fb70-413a-200c-08da20e63d70
x-ms-traffictypediagnostic: SN6PR11MB3053:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB30531BAB8BC56244840B34F0E3F39@SN6PR11MB3053.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RTOvlvYGRKuoEMjblMV1MOgul4To24kk9jhd8kQkPuN5kCKIYHy2n1u3BuPJSiQPdFQNd7A4kvgYK0oOhrX2yUZ/WE7Xd7dlnRMhuirfZma864I6JEpha/dZDQGbpcpbGn0GXiM9OXmuC6FEPgY45v86KG+PtONpinKSnKxQUYlehAElFapaW3mOtNc3bgSbn6OImKjCXmBzUQ6j3ULudoeicF/Y4G6LUFvarroQANLeXSvbd/nHxdGClbtRxPsY7Ppow4In/KA2lPWMZJjFip40Lib88PhaEwPkojdV5z6FM4PoM2uK+9ycemdR8HUMv6Sk/RtzFIZzgkZDk5FrdtSUMw6ZI+3Tn066rqqzy50qC0CqZ0+aJdxq5ziUhw+MBcvYH4+Bc1/Z7eRro8M4OZXYRyM0/04sWWYQtaVeZVQzfS6m1uZ45US3Q6X42K2juosF0dVlUT5giyfOMwiIThV7sbsfr/a6OHHjwNngMSI1V6AXtkKHzCP+SbPf77qcp3vygnu5rxM5TYVWZBwmTifL/gDTLMhpyDZVIvy+G1C61zv8SmvhxnVuXfLtoZdb6T5pAOlHi0qGjxpz7m3LmNxvUQZg+IRHo5crJlbWANTRfR/LsSOwLwRW3N2AW15E+NUPco3TuUcIIVsqEc9sQiOw3TWATLfLbq8AZnVv8TblVq8xH8Y9B+re4sqiPi6+JAKMYf+n7bbwCIXrbWaMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(6636002)(71200400001)(53546011)(33656002)(7696005)(6506007)(54906003)(8936002)(316002)(5660300002)(110136005)(508600001)(86362001)(83380400001)(122000001)(52536014)(82960400001)(2906002)(38070700005)(38100700002)(8676002)(4326008)(66556008)(26005)(66446008)(9686003)(64756008)(66476007)(76116006)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RUp0w9pT3pieqVu2ovR9JuB2C8iyIRcdeciIZvomz5q/xSgrUCCWREs8N3A/?=
 =?us-ascii?Q?6jyi9ztYxy0Eyz3/oHH+0I2fhVibgz+8QMW3u3Ds0HM06YGh7B6/IZ7bGFfM?=
 =?us-ascii?Q?eMxMH1aF3k0WcMhQXFOHagu7xSX6cfkOWg1MBvxg23zUJqw+OqYnCdRmURlE?=
 =?us-ascii?Q?Hc6VK0LmnkIsSMxWRmk2Gd/1mBVEXuqJf730gXaQiK/sAYMCRun3jT+x0fJN?=
 =?us-ascii?Q?w3lxSQ20E/VuQiBTmgrIzP8jMjxRZTfAAjjjQC9fuUFSZr0Oj/m/h9+A9Y6w?=
 =?us-ascii?Q?AHyXsGEpM5T99zq6LvJ1v7FF8reCEjpWMJtMIoWufdkoVrabClXp80tUTNRS?=
 =?us-ascii?Q?UpPCbLiYGt9ZaTABYWtjpW7zd6ThVfKMjOJcoL1/akhxws6eSB5f/BshZRsp?=
 =?us-ascii?Q?qg5ts8blENR62z/0inDcU0nnWbp6zvjSvaJuNOUBAVdgkdtBH2ffAELIFfuk?=
 =?us-ascii?Q?N0CVGVk0DWdR6cSSSIsfdTNngRUcNcbmGqQLHXfyKwLUErkmbfCaUFyT7wdv?=
 =?us-ascii?Q?io5yE2meV1X6Lh8G0Edz5Ys8MwCjfCX0af1YxndjK+5nTaKzXjbZfM1UGUJ9?=
 =?us-ascii?Q?h7qm5mhfga3QG63tdJIS+MgRlRhzHqJ+9ZeRu3kATshAuZNOVJu7V2i483hL?=
 =?us-ascii?Q?UhOjrNeMHtGk27CDgxq2+HljpxqnmO8reEQWKKEPqMRyU8+H5y3VzkuIyOJZ?=
 =?us-ascii?Q?eD6Ws5Mjh6sQx1K/4AhiZr0tMcKgXol5XiRZbo0ER6csjlVZ2gKz8y7r1UdA?=
 =?us-ascii?Q?1CofUXtNHg7irV7Cz2e5jNKE5VSJ8X2trvT7xlZXruLpF7h5STOREkhPVlid?=
 =?us-ascii?Q?wjp9aN4uyVnolrQPbiipThjPQGsLbm4Q3MWNL5enkeTQ1W12J/vJ1Y7Crj8K?=
 =?us-ascii?Q?EgNii7N9gzrZ4HtCrJA6KqqhWMnmx5Gw9y1Qd466CLO2kA9jBUYGaL8ooSmR?=
 =?us-ascii?Q?XsKPsQnYWW8ZHU5Qq3nZw6zGvZNLvDw63wHrWETMqIdJuuOppxD5K9JRxPoy?=
 =?us-ascii?Q?YvLUUf97uA/jIyMosq61CFGuVm7iyFloA0T27D+AXsCAKMjRQa41nnQvRDyU?=
 =?us-ascii?Q?44at9xoRecceXydhPFsS/mJDSM3Y1f7TQjlVbA7m+H0u1po/Cmh6taFiGg5n?=
 =?us-ascii?Q?UMuUnQviWZVsl+d0IZ4HACYxCUxdUuWYegtcXG7fRRjXchEkjitImtEOvbsG?=
 =?us-ascii?Q?vv6DGXXvNqOkjrFWULLSl5WSvRGV6hWQU/7a5yUODhNcXrz0QVUpnr6nWKI6?=
 =?us-ascii?Q?22bqVS5GN4tA7HijHZYMX0Jn3EegCrFF/u5aHB+z7htoBPiau+jJNqIqUBPK?=
 =?us-ascii?Q?xnK/2s0wEgtAgyu6p5dHdm222+Z025rPncBhw4R7BbV+mqY87avQPzvikcM7?=
 =?us-ascii?Q?6MsJZo4gxz5wQpKwdB9h3Q/aJN11MwCvxX66ZneK8occ2Jwn+UhOUdP/fieP?=
 =?us-ascii?Q?QoNasnxvaRnaSVOTh/zPkJYZOgD1mOOilXBIDZM1/xc/+VOtHdA0M9c4xftQ?=
 =?us-ascii?Q?CuyKf6ZjsG0PBDPNvpdT0jnRQyh+el5efjQ0qsTrFTF35djSPBd3vWy5kxHe?=
 =?us-ascii?Q?vdax8oSV9UORHNrMYj6ufbXeK1F9UVuxwBHk872MAxU7ozZUjuqtOa/j8CFI?=
 =?us-ascii?Q?/8AjjnnPunVInee9nytFUvGvQnJqfzdJveVA+2ChOFr5z0ID/o/CYXhabtMr?=
 =?us-ascii?Q?5RAtLFMru/SR4hMvyFv+sxxrPd/R0kTgvW+g0XXCtR/WVp6MCVLGoSkI9h/4?=
 =?us-ascii?Q?qewRKn74rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd3ec0-fb70-413a-200c-08da20e63d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:50:47.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1OSS/HTx937kK7KycxQ8L7/dW8DCfC+LMCmbm5Pi7ZOMb0PFS9Nq/KeSzFjPfZJ9MixFHxHDBYkVQ0zqzZTUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Monday, April 18, 2022 9:52 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Xu, Yilun <yilun.xu@intel.c=
om>
> Cc: trix@redhat.com; mdf@kernel.org; linux-fpga@vger.kernel.org
> Subject: RE: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision=
 of
> FME/Port error
>=20
>=20
> > > -----Original Message-----
> > > From: Xu, Yilun <yilun.xu@intel.com>
> > > Sent: Saturday, April 16, 2022 11:53 PM
> > > To: Zhang, Tianfei <tianfei.zhang@intel.com>
> > > Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org;
> > > linux- fpga@vger.kernel.org
> > > Subject: Re: [PATCH v1] fpga: dfl: fme: adding reserved bits for
> > > revision of FME/Port error
> > >
> > > On Tue, Apr 12, 2022 at 02:35:23AM -0400, Tianfei Zhang wrote:
> > > > From: Tianfei zhang <tianfei.zhang@intel.com>
> > > >
> > > > There are 2 different register layouts for FME/Port error registers=
.
> > > > This patch introduces 4 reserved bits (Bit[59:56]) to indicate the
> > > > revision of register layout for userland application.
>=20
> Please provide more detailed background information to explain why we nee=
d
> this.

The background is that it is not a good method that it use one sysfs node' =
value to determine the usage of other sysfs node.
The sysfs node should be has a persistent value or usage.
In our previous patch, we provide a "revision" sysfs node for user applicat=
ion to get the register layout information while paring the FME/Port error =
registers.

>=20
> > >
> > > Please specify that the 4 bits are reserved by HW so that SW appends
> > > revision info on these bits for the attr readout value.
> >
> > Yes, correct, I will make the git log message clear. How about this
> > git commit
> > message:
> >
> > There are 2 different register layouts for FME/Port error registers.
> > This patch introduces 4 reserved bits (Bit[59:56]) which are reserved
> > by HW, dfl driver appends the FME/Port error revision info on those
> > bits for attribute on the readout value.
>=20
> We need more clear information, why we have 2 different register layouts,=
 and
> why 2 different register layouts requires 4 bits in HW, or even 4 bits wi=
ll that be
> enough?

The old production like PAC N3000 was used the old format, and the new prod=
uction like PAC N6000 was used the new register format.
The new register format will be more reasonable.
The revision in DFH register was 4 bits width, so we reserved 4 bits is eno=
ugh.

>=20
> >
> > >
> > > >
> > > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > > ---
> > > >  drivers/fpga/dfl-fme-error.c | 36
> > > > ++++++++++++++++++++++++++++++------
> > > >  1 file changed, 30 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/fpga/dfl-fme-error.c
> > > > b/drivers/fpga/dfl-fme-error.c index 51c2892ec06d..3b54470f56ca
> > > > 100644
> > > > --- a/drivers/fpga/dfl-fme-error.c
> > > > +++ b/drivers/fpga/dfl-fme-error.c
> > > > @@ -39,6 +39,22 @@
> > > >
> > > >  #define ERROR_MASK		GENMASK_ULL(63, 0)
> > > >
> > > > +/* Bit[59:56] was reserved by software for error revision */
> > > > +#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> > >
> > > This will change the user behavior for the error interfaces. Now
> > > they need to recognize the revision bits and discard them before clea=
ring the
> errors, is it?
> >
> > Yes, the end-user write to those error register without this revision i=
nfo.
> >
> > >
> > > How users know the revision fields in output values? Maybe it still
> > > involves change in Documentation/ABI/testing/sysfs-platform-dfl-fme,
> > > which should be reconsidered carefully.
> >
> > I will add those info in sysfs node documentation.
> >
> > >
> > > > +
> > > > +static u64 set_error_revision(struct device *dev, u64 value) {
> > > > +	void __iomem *base;
> > > > +	u64 dfh;
> > > > +	u64 revision;
> > >
> > > Better we follow the reverse xmas tree declaration, so reverse the 2
> > > lines please.
> > Yes, I will fix it on next version.
> > >
> > > Thanks,
> > > Yilun
> > >
> > > > +
> > > > +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > > +	dfh =3D readq(base);
> > > > +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> > > > +
> > > > +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision); }
> > > > +
> > > >  static ssize_t pcie0_errors_show(struct device *dev,
> > > >  				 struct device_attribute *attr, char *buf)  { @@
> > > -52,7 +68,8 @@
> > > > static ssize_t pcie0_errors_show(struct device *dev,
> > > >  	value =3D readq(base + PCIE0_ERROR);
> > > >  	mutex_unlock(&pdata->lock);
> > > >
> > > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > > +	return sprintf(buf, "0x%llx\n",
> > > > +		       (unsigned long long)set_error_revision(dev, value));
> > > >  }
> > > >
> > > >  static ssize_t pcie0_errors_store(struct device *dev, @@ -97,7
> > > > +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
> > > >  	value =3D readq(base + PCIE1_ERROR);
> > > >  	mutex_unlock(&pdata->lock);
> > > >
> > > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > > +	return sprintf(buf, "0x%llx\n",
> > > > +		       (unsigned long long)set_error_revision(dev, value));
> > > >  }
> > > >
> > > >  static ssize_t pcie1_errors_store(struct device *dev, @@ -133,11
> > > > +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
> > > >  				    struct device_attribute *attr, char *buf)  {
> > > >  	void __iomem *base;
> > > > +	u64 value;
> > > >
> > > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > > +	value =3D readq(base + RAS_NONFAT_ERROR);
> > > >
> > > >  	return sprintf(buf, "0x%llx\n",
> > > > -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> > > > +		       (unsigned long long)set_error_revision(dev, value));
> > > >  }
> > > >  static DEVICE_ATTR_RO(nonfatal_errors);
> > > >
> > > > @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct
> > > > device
> > > *dev,
> > > >  				    struct device_attribute *attr, char *buf)  {
> > > >  	void __iomem *base;
> > > > +	u64 value;
> > > >
> > > >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> > > FME_FEATURE_ID_GLOBAL_ERR);
> > > > +	value =3D readq(base + RAS_CATFAT_ERROR);
> > > >
> > > >  	return sprintf(buf, "0x%llx\n",
> > > > -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> > > > +		       (unsigned long long)set_error_revision(dev, value));
> > > >  }
> > > >  static DEVICE_ATTR_RO(catfatal_errors);
> > > >
> > > > @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct devic=
e
> *dev,
> > > >  	mutex_lock(&pdata->lock);
> > > >  	v =3D readq(base + RAS_ERROR_INJECT);
> > > >  	mutex_unlock(&pdata->lock);
> > > > +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
> > > >
> > > >  	return sprintf(buf, "0x%llx\n",
> > > > -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> > > > +		       (unsigned long long)set_error_revision(dev, v));
> > > >  }
> > > >
> > > >  static ssize_t inject_errors_store(struct device *dev, @@ -211,7
> > > > +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
> > > >  	value =3D readq(base + FME_ERROR);
> > > >  	mutex_unlock(&pdata->lock);
> > > >
> > > > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > > > +	return sprintf(buf, "0x%llx\n",
> > > > +		       (unsigned long long)set_error_revision(dev, value));
> > > >  }
> > > >
> > > >  static ssize_t fme_errors_store(struct device *dev,
> > > > --
> > > > 2.26.2

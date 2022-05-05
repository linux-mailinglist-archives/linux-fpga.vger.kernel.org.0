Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41F751B834
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiEEGup (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiEEGuo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 02:50:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665734739E
        for <linux-fpga@vger.kernel.org>; Wed,  4 May 2022 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651733226; x=1683269226;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=E8SFylo5VesnkCS4dMzbwwPmzfJoX0AeJCwj9I3d2lg=;
  b=IszyFS8v0W2DQkOY6cZbNfJn+oQSRNQ6nePOyONRBkP6S7lBT8asqDPD
   oyC3m3e5N/EZPevLYuFn+HTLx7m3HJG2rucJGHOJHOFoPtk1PYtkox0Fo
   PdEe9GYCY/80N659rtrnUrCygjj+XBjXKXpNM5ABoFRNaDDlTlOIZNM6w
   tLDP4PZXeHMerofgHZsANA00PA7oXS6/sVc+BE8ARVmZacl54Roz6c9hb
   K/SN0A/PLmjOy7gfxB2EW4b4PE5OMo+v7Kwve/CI4e7Qa4HeYzCxavQk6
   v/X5i+bt/snbd4D2Mcch6Z/OYEnod9fyV3u6LWSGmynsi0LV9k1lijGb3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="331009151"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="331009151"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="694530320"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2022 23:47:02 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:47:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 4 May 2022 23:47:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 4 May 2022 23:47:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 4 May 2022 23:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuVq2W0bSp0egN5q+7OaUi4Qgh1/8vVEu2rO5sJ3rRVdc4+DSCJ7NJgm4izHwxU1mPYggSqXg3h6HDMYpfHFX7HY9+9jfZQux7AwWVihLTrpII/l1YW+PCwilbAjSFkwcYA/w4MsRCJlkUuHkHvi4O9BnhDCPFrkl3eScBTLNBmXKAR/qgzv07WCJsWtvTUgLwsDNPc/vnLi/lZNOSBXD04ABE1MxQBbfpbehqPmIyjpVCLDQZ1gtnTd/bvDoFuXknACsQWaH86FGK5nRkL7bvfon4+pxxZINE2oOnfAOwNT7lX3AyxqdLaPhNx8+sbSJoancU5IvA2AN08rVb3ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70jNvaseHtzXwSYq+6QzH9QVV6dBKdjcuWtW5wFt/fw=;
 b=INGd6SULMZUNMINkyt763VlWOng2ZvjKnwqsDxidqQTxEItddr0TyYA74XmdolL7EGHQPkpWNWGQAoPhmYWOYXpaeCoOIrYXzjBtAhskf5sT9AgGTEIBDsDvhZZkdmCXOazDhiEjHuKvADbWzSzRs8bEwARr7cjWehcjQK4Gt0BO6JV1hDSL91YNJcRJznZFWJWhYqfsQWb1tsEAB9D/LY2z5jidSTHWP43fH2FQJALNXUPO2veZGXjxCBSd1XyDQMu6nJUjVnF35bGNVkgNn9C6AJl6GtgfR6NAitUABEqZHXT+akJkvFfW5din0vc39GbMAiPxIDj0ney7F6BESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by SN6PR11MB2656.namprd11.prod.outlook.com (2603:10b6:805:58::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 06:47:00 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::4838:60ae:b637:3fc0%7]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 06:47:00 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYU5qxOJ39GLsxhEWnWFYmGxa/460P7qCg
Date:   Thu, 5 May 2022 06:47:00 +0000
Message-ID: <DM6PR11MB38195D7FDC316CBDEA55D91A85C29@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220419030357.410495-1-tianfei.zhang@intel.com>
In-Reply-To: <20220419030357.410495-1-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 416b7d8f-f5e0-4f92-ac0f-08da2e630e2c
x-ms-traffictypediagnostic: SN6PR11MB2656:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB26565ADEFE5F307F23A8485E85C29@SN6PR11MB2656.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsnYbntg28lhicFMQ7HH2OEEFXK564CCuNlYte+zTq9pszKl40x1KsCOttfFjePmCxC1bBBN1ROR8Q+/8vZJojVyTIIdFWt4vYgMYiUYTwEYYLIGLE2fxZ0luIWY6SHCj56nidANpZfnNkUHV1FfDv3YLtDiztaLklwL71K5plmOit3n4NMUSNdtlpTu5eWLPYtW2GLyelttmWBrc2DsUd4FZwyDL3+chgQY2dBCcWvt1oV24Mfn1tAt1hxtcmA6VI1/w7Ut3L0cPAQ1EJ7bq1OJKhEQZbRsPTltYXQ83qMz2SK1lzBVKF4E26quEbrF9R2GkNN+tl4NOAeRjZv7Vc3iSuzY9ewxXwsr+X8/S0HV2Jz4nsGT+0V7ko8hpjigm+Rbl/fbONmCYuyTTn7vBO7TRkDza+YtHsXJqxq02rmmAoqH0QliKpONO/xA35yUt9U5Ysk3CnWx4+vTLFuNi9v9cZuZRBWWKYEVhgpyIC1d0CuF0jODpNsJKdGySSvrNrXycJbYUd2w6E6wHbZkFiu3MoJrkmvcmts/sFvVPz4ZUeAe+uyTRTw+SpQg6hKT231SR8eukse9MLuXSnd7RPfSGSCkkI/DK5oYQnHrp7AFUe5tyNZ2iu83agpwNGmornJZURellhZfNyfWTiz3RBvAaIYKVV+LJ/TWZZC4ZbAC+skGFzFqKOk+iwRoRe5ZVhGPGOZi+1I8AggCmUWtAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(8936002)(55016003)(76116006)(82960400001)(83380400001)(508600001)(26005)(52536014)(7696005)(2906002)(64756008)(8676002)(66946007)(66556008)(33656002)(66446008)(66476007)(110136005)(86362001)(38070700005)(6506007)(122000001)(316002)(53546011)(186003)(38100700002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aiTydRB8URbj2z9SP34nupclSceY4LvFpBW+hr6hPp3PWl+BIESP2uR4V8FU?=
 =?us-ascii?Q?SQFaOXxjXqjmC70zS9u+UST9iPENrAv/QEJHdnV83/d/y+QlV9yP8cZRsdcb?=
 =?us-ascii?Q?bgqLVmXWT6uBvmw+61mX/rJkzi0/kETC5qpwdQquz0JDCI6O/M6beQ9/Y0CV?=
 =?us-ascii?Q?fj/FQlLQal6c4EsHfDEKCyRCpU5mPmun1MJC5eqrPIb6KDZg5O6Bm6evY0GT?=
 =?us-ascii?Q?bI9xTegfUF0wuGtwRNwRfqlcAm2v8wK/ucSO+AF33OZPwpjXNeW6rNWFVFZO?=
 =?us-ascii?Q?IyKVdt7GlnKvi5LLza1dy9leVRndv7XsCUvVwgJpbPKVw2hEsnPy8wSGX8ua?=
 =?us-ascii?Q?UT01jhRExqmLAOQpA+emfZP3oFQDcLOZcnWmzPy8pyt1PgfruZ1MBSfn10C2?=
 =?us-ascii?Q?9kl6/tEvQGNXElB+boUtlnvll0B+UetWIF3Svkuz7hAS9wcHKIM+Xoum/AaK?=
 =?us-ascii?Q?ww1BOhoOj0wEe5BjF+Eb/X6vOLGfr7r4KBwGUvFottIQZ8k3wepV3XZZQdOO?=
 =?us-ascii?Q?4P5CV9bgDvKhjVM9LO4lKrDPw5Dm6ptp3yXmiA85zEBTE5U8sisdg8ARUzg6?=
 =?us-ascii?Q?4b4DSp5m+BIVhO+oqPwvSgcgP7FgpwCocsESJBykU8Ho3P4FXUZhujkzeE57?=
 =?us-ascii?Q?yKi5v3fqfGDzPCbyKVvmAZ0ksoJ7maH+5YdihamYB+Bt31ez2sJewEe0l9Pp?=
 =?us-ascii?Q?8tuCUiq+2HYO2eQeDdVlJpxABNyU9VjiEBqZz5uxnBZOl2m5MRIqDKZ95Jal?=
 =?us-ascii?Q?FLrav8pZj/bCvwWRm5HWv0PGXYJSpoxC0uoASPJqZTKDOUIrEWrlZjIhy8F7?=
 =?us-ascii?Q?v1X63MwYYSbFMRcNM6oBjo+ODsel1G66XLYkcRM4tBkoaiuw2CoVbaWkEP8T?=
 =?us-ascii?Q?VGi/WLuLJI99wo6UVDRrXW0oiw9Q95rKPFDSWsG0fR729NaeaErLEfuW8NTP?=
 =?us-ascii?Q?Txx5u887sjnqM17j4m/MDQXEb6tAInCI0358OH9mYSQ1DIlWvpKOt5TUXbhM?=
 =?us-ascii?Q?aDrz+BF0ZAs0tsNEjG9+RK/HMzmBQsr85oLuDzdnSOa0/b5gPEzVXomiv8Es?=
 =?us-ascii?Q?OgEppj4ne4hqLckEsrGljd2/tIKJoK8sg3oaA0QIG/l55xm3vPbJ3oTYFO6z?=
 =?us-ascii?Q?TqUhZkGYT0OGtgJryGg6kh+CXlgfWj8YGN135SP4YaErbTBl6270LPXoV8Wq?=
 =?us-ascii?Q?tuVswYvh3qTrLLuVG+d+Y8E5h2MQGJqLdSLtdLMY62AkuksBJRc0Tl1QtoiH?=
 =?us-ascii?Q?bWoGert5gbi9+2oEBonaoieYxj/8P7OGslG1+OgbPgFtN+gclNatvqi7USsI?=
 =?us-ascii?Q?4efsXZoskGw6rVLf5+70p7kzpVlTrg/b9jPycjMWNrQaMbFkMkmStp/mYpmt?=
 =?us-ascii?Q?yb12xU3MIXC68Py++5TrH7gGXYxTqBfYqnaeQ6gL+btTKt8ywtmyY0dIafLL?=
 =?us-ascii?Q?AwApi9dd9sOfoRKWwSV5zdDkwH7OSat7tkqRFSW67NBa2uE/qhBefK+5w+aO?=
 =?us-ascii?Q?GGCoRGMosGrYKOgQ+8LZgn+wrHMVCPIPRGk0Au+41cTM7Cfr3ZzdcqoR1Pmw?=
 =?us-ascii?Q?cHyyu0FZzesKU6+A2f3nfFhPlzA7w5aS1f5QD3njkMKth5n1ECPc+Rypr2KV?=
 =?us-ascii?Q?ql+OmC+FzvXtpJ5hjGkbOCSR2loHDB5PNjMvEp6BGR6o5d+crRzxu83chy2b?=
 =?us-ascii?Q?vsSP6YYI2B7TZULRIuTolH2PGBG7s2v3E8zPmgtAgCZ3D6S0Fy8xK8/3kshd?=
 =?us-ascii?Q?EI6HdBqfEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b7d8f-f5e0-4f92-ac0f-08da2e630e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:47:00.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LajXL7uDBon59KBDdf95q7YUuU6Z4A+yvBvCYPlAHCPafn2ehAJcYDOVJh9lIz/ivanURHIOh4IbrSbS3z0mZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, April 19, 2022 11:04 AM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>
> Subject: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of =
FME/Port
> error
>=20
> From: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> There are 2 different register layouts for FME/Port error
> registers. The new production like Intel PAC N6000 plans to
> deploy the new register format which it is more reasonable.
>=20

Can you explain a little more why there would be different register
layouts? There will only be two layouts or more?
Intel PAC N6000 "plans" to have new register format? Not finalized yet?
So anyone could define its own error register layout, is my understanding c=
orrect?

> To distinguish the register layouts,we provide another sysfs
> node for revision info, but it is a bad method that using one
> sysfs node's value to determine the usage of other sysfs node.
>=20
> This patch introduces 4 reserved bits (Bit[59:56]) which
> are reserved by HW, dfl driver appends the FME/Port error
> revision info on those bits for attribution on the readout
> value.

Will UUID be more reasonable than just 4bits value? If we=20
consider this is a FPGA, anyone could implement its own
error register layout, then just reserve 4bits will not be
enough? I hope we don't need to modify the code and
design again...

>=20
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
> v2:
>  - add documentation for this change.
>  - fix the reverse xmas tree declaration.
> ---
>  .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-------
>  drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++---
>  2 files changed, 54 insertions(+), 19 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index d6ab34e81b9b..b886568d6071 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -50,46 +50,57 @@ Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-Write. Read this file for errors detected on pcie0 lin=
k.
> -		Write this file to clear errors logged in pcie0_errors. Write
> -		fails with -EINVAL if input parsing fails or input error code
> -		doesn't match.
> +		The readout value has embedded 4 bits revision attribution
> +		in Bit[59:56] which reserved by hardware. Write this file to
> +		clear errors logged in pcie0_errors. Clean Bit[59:56] before
> +		write this file. Write fails with -EINVAL if input parsing
> +		fails or input error code doesn't match.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-Write. Read this file for errors detected on pcie1 lin=
k.
> -		Write this file to clear errors logged in pcie1_errors. Write
> -		fails with -EINVAL if input parsing fails or input error code
> -		doesn't match.
> +		The readout value has embedded 4 bits revision attribution
> +		in Bit[59:56] which reserved by hardware. Write this file to
> +		clear errors logged in pcie1_errors. Clean Bit[59:56] before
> +		write this file. Write fails with -EINVAL if input parsing fails
> +		or input error code doesn't match.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-only. It returns non-fatal errors detected.
> +Description:	Read-only. It returns non-fatal errors detected. The readou=
t
> +		value has embedded 4 bits revision attribution in Bit[59:56]
> +		which reserved by hardware.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-only. It returns catastrophic and fatal errors detecte=
d.
> +		The readout value has embedded 4 bits revision attribution in
> +		Bit[59:56] which reserved by hardware.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-Write. Read this file to check errors injected. Write =
this
> -		file to inject errors for testing purpose. Write fails with
> -		-EINVAL if input parsing fails or input inject error code isn't
> -		supported.
> +Description:	Read-Write. Read this file to check errors injected. The re=
adout
> +		value has embedded 4 bits revision attribution which reserved
> by
> +		hardware. Write this file to inject errors for testing purpose.
> +		Clean Bit[59:56] before write this file. Write fails with -EINVAL
> +		if input parsing fails or input inject error code isn't supported.
>=20
>  What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
>  Date:		August 2019
>  KernelVersion:  5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
> -Description:	Read-Write. Read this file to get errors detected on FME.
> -		Write this file to clear errors logged in fme_errors. Write
> +Description:	Read-Write. Read this file to get errors detected on FME. T=
he
> +		readout value has embedded 4 bits revision attribution which
> +		reserved by hardware. Write this file to clear errors logged
> +		in fme_errors. Clean Bit[59:56] before write this file. Write
>  		fials with -EINVAL if input parsing fails or input error code
>  		doesn't match.
>=20
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..a440bc09938d 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -39,6 +39,22 @@
>=20
>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>=20
> +/* Bit[59:56] was reserved by software for error revision */
> +#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
> +
> +static u64 set_error_revision(struct device *dev, u64 value)
> +{
> +	void __iomem *base;
> +	u64 revision;
> +	u64 dfh;
> +
> +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	dfh =3D readq(base);
> +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> +
> +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision);
> +}
> +
>  static ssize_t pcie0_errors_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> @@ -52,7 +68,8 @@ static ssize_t pcie0_errors_show(struct device *dev,
>  	value =3D readq(base + PCIE0_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t pcie0_errors_store(struct device *dev,
> @@ -97,7 +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
>  	value =3D readq(base + PCIE1_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t pcie1_errors_store(struct device *dev,
> @@ -133,11 +151,13 @@ static ssize_t nonfatal_errors_show(struct device
> *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>=20
>  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	value =3D readq(base + RAS_NONFAT_ERROR);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(nonfatal_errors);
>=20
> @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device *=
dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>=20
>  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> +	value =3D readq(base + RAS_CATFAT_ERROR);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(catfatal_errors);
>=20
> @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *dev=
,
>  	mutex_lock(&pdata->lock);
>  	v =3D readq(base + RAS_ERROR_INJECT);
>  	mutex_unlock(&pdata->lock);
> +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
>=20
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> +		       (unsigned long long)set_error_revision(dev, v));
>  }
>=20
>  static ssize_t inject_errors_store(struct device *dev,
> @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
>  	value =3D readq(base + FME_ERROR);
>  	mutex_unlock(&pdata->lock);
>=20
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>=20
>  static ssize_t fme_errors_store(struct device *dev,
> --
> 2.26.2


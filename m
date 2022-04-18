Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EB504A62
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 03:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiDRBRq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Apr 2022 21:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiDRBRp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 17 Apr 2022 21:17:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49913CF1
        for <linux-fpga@vger.kernel.org>; Sun, 17 Apr 2022 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650244507; x=1681780507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z47sCnTUtamDk/oKD2kykxhrw+4MAJEykJf7ZmIXBps=;
  b=X2VW60nAL38reWfNk7cKcb8iiNpN1PQx6yxhF77qNRXD1AYEM8toVPsx
   DIWV27KBbH3mMnjVWBdWeBdv9c/lufxKlSPyKPlfFpCc0dO+y/lykkeJi
   p7EIKA28T2hn+1sMGxkXX2lfhim+u+SlG17RekNNXAV7yFEU7hCDFAeLj
   4Tx/cdCEdMTm9XTg/iYmm0e8xbFsEPTunByuCBJUXOvdFVMu8q/vrYyhY
   hTUny1UjKWnJv4d9Ugffw/QNtMQcDkpDw6v6JJeivJz+UiQub7K7Y6SA+
   xIMGYl7QAjKqTGSQCo+JwvUyMNdRQGtUtYlbiFkDS4Aoivfkzyg4tc0mh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="250730490"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="250730490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 18:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="859610817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2022 18:15:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:15:06 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 18:15:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 18:15:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 18:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsgZ12um/pxk2OWF4KZrrkrV+oiGb80FXF/yepfYf+nYMyqZlY6To4twUFDz62Z0T2K/oeiIfFeW9A/Fwu+YEvGjt9vz/1redeRoKa5gJunEMJIakFFODP/YoqlT6v/V/wjr/FwjzvTWe+g6+KWbUJpxPO3kj/DuKwmRcVc+3PFxaAMmFzP5l47h3d8Ab9n9+XPwBuJFRHE4LLab3W2sY+fiL3sKDc2yEI/FG+BPhZPzZLge7DCzq+KUGjZlWYlqWqbS8s/aJZinWdHqYhBbMgbOgEzxsUfwh7ehQT9WmEhb+7rqzoYk1gi886NmYkGdzMSO5W4n8hS9qTDZrBfYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84/pWYvs9gV4Hsq64LSpR9T0RnfhyqYAAXxZe8YgL6k=;
 b=YJ0MvZ7kn5eCVe0QhDCqPIQYAuD4aycogxaf7E1rdavN65U7IuFrpEg9EZGh9dmmGdIF77FJkjKSmiIAaWju5fruQJTGTALw30wB+lRwPx2+Js6n8sq6IqVdCHzBBYE33TB0rDMnhfv1t0eyE17X/1NS1vBo6Kdm3Qp4gWYXu39UiSOGCM4+pRQCZPTAsHKw5pBD7wwp6ipi/s039D4H8Qc/CBB2pNe8rJvNgMhtv9g0ttvLjFQvsBjiB3gc+g0As3waaP8cobQrxULO/Jah3MAKHNNotnqQAd6ZR2I89/9n1tcXJtg+gQXLgOAb/yqAJjVmnzz8dP2W309A0WDC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM6PR11MB3321.namprd11.prod.outlook.com (2603:10b6:5:8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Mon, 18 Apr 2022 01:15:03 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 01:15:03 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Topic: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Thread-Index: AQHYTjf3U79tFgn6Ik+Ohp7VUNfX56zyt6YAgAItQBA=
Date:   Mon, 18 Apr 2022 01:15:03 +0000
Message-ID: <BN9PR11MB54833E8D5E0853DEC4AEDB34E3F39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220412063523.54587-1-tianfei.zhang@intel.com>
 <20220416155258.GB301222@yilunxu-OptiPlex-7050>
In-Reply-To: <20220416155258.GB301222@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 62986326-df1e-42b9-63f9-08da20d8de24
x-ms-traffictypediagnostic: DM6PR11MB3321:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3321729F02ED9D0F1DC32178E3F39@DM6PR11MB3321.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 23SL50Xkrt0ShGZKpa5n3lWngq/hZjMBKiVPBTFhFsIbLAv+yi0U+Edb9BFgyZOaZqfLNtJ+bchOEV5JvC9o9tX0AZXsfMMj0uJO75U0yRIG977p99EsGRl46fK0yunXs6CUQ451N45bU002XUOjoASyT1dVBiLZMMsawqJQhjFGzuCkvfYp4tsWtMT9Xz+84V32y1azVCbnZHpwq2pju8FYC5/na7DTE12w04X4S+et0WsXGyKJ4JPBgZE2taeZx7I22XwI3aoYF5MTT4I/MjZpaI19dvus4DgjvF84npJeXbtWA355+niU0Kv5ToRaZbI3lVvrVyYGTu2r34BQ0/ed1RKHdovE4YleRx7rLziIy/EYP16gkWjcL7mMN8FqHx1FRcbC9QB+OxpjlU3YvR78323Id0ANFUVPDhmU5IpDm5DlE8tjtp0vcrKcx5ltIfg5/5kqKTgjoUNRYzBBMlZLSPB+GjeIot6Cx+3NdYPNEIR7tyGq/dzf0SH0h6nUvk8vJIj2BwwljWT2K0ccitKbLGnUS/sBNBt27cZSQHSz690z6GIvLjd+PSnGXqsecgDy5jBtPvDdhJIa5IttqB048y47Nn+NjPJt9zXKrN0UEdSBdBrCgNT9G3P1dVX2SeRfwgXGbVH2XQW6eTCsRIKem9BgPEuyuuiMTTh1+elAGT8m3Z/HNLPs/GagmNPrAh8Ja4a4c2VG7GVTWD27Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(82960400001)(316002)(8936002)(38100700002)(55016003)(54906003)(5660300002)(33656002)(9686003)(53546011)(6506007)(2906002)(186003)(38070700005)(122000001)(508600001)(26005)(86362001)(52536014)(71200400001)(76116006)(8676002)(6862004)(4326008)(7696005)(66556008)(66476007)(64756008)(83380400001)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hF3PrjJrjgJqOMKycUN+wyExim5lN3gDSyw//kzWxUYjzuEZIKiYWS7O2C18?=
 =?us-ascii?Q?QQ7E/ICuPRJzmzmGN9BdcO/mr85GIE4J6kg29gMx6A76hrSrTfcpxo0NlBf1?=
 =?us-ascii?Q?VUTVIjA2AMlUGxDVtTOT42DUxG31y7cmV1zD3uuyUxMwCqzMKpYVA1RDgNZh?=
 =?us-ascii?Q?GMEkIIsMzBJ7WgEQEaJ1cwUCuI01pWqn5I1NRxY2IjXTUbFp4gkflBqr25T9?=
 =?us-ascii?Q?3C/SOmEYO6dz6H8x8XSoEajfp6eUDTWzRMNCHiqEA8sJEgga5sL1hOAC91Ji?=
 =?us-ascii?Q?BUpQNt/vyMlYxVXYD+XCGaJih2A2LjN5kUbmO006LvBuAVV0oLeaTk5yxwtt?=
 =?us-ascii?Q?+7B1TgTyRD00QWdjY0Cz5i8MlVilqG4/48Z/Xk5+sULKDC4w3LtPhfgIgY3c?=
 =?us-ascii?Q?Zl9xUOTgyrKF0+0qTW0+6eU6BcRVT7bPkUqsFuYIMWoEIF0Gu9vRoA804MH0?=
 =?us-ascii?Q?B6aqDgQy5fv34+wMgTYIvCJoxOkV/yG0sHyL9eFK17QDEDYTtcbyT8YQe9+2?=
 =?us-ascii?Q?wP0s3CGJh1GUg0cf8NTQvYgLAxuzlEJa9E45sHOBU2E2As0iQpGjEHHqj1KD?=
 =?us-ascii?Q?iq5BtE/WDx72nsoT3Q+EZItnsXnYRonLH6ZR3WFmJ5Y7brieyb6VG1wxw6ol?=
 =?us-ascii?Q?1xpQQItBGcQPoU3WP93OhbgdRmXwC3hjl4vyjywWSb5kEE0yklfTHTvY300+?=
 =?us-ascii?Q?NshKaG5fNH81HjJByCtRHaW8aADSag6AwouonmrNzYTbsJJmXsDvC7oemz4u?=
 =?us-ascii?Q?bFf/o1Gbddknpqc3Jrs/D0Ke5HHunlbHZGkNYhZtlwp8vPUcRpHQmURSUzbj?=
 =?us-ascii?Q?u/q+ErPRQSyHBeaVH2ldGrJ/AgwgCFzRP4Cbq/rDuFRrVWq6NQecqpYRJGAt?=
 =?us-ascii?Q?KmqFlGmf5/eA+DCHY1+vhhHxRIedFG8HRN5aJNwxCg93E8DVQfZLoCZTAaJ0?=
 =?us-ascii?Q?/7XUSg5ttCv5T7xLCeCfJUja+id0/KJAi4glrda7NfvwGy19QtTMHwiTU5PT?=
 =?us-ascii?Q?zLDgSaYyfZljk01m/X2Q1PeskV2m0XiEjxwYeXbAT5UjDPeJoRV6WZKW9dW2?=
 =?us-ascii?Q?o5HDY8gfyT2rYgZRC55F4JPO5pwG0e7DN7kar0OGPXcsGvxHbh/X1Xub7v/l?=
 =?us-ascii?Q?IRnJ+Q2hOrik0pfVUpM+HWAMdJYXdJ6Fudoj+M9SQyVLUtgrWVqxz1GHjzro?=
 =?us-ascii?Q?Rsu6z21Uud6yooEnZhhOy06pGE14cqiICuBTP4EMOQ2Von2Hea2m/KPWXnLp?=
 =?us-ascii?Q?BfLIim9Oac2ezscKO+Ta1fZZiW3cKyXtZ8/iqDyAcb0wSEc/9kEx+VVZecyN?=
 =?us-ascii?Q?8F696O1ZpdNt8GbgmjUX5WlVPlONXiVKb03WkixRHNZWpEGh1XvaH6tpcu6H?=
 =?us-ascii?Q?U4t76KHunSsX5GL/iGBjWGpH8ywSNOsXvKqFLbXOHpa199i9VjZtAQDXEpiP?=
 =?us-ascii?Q?w6/c0f7kkVMXdrXxDwmD+JuK7zSA3nR2VqHsiY3g6ZCizXZ4aiawuEciLLDt?=
 =?us-ascii?Q?0t5ZvGYEkKW98h8mkl/4DMbag3LoTAXOk5mFMxZKCm3qXqMh7/MdCOSUyiLJ?=
 =?us-ascii?Q?5lNoOXMMVF5KMJE4naJLzzsLumfZ99QwV/Rw60tVATiyXaAn2KEYa3W99Ha/?=
 =?us-ascii?Q?edXa0dxn9UY/hPmuriN+PNPD2FnJKCbQHyfLAslWgbshuAzFfGJq3Qwd/VEM?=
 =?us-ascii?Q?BrlN908dj2NUZauEcJPT3nOryg3qPb8+sHus5loI6Ia64O8wmpBrs4lFBHUe?=
 =?us-ascii?Q?azqCxUhzoQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62986326-df1e-42b9-63f9-08da20d8de24
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 01:15:03.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAS4ZSUgJoMtSgHalqhErimHFUhqNSIGovJgA6Iu7pE6OvEnEao3LJjw2M7vjwgBeZX+rFH5bq+pLSdCASslbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Saturday, April 16, 2022 11:53 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> fpga@vger.kernel.org
> Subject: Re: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision=
 of
> FME/Port error
>=20
> On Tue, Apr 12, 2022 at 02:35:23AM -0400, Tianfei Zhang wrote:
> > From: Tianfei zhang <tianfei.zhang@intel.com>
> >
> > There are 2 different register layouts for FME/Port error registers.
> > This patch introduces 4 reserved bits (Bit[59:56]) to indicate the
> > revision of register layout for userland application.
>=20
> Please specify that the 4 bits are reserved by HW so that SW appends revi=
sion
> info on these bits for the attr readout value.

Yes, correct, I will make the git log message clear. How about this git com=
mit message:

There are 2 different register layouts for FME/Port error registers.
This patch introduces 4 reserved bits (Bit[59:56]) which are reserved by HW=
, dfl driver appends the
FME/Port error revision info on those bits for attribute on the readout val=
ue.

>=20
> >
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-fme-error.c | 36
> > ++++++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-error.c
> > b/drivers/fpga/dfl-fme-error.c index 51c2892ec06d..3b54470f56ca 100644
> > --- a/drivers/fpga/dfl-fme-error.c
> > +++ b/drivers/fpga/dfl-fme-error.c
> > @@ -39,6 +39,22 @@
> >
> >  #define ERROR_MASK		GENMASK_ULL(63, 0)
> >
> > +/* Bit[59:56] was reserved by software for error revision */ #define
> > +ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
>=20
> This will change the user behavior for the error interfaces. Now they nee=
d to
> recognize the revision bits and discard them before clearing the errors, =
is it?

Yes, the end-user write to those error register without this revision info.

>=20
> How users know the revision fields in output values? Maybe it still invol=
ves
> change in Documentation/ABI/testing/sysfs-platform-dfl-fme,
> which should be reconsidered carefully.

I will add those info in sysfs node documentation.

>=20
> > +
> > +static u64 set_error_revision(struct device *dev, u64 value) {
> > +	void __iomem *base;
> > +	u64 dfh;
> > +	u64 revision;
>=20
> Better we follow the reverse xmas tree declaration, so reverse the 2 line=
s
> please.
Yes, I will fix it on next version.
>=20
> Thanks,
> Yilun
>=20
> > +
> > +	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> > +	dfh =3D readq(base);
> > +	revision =3D FIELD_GET(DFH_REVISION, dfh);
> > +
> > +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision); }
> > +
> >  static ssize_t pcie0_errors_show(struct device *dev,
> >  				 struct device_attribute *attr, char *buf)  { @@
> -52,7 +68,8 @@
> > static ssize_t pcie0_errors_show(struct device *dev,
> >  	value =3D readq(base + PCIE0_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t pcie0_errors_store(struct device *dev, @@ -97,7 +114,8
> > @@ static ssize_t pcie1_errors_show(struct device *dev,
> >  	value =3D readq(base + PCIE1_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t pcie1_errors_store(struct device *dev, @@ -133,11
> > +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
> >  				    struct device_attribute *attr, char *buf)  {
> >  	void __iomem *base;
> > +	u64 value;
> >
> >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> > +	value =3D readq(base + RAS_NONFAT_ERROR);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >  static DEVICE_ATTR_RO(nonfatal_errors);
> >
> > @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device
> *dev,
> >  				    struct device_attribute *attr, char *buf)  {
> >  	void __iomem *base;
> > +	u64 value;
> >
> >  	base =3D dfl_get_feature_ioaddr_by_id(dev,
> FME_FEATURE_ID_GLOBAL_ERR);
> > +	value =3D readq(base + RAS_CATFAT_ERROR);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >  static DEVICE_ATTR_RO(catfatal_errors);
> >
> > @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *d=
ev,
> >  	mutex_lock(&pdata->lock);
> >  	v =3D readq(base + RAS_ERROR_INJECT);
> >  	mutex_unlock(&pdata->lock);
> > +	v =3D FIELD_GET(INJECT_ERROR_MASK, v);
> >
> >  	return sprintf(buf, "0x%llx\n",
> > -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> > +		       (unsigned long long)set_error_revision(dev, v));
> >  }
> >
> >  static ssize_t inject_errors_store(struct device *dev, @@ -211,7
> > +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
> >  	value =3D readq(base + FME_ERROR);
> >  	mutex_unlock(&pdata->lock);
> >
> > -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> > +	return sprintf(buf, "0x%llx\n",
> > +		       (unsigned long long)set_error_revision(dev, value));
> >  }
> >
> >  static ssize_t fme_errors_store(struct device *dev,
> > --
> > 2.26.2
